int main()
{
    int i, j, k;
    float a = 1;
    read i;
    read k;
    for (j = 10; j >= 1; j = j - 1)
    {
        if (k == 2)
        {
            a = a*i - j;
            k = 1;
        }
        else if (k == 1)
        {
            a = a*i + j;
            k = 0;
        }
        else {        
            k = 2;
            a = 0;
        }
        print(a);
        print(k);
    }
    print(a < i);
}
