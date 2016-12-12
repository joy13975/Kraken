#ifdef _DEBUG
#include "stdio.h"
#endif

#include "nums1k.h"

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
    sort(nums1k1, 0, 5);

#ifdef _DEBUG
    printf("Front: ");
    for (int i = 0; i < 10; i++)
        printf("%-3d ", nums1k1[i]);
    printf("\n");

    printf("Back:  ");
    for (int i = 1023; i > 1023-10; i--)
        printf("%-3d ", nums1k1[i]);
    printf("\n");
#endif

    return nums1k1[5];
}