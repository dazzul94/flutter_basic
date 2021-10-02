import '20_class4_get_set2.dart';

void main() {
  var unit1 = Unit();

  // unit._age = 30;
  // unit.age(30)
  unit1.age = 30;       // setter
  print(unit1.age);     // getter

  // 그냥 변수명을 사용하는 것과 똑같지만
  // 메서드이므로 값의 변경이 가능하다.


  // 연속해서 메서드 호출하기
  var unit2 = Unit()
    ..setName('메딕')
    ..setAge(150);
}