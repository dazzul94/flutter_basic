class Unit {
  int? health;
  int? move;

  // 초기화 리스트를 사용
  Unit.init() : health = 10, move = 1 {
    // 생성자의 구현부가 실행되기 전에 인스턴스 변수를 초기화할 수 있다.
  }
  Unit({int? health}) : move = 2 {
    this.health = health ?? 0;
  }
}

void main() {
  // 생성자의 초기화 리스트 사용하기
  Unit unit1 = Unit.init();
  print('unit1.health: ${unit1.health}');
  print('unit1.move: ${unit1.move}');
  print("=============================");

  // Marine unit2 = Marine();
  Marine unit2 = Marine(health: 20);
  print('unit2.health: ${unit2.health}');
  print('unit2.move: ${unit2.move}');
  print('unit2.attack: ${unit2.attack}');
}

class Marine extends Unit {
  late int attack;

  // 마린을 생성할 때 health에 값이 들어오면 부모로부터 상속받은 health에 값을 넣어준다는 의미
  Marine({int? health}) : attack = 1, super(health: health) {

  }
}