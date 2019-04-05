int main()
{
  int x = 1, y = 10;
  float a = 2, z = 1000;
  while (y > 1)
  {
    y = y - 1;
    x = x * 2;
    z = z / x;
  }
  print(x);
  print(z);
  print(x/(z - y));
}
