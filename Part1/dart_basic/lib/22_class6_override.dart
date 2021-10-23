class Unit {
  move() { print("이동1"); }
  attack() { print("공격1"); }
  heal() { print("치료1"); }
}

class Marine extends Unit {
  // 기능의 벼경
  move() { print("이동2"); }

  // 기능의 추가
  attack() {
   super.attack();
   print("공격2");
  }

  // 오버라이딩하는 메서드명이 맞는지 체크
  @override
  heal() {
    super.heal();
    print("치료2");
  }
}

void main() {
  var unit = Marine();
  unit.move();
  unit.attack();
  unit.heal();
}