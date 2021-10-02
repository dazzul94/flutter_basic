class Unit {
  late String _name;
  late int _age;

  // 메뉴를 이용하여 자동 생성: [AS] Code -> Generate...
  int get age => _age;

  set age(int value) {
    _age = value;
  }

  // String get name => _name;
  // String get name => 'My name is $_name.';
  String get name {
    return 'My name is $_name.';
  }

  set name(String value) {
    _name = value;
  }

  // 일반 메서드 형태로 세터 메서드 직접 생성
  void setName(String name) {
    this._name = name;
  }
  void setAge(int age) {
    this._age = age;
  }
}