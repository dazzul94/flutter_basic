abstract class Unit {
  move();
}

class Marine extends Unit {
  // 기능의 완성
  move() { print("마린 이동"); }
}

class Medic implements Unit {
  // 기능의 완성
  move() { print("메딕 이동"); }
}

void main() {
  var unit1 = Marine();
  unit1.move();

  var unit2 = Medic();
  unit2.move();
}