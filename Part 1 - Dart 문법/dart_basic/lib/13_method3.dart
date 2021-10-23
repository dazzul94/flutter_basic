void main() {
  var myFunc = addTwoNum;

  myFunc(1, 2);

  something("1", "2", myFunc);
}

void addTwoNum(int a, int b) {
  print(a + b);
}

void something(var a, var b, var c) {
  int val1 = int.parse(a);
  int val2 = int.parse(b);

  c(val1, val2);
}