import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';

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
  late Future<Database> database;
  int seqNum = 0;
  final ctlMyText1 = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    createDatabase();
  }

  void createDatabase() async {
    database = openDatabase(
      // 각 플랫폼 별로 데이터베이스 경로 생성
      // 'path' 패키지의 'join'함수사용
      join(await getDatabasesPath(), 'telbook.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE telbook( " + 
          " id INTEGER PRIMARY KEY, name TEXT, telnum TEXT)",
        );
      },
      version: 1,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: const Text('Insert',
                            style: TextStyle(fontSize: 24),),
              onPressed: () => doInsert(),
            ),
            SizedBox(height: 10,),
            ElevatedButton(
              child: const Text('Select All',
                            style: TextStyle(fontSize: 24),),
              onPressed: () => doSelectAll(),
            ),
            SizedBox(height: 10,),
            SizedBox(
              width: 240,
              child: TextField(
                controller: ctlMyText1,
              ),
            ),
            SizedBox(height: 10,),
            ElevatedButton(
              child: const Text('Select One',
                            style: TextStyle(fontSize: 24),),
              onPressed: () => doSelectOne(),
            ),
            SizedBox(height: 10,),
            ElevatedButton(
              child: const Text('Update',
                            style: TextStyle(fontSize: 24),),
              onPressed: () {
                var sNum = ctlMyText1.text;
                int nNum = int.parse(sNum);
                doUpdate(nNum);
              },
            ),
            SizedBox(height: 10,),
            ElevatedButton(
              child: const Text('Delete',
                            style: TextStyle(fontSize: 24),),
              onPressed: () {
                var sNum = ctlMyText1.text;
                int nNum = int.parse(sNum);
                doDelete(nNum);
              },
            ),
            SizedBox(height: 10,),
            ElevatedButton(
              child: const Text('Delete All',
                            style: TextStyle(fontSize: 24),),
              onPressed: () => doDeleteAll(),
            ),
            SizedBox(height: 10,),
          ],
        ),
      ),
    );
  }

  void doSelectAll() async {
    // 데이터베이스 reference 얻기
    final Database db = await database;

    List<Map> datas = await db.rawQuery('select * from a telbook');
    if(datas.length > 0) {
      for(int i=0; i < datas.length; i++) {
        int id = datas[i]['id'];
        String name = datas[i]['name'];
        String telnum = datas[i]['telnum'];

        print('$id $name $telnum');
      } 
    } else {
      print('SelectAll: 데이터가 없습니다.');
    }
  }

  void doSelectOne() async {
    // 데이터베이스 reference 얻기
    final Database db = await database;

    List<Map> datas = await db.rawQuery('select * from a telbook where id = $num');
    if(datas.length > 0) {
      for(int i=0; i < datas.length; i++) {
        int id = datas[i]['id'];
        String name = datas[i]['name'];
        String telnum = datas[i]['telnum'];

        print('$id $name $telnum');
      } 
    } else {
      print('SelectOne: 데이터가 없습니다.');
    }
  }

  Future<void> doInsert() async {
    // 데이터베이스 reference 얻기
    final Database db = await database;

    seqNum = seqNum + 1;
    var telnum = '010-1234-$seqNum$seqNum$seqNum$seqNum';

    int count = await db.rawInsert(
      'insert into telbook (id, name, telnum) values (?,?,?)',
      [seqNum, '홍길동$seqNum', telnum]
    );

    print('Insert : $count');
  }
  
  Future<void> doUpdate(int id) async {
    // 데이터베이스 reference 얻기
    final Database db = await database;

    int count = await db.rawUpdate(
      'update telbook set name = ?, telnum = ? where id = ?',
      ['손오공', '010-1234-xxxx', id]
    );

    print('Update : $count');
  }

  Future<void> doDelete(int id) async {
    // 데이터베이스 reference 얻기
    final Database db = await database;

    int count = await db.rawDelete(
      'delete from telbook where id = ?',
      [id]
    );

    print('Update : $count');
  }

  Future<void> doDeleteAll() async {
    // 데이터베이스 reference 얻기
    final Database db = await database;

   int count = await db.rawDelete(
      'delete from telbook',
    );

    print('DeleteAll : $count');
  }
}



