void main() {
  int num1 = 1;
  print('num1 : $num1');

  double num2 = 2.0;
  print('num2-1 : $num2-1');

  double num3 = 2.1;
  print('num2-2: $num3');

  num3 = num1.toDouble();
  print('num3 : $num3');

  num2 = 2.6;
  num1 = num2.toInt();
  print('num1 : $num1');

}