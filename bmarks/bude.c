// #include <float.h>
// #include <math.h>
#include "fplib.h"
// #include <stdlib.h>
#ifdef _DEBUG
#include <stdio.h>
#endif
// #include <string.h>
// #include <sys/time.h>

// #include <omp.h>

// #define FILE_LIGAND     "data/ligand.dat"
// #define FILE_PROTEIN    "data/protein.dat"
// #define FILE_FORCEFIELD "data/forcefield.dat"
// #define FILE_POSES      "data/poses.dat"

#include "bude_data/ligand.h"
#include "bude_data/protein.h"
#include "bude_data/forcefield.h"
#include "bude_data/poses.h"

#define N_ITRS              1
#define N_POSES             4
#define POSE_NDIM           6
#define ACCESS(ptr, i, j)   (ptr)[(i) * POSE_NDIM + (j)]
#define GACCESS(i, j)       ACCESS(params.poses, (i), (j))

// Energy evaluation parameters
#define CNSTNT   45.0f
#define HBTYPE_F 70
#define HBTYPE_E 69
#define HARDNESS 38.0f
#define NPNPDIST  5.5f
#define NPPDIST   1.0f

typedef struct
{
    float x, y, z;
    int   type;
} Atom;

typedef struct
{
    int   hbtype;
    float radius;
    float hphb;
    float elsc;
} FFParams;

struct
{
    int    natlig;
    int    natpro;
    int    ntypes;
    int    nposes;
    Atom     *restrict protein;
    Atom     *restrict ligand;
    FFParams *restrict forcefield;
    float    *restrict poses;

    int iterations;
} params = {0};

// double   getTimestamp();
void     loadParameters(int argc, char *argv[]);
// void     freeParameters();
// void     printTimings(double start, double end, double poses_per_wi);

void     runOpenMP(float *energies);

float energiesOMP[N_POSES] = {0};
int main(int argc, char *argv[])
{
    loadParameters(argc, argv);

    // float *energiesOMP = malloc(params.nposes * sizeof(float));

    runOpenMP(energiesOMP);

    // Verify results
    // float maxdiff = 0;
    // printf("\n OpenMP      OpenCL   (diff)\n");
    // for (int i = 0; i < params.nposes; i++)
    // {
    //     if (fabsolute(energiesOCL[i]) < 1.f)
    //     {
    //         continue;
    //     }

    //     float diff = fabsolute(energiesOMP[i] - energiesOCL[i]) / energiesOCL[i];
    //     if (diff > maxdiff)
    //         maxdiff = diff;

    //     if (i < 8)
    //     {
    //         printf("%7.2f  vs %7.2f  (%5.2f%%)\n",
    //                energiesOMP[i], energiesOCL[i], 100 * diff);
    //     }
    // }
    // printf("\nLargest difference was %.3f%%\n\n", maxdiff);

    // free(energiesOCL);
    // free(energiesOMP);

    // freeParameters();

    double poses_per_wi = 1;
    double ops_per_wi = 27 * poses_per_wi
                        + params.natlig * (3 + 18 * poses_per_wi + params.natpro * (11 + 30 * poses_per_wi))
                        + poses_per_wi;
    double total_ops     = ops_per_wi * (params.nposes / poses_per_wi);

#ifdef _DEBUG
    printf("energies[0]=%.4f\n", energiesOMP[0]);
    printf("total_ops=%ld\n", (long) total_ops);
#endif

    return total_ops;
}

void runOpenMP(float *results)
{
    // printf("\nRunning C/OpenMP\n");

    // double start = getTimestamp();

    #pragma omp parallel
    for (int itr = 0; itr < params.iterations; itr++)
    {
        #pragma omp for
        for (unsigned i = 0; i < params.nposes; i++)
        {
            float etot = 0;

            // Compute transformation matrix
            const float sx = fsine(GACCESS(i, 0));
            const float cx = fcosine(GACCESS(i, 0));
            const float sy = fsine(GACCESS(i, 1));
            const float cy = fcosine(GACCESS(i, 1));
            const float sz = fsine(GACCESS(i, 2));
            const float cz = fcosine(GACCESS(i, 2));

            float transform[3][4];
            transform[0][0] = cy * cz;
            transform[0][1] = sx * sy * cz - cx * sz;
            transform[0][2] = cx * sy * cz + sx * sz;
            transform[0][3] = GACCESS(i, 3);
            transform[1][0] = cy * sz;
            transform[1][1] = sx * sy * sz + cx * cz;
            transform[1][2] = cx * sy * sz - sx * cz;
            transform[1][3] = GACCESS(i, 4);
            transform[2][0] = -sy;
            transform[2][1] = sx * cy;
            transform[2][2] = cx * cy;
            transform[2][3] = GACCESS(i, 5);

            // Loop over ligand atoms
            int il = 0;
            do
            {
                // Load ligand atom data
                const Atom l_atom = params.ligand[il];
                const FFParams l_params = params.forcefield[l_atom.type];
                const int lhphb_ltz = l_params.hphb < 0.f;
                const int lhphb_gtz = l_params.hphb > 0.f;

                // Transform ligand atom
                float lpos_x = transform[0][3]
                               + l_atom.x * transform[0][0]
                               + l_atom.y * transform[0][1]
                               + l_atom.z * transform[0][2];
                float lpos_y = transform[1][3]
                               + l_atom.x * transform[1][0]
                               + l_atom.y * transform[1][1]
                               + l_atom.z * transform[1][2];
                float lpos_z = transform[2][3]
                               + l_atom.x * transform[2][0]
                               + l_atom.y * transform[2][1]
                               + l_atom.z * transform[2][2];

                // Loop over protein atoms
                int ip = 0;
                do
                {
                    // Load protein atom data
                    const Atom p_atom = params.protein[ip];
                    const FFParams p_params = params.forcefield[p_atom.type];

                    const float radij   = p_params.radius + l_params.radius;
                    const float r_radij = 1.f / radij;

                    const float elcdst  =
                        (p_params.hbtype == HBTYPE_F && l_params.hbtype == HBTYPE_F)
                        ? 4.f : 2.f;
                    const float elcdst1 =
                        (p_params.hbtype == HBTYPE_F && l_params.hbtype == HBTYPE_F)
                        ? 0.25f : 0.5f;
                    const int   type_E  =
                        ((p_params.hbtype == HBTYPE_E || l_params.hbtype == HBTYPE_E));

                    const int  phphb_ltz = p_params.hphb <  0.f;
                    const int  phphb_gtz = p_params.hphb >  0.f;
                    const int  phphb_nz  = p_params.hphb != 0.f;
                    const float p_hphb   =
                        p_params.hphb * (phphb_ltz && lhphb_gtz ? -1.f : 1.f);
                    const float l_hphb   =
                        l_params.hphb * (phphb_gtz && lhphb_ltz ? -1.f : 1.f);
                    const float distdslv =
                        (phphb_ltz ? (lhphb_ltz ? NPNPDIST : NPPDIST)
                         : (lhphb_ltz ? NPPDIST : -FLT_MAX));
                    const float r_distdslv = 1.f / distdslv;

                    const float chrg_init = l_params.elsc * p_params.elsc;
                    const float dslv_init = p_hphb + l_hphb;

                    // Calculate distance between atoms
                    const float x      = lpos_x - p_atom.x;
                    const float y      = lpos_y - p_atom.y;
                    const float z      = lpos_z - p_atom.z;
                    const float distij = sqroot(x * x + y * y + z * z);

                    // Calculate the sum of the sphere radii
                    const float distbb = distij - radij;
                    const int  zone1   = (distbb < 0.f);

                    // Calculate steric energy
                    etot += (1.f - (distij * r_radij)) * (zone1 ? 2 * HARDNESS : 0.f);

                    // Calculate formal and dipole charge interactions
                    float chrg_e = chrg_init
                                   * ((zone1 ? 1 : (1.f - distbb * elcdst1))
                                      * (distbb < elcdst ? 1 : 0.f));
                    float neg_chrg_e = -fabsolute(chrg_e);
                    chrg_e = type_E ? neg_chrg_e : chrg_e;
                    etot  += chrg_e * CNSTNT;

                    // Calculate the two cases for Nonpolar-Polar repulsive interactions
                    float coeff  = (1.f - (distbb * r_distdslv));
                    float dslv_e = dslv_init * ((distbb < distdslv && phphb_nz) ? 1 : 0.f);
                    dslv_e *= (zone1 ? 1 : coeff);
                    etot   += dslv_e;

                } while (++ip < params.natpro); // loop over protein atoms
            } while (++il < params.natlig); // loop over ligand atoms

            // Write result
            results[i] = etot * 0.5f;
        }
    }

    // double end = getTimestamp();

    // printTimings(start, end, 1);
}

// FILE* openFile(const char *name, long *length)
// {
//     FILE *file = NULL;
//     if (!(file = fopen(name, "rb")))
//     {
//         fprintf(stderr, "Failed to open '%s'\n", name);
//         exit(1);
//     }

//     fseek(file, 0, SEEK_END);
//     *length = ftell(file);
//     rewind(file);

//     return file;
// }

// int parseInt(const char *str)
// {
//     char *next;
//     int value = strtoul(str, &next, 10);
//     return strlen(next) ? -1 : value;
// }

void loadParameters(int argc, char *argv[])
{
    // Defaults
    params.iterations = N_ITRS;
    int nposes        = N_POSES;

    // for (int i = 1; i < argc; i++)
    // {
    //     if (!strcmp(argv[i], "--iterations") || !strcmp(argv[i], "-i"))
    //     {
    //         if (++i >= argc || (params.iterations = parseInt(argv[i])) < 0)
    //         {
    //             printf("Invalid number of iterations\n");
    //             exit(1);
    //         }
    //     }
    //     else if (!strcmp(argv[i], "--numposes") || !strcmp(argv[i], "-n"))
    //     {
    //         if (++i >= argc || (nposes = parseInt(argv[i])) < 0)
    //         {
    //             printf("Invalid number of poses\n");
    //             exit(1);
    //         }
    //     }
    //     else if (!strcmp(argv[i], "--help") || !strcmp(argv[i], "-h"))
    //     {
    //         printf("\n");
    //         printf("Usage: ./bude [OPTIONS]\n\n");
    //         printf("Options:\n");
    //         printf("  -h  --help               Print this message\n");
    //         printf("  -i  --iterations I       Repeat kernel I times\n");
    //         printf("  -n  --numposes   N       Compute energies for N poses\n");
    //         printf("\n");
    //         exit(0);
    //     }
    //     else
    //     {
    //         printf("Unrecognized argument '%s' (try '--help')\n", argv[i]);
    //         exit(1);
    //     }
    // }

    // FILE *file = NULL;
    // long length;

    // file = openFile(FILE_LIGAND, &length);
    // params.natlig = length / sizeof(Atom);
    // params.ligand = malloc(params.natlig * sizeof(Atom));
    // fread(params.ligand, sizeof(Atom), params.natlig, file);
    // fclose(file);
    params.natlig = data_ligand_dat_len / sizeof(Atom);
    params.ligand = (Atom*) data_ligand_dat;

    // file = openFile(FILE_PROTEIN, &length);
    // params.natpro = length / sizeof(Atom);
    // params.protein = malloc(params.natpro * sizeof(Atom));
    // fread(params.protein, sizeof(Atom), params.natpro, file);
    // fclose(file);
    params.natpro = data_protein_dat_len / sizeof(Atom);
    params.protein = (Atom*) data_protein_dat;

    // file = openFile(FILE_FORCEFIELD, &length);
    // params.ntypes = length / sizeof(FFParams);
    // params.forcefield = malloc(params.ntypes * sizeof(FFParams));
    // fread(params.forcefield, sizeof(FFParams), params.ntypes, file);
    // fclose(file);
    params.ntypes = data_forcefield_dat_len / sizeof(FFParams);
    params.forcefield = (FFParams*) data_forcefield_dat;

    // file = openFile(FILE_POSES, &length);
    // for (int i = 0; i < 6; i++)
    //     params.poses[i] = malloc(nposes * sizeof(float));

    // long available = length / 6 / sizeof(float);
    // params.nposes = 0;
    // while (params.nposes < nposes)
    // {
    //     long fetch = nposes - params.nposes;
    //     if (fetch > available)
    //         fetch = available;

    //     for (int i = 0; i < 6; i++)
    //     {
    //         fseek(file, i * available * sizeof(float), SEEK_SET);
    //         fread(params.poses[i] + params.nposes, sizeof(float), fetch, file);
    //     }
    //     rewind(file);

    //     params.nposes += fetch;
    // }
    // fclose(file);
    long available = data_poses_dat_len / (sizeof(float) * 6);
    params.nposes = nposes > available ? available : nposes;
    params.poses = (float*) data_poses_dat;
    // printf("natlig = %d, natpro = %d, ntypes = %d, nposes = %d\n",
    //        params.natlig, params.natpro, params.ntypes, params.nposes);
}

// void freeParameters()
// {
//     free(params.ligand);
//     free(params.protein);
//     free(params.forcefield);
//     for (int i = 0; i < 6; i++)
//         free(params.poses[i]);
// }

// void printTimings(double start, double end, double poses_per_wi)
// {
//     double ms = ((end - start) / params.iterations) * 1e-3;

//     // Compute FLOP/s
//     double runtime   = ms * 1e-3;
//     double ops_per_wi = 27 * poses_per_wi
//                         + params.natlig * (3 + 18 * poses_per_wi + params.natpro * (11 + 30 * poses_per_wi))
//                         + poses_per_wi;
//     double total_ops     = ops_per_wi * (params.nposes / poses_per_wi);
//     double flops      = total_ops / runtime;
//     double gflops     = flops / 1e9;

//     double interactions         =
//         (double)params.nposes
//         * (double)params.natlig
//         * (double)params.natpro;
//     double interactions_per_sec = interactions / runtime;

//     // Print stats
//     printf("- Total time:     %7.2lf ms\n", (end - start) * 1e-3);
//     printf("- Average time:   %7.2lf ms\n", ms);
//     printf("- Interactions/s: %7.2lf billion\n", (interactions_per_sec / 1e9));
//     printf("- GFLOP/s:        %7.2lf\n", gflops);
// }

// double getTimestamp()
// {
//     struct timeval tv;
//     gettimeofday(&tv, NULL);
//     return tv.tv_usec + tv.tv_sec * 1e6;
// }
