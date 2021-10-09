class Unit {
  var health = 10;
}

class Marine extends Unit {
  var attack = 1;
}

void main() {
  var unit = Marine();
  print(unit.health);
  print(unit.attack);
}