class Unit {
  late String name;
  late int age;

  // 기본 생성자 : <-- 이름 없는 생성자
  // - 클래스명과 동일
  // - 인자 없다
  // - 부모 클래스의 기본 생성자 호출
  // - 이름 있는 생성자가 없다면 자동으로 호출된다.

  // 기본 생성자에 수행 동작 추가
  Unit() {
    this.name = "홍길동";
    this.age = 10;
  }


  // 이름 있는 생성자 추가 사용: 클래스명.생성자명
  Unit.init1(name) {
    this.name = name;
    this.age = 10;
  }
  Unit.init2(name, age) {
    this.name = name;
    this.age = age;
  }
}

void main() {
  // 이름 있는 생성자 사용시, 기본 생성자를 사용하려면
  // 기본 생성자를 명시적으로 선언해야 한다.(자바도 동일)

  Unit myUnit1 = Unit();

  Unit myUnit2 = Unit.init1("마린");

  Unit myUnit3 = Unit.init2("마린", 30);
}