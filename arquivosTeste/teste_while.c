int main()
{
  int x = 1, y = 5;
  float a = 2, z = 1000;
  while (y > 1)
  {
    y = y - 1;
    x = x * 2;
    z = z / x;
  }
  print(a);
  print(x);
  print(y);
  print(z);
}
