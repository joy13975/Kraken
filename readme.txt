This was a coursework I did for advanced computer architecture during my last year in university.

It's not meant to serve any real world use and probably breaks a lot.

To compile:
    make clean; make

To list run options:
    ./kraken --help

Typical run:
    ./kraken -i bmarks/qsort.a64 -lg 3 -bp d -pl -el -ss 6

Useful flags:
    Interactive mode:   -im
    More verbosity:     -lg <0-2>
    Breakpoint:         -b <point>
    ..All listed in     --help

For readable output while stepping through program:
    ./kraken -lg 1 -im -bp d -pl -el -ss 6 -i <some .a64 program in bmarks/>
