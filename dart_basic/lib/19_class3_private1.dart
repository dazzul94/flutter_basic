import '19_class3_private2.dart';

class Unit {

  // 변수면 그냥쓰면 public, _로 시작하면 private(암묵적)
  late String _name;
  late int age;

  // 생성자 간단하게 사용하기
  // 어차피 연결할 거... 파라미터 부분에서..
  Unit (this._name, this.age);
}

void main() {
  var unit1 = Unit("마린", 25);
  print(unit1._name);
  print(unit1.age);

  var unit2 = Unit2("메딕", 20);
  // print(unit2._name);
  // print(unit2._age);
}