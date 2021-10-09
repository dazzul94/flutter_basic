import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      // 1. 명시적으로 children으로 List<Widget>을 넘겨서 생성 - 비효율(메모리)
      body: ListView(
        // children: [
        //   ListTile(
        //     leading: FlutterLogo(size: 50.0,),
        //     title: Text('Basic #1'),
        //     subtitle: Text('타이틀과 서브 타이틀로만 구성'),
        //     trailing: Icon(Icons.more_vert),
        //     onTap: () {
        //       print('Basic #1');
        //     },
        //   ),
        // ],
        // children: getMyList1(),
        children: getMyList2(),
      )
    );
  }

  List<Widget> getMyList1() {
    List<Widget> myList = [
      ListTile(
        leading: FlutterLogo(size: 50.0,),
        title: Text('Basic #1'),
        subtitle: Text('타이틀과 서브 타이틀로만 구성'),
        trailing: Icon(Icons.more_vert),
        onTap: () {
          print('Basic #1');
        },
      ),
      Divider(
        color: Colors.black,
        height: 5,
        // indent: 10,
        // endIndent: 10,
      )
    ];
    return myList;
  }

  List<Widget> getMyList2() {
    // 이런 데이터가 있다 치고
    List<Person> persons = [];
    for (int i = 0; i < 15; i++) {
      persons.add(Person(i+21, '홍길동${i+1}', true));
    }

    List<Widget> myList = [];

    for(int i = 0; i < persons.length; i++) {
      Widget wid = ListTile(
        leading: FlutterLogo(size: 50.0,),
        title: Text('Basic #${i+1}'),
        subtitle: Text('${persons[i].name} - ${persons[i].age}'),
        trailing: Icon(Icons.more_vert),
        onTap: () {
          print('Basic #${i+1}');
        },
      );
      myList.add(wid);
    }
    return myList;
  }
}

class Person {
  int age;
  String name;
  bool isLeftHand;

  Person(this.age, this.name, this.isLeftHand);
}
