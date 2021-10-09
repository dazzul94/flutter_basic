abstract class Greet {
  greet();
}

abstract class Talk {
  talk();
}

// 하나만 상속가능
class Morning extends Greet {
  greet() { print("인사"); }
}

// 여러개 구현가능
class Evening implements Greet, Talk {
  greet() { print("인사"); }
  talk() { print("대화"); }
}

void main() {

}