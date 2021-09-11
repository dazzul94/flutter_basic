void main (){
  int num1 = 10;
  double num2 = num1.toDouble();
  num1 = num2.toInt();

  int intVal = int.parse('10');
  double doubleVal = double.parse('10.1');

  try {
    var num3 = int.parse('n42');
    print(num3);
  } on FormatException catch(e) {
    print('Format error!');
    print(e);
  }

  int? intVal2 = int.tryParse('10');
  double? doubleVal2 = double.tryParse('10.1');

  int val1 = int.tryParse('n42') ?? -1;
  print('val1 = $val1');
  var val2 = int.tryParse('n42');
  print('val2 = $val2');
}