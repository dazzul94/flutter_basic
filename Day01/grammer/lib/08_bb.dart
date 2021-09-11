void main() {
 Set<String> set1 = {'c', 'b', 'a'};
 print(set1);

 set1.add('a');
 set1.add('a');
 set1.add('b');
 print(set1);

 set1.remove('c');
 print(set1);

 var bCheck = set1.contains('b');
 if (bCheck) {
   print('b는 존재하는 값');
 }

 for(int i=0; i < set1.length; i++) {
   print('set1[${i}] -> ${set1.elementAt(i)}');
 }

 for (dynamic each in set1) {
   print(each);
 }

 var set2 = {...set1, 'x', 'y', 'z'};
 print(set2);
}