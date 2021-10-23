class Unit {
  var health = 10;
}

class Marine extends Unit {
  var name = "마린";
}

class Medic extends Unit {
  var name = '메딕';
}

void main() {
  Marine marine = Marine();
  Medic medic = Medic();

  Unit unit1 = marine as Unit;
  Unit unit2 = medic as Unit;

  if(unit1 is Marine) {
    print('마린입니다.');
    print(unit1.name); // 자바와는 다름. 자바는 이렇게 참조가 안됨.
  } else {
    print('마린이 아닙니다.');
  }

}
