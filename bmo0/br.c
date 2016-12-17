int main(void)
{
    int i1 = 1, i3 = 3, i5 = 5;
    int b = 0;

    if (b < i1) b++;

    if (b > i1) b++;

    if (b != i3) b++;

    if (b < i5) b++;

    return b;
}