void main() {
  something1();
  something1('홍길동');

  something2('해리포터');
  something2('멀린', 20);

  something3('전우치');
  something3('손오공', 20);

  something4('이순신');
  something4('강감찬', 20);
}

void something1([String? name]) {
  print('name : $name');
}

void something2([String? name, int? age]) {
  print('name : $name age : $age');
}

void something3(String name, [int? age]) {
  print('name : $name age : $age');
}

void something4(String name, [int age = 10]) {
  print('name : $name age : $age');
}