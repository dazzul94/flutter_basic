void main () {
  List<String> list1 = ['a', 'b', 'c', 'd'];
  List<int> list2 = [1, 2, 3, 1];

  var list3 = ['a', 'b', 'c', 'a'];
  list3.add('d');
  print(list3);

  list3.removeAt(2);
  print(list3);

  for(int i=0; i<list3.length; i++) {
    print('list3[${i}] -> ${list3[i]}');
  }

  for(var each in list3) {
    print(each);
  }

  var list4 = [...list2, 5, 6, 7];
  print(list4);
}