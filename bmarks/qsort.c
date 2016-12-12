#ifdef _DEBUG
#include "stdio.h"
#endif

#include "nums1k.h"

#define N 1024

void swap(int *a, int *b)
{
    int t = *a; *a = *b; *b = t;
}

void sort(int arr[], int beg, int end)
{
    if (end > beg + 1)
    {
        int piv = arr[beg], l = beg + 1, r = end;
        while (l < r)
        {
            if (arr[l] <= piv)
                l++;
            else
                swap(&arr[l], &arr[--r]);
        }
        swap(&arr[--l], &arr[beg]);
        sort(arr, beg, l);
        sort(arr, r, end);
    }
}

int main(void)
{
    sort(nums1k1, 0, N - 1);

    int ret = nums1k1[N - 1] % 255;

#ifdef _DEBUG
    printf("Front: ");
    for (int i = 0; i < 10; i++)
        printf("%-3d ", nums1k1[i]);
    printf("\n");

    printf("Back:  ");
    for (int i = N - 1; i > N - 1 - 10; i--)
        printf("%-3d ", nums1k1[i]);
    printf("\n");

    printf("Ret: %d\n", ret);
#endif

    return ret;
}