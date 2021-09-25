void main() {
  int num1 = 5;
  int? num2 = 2;

  num2 = null;

  String? str2 = null;

  print("1 =================================");

  int? a2; print(a2);

  var a3 = 10;
  var a4 = null;
  var a5;

  print("2 ===================================");

  int num3 = 5;
  int? num4;

  num4 = 10;
  // num3 = num4;
  num3 = num4!;

  String? name;

  name = name?.toLowerCase();

  int val2 = int.tryParse('n42')?? -1;
  print('val2 = $val2');
}