import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';

late FirebaseApp fbApp;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  fbApp = await Firebase.initializeApp();
  print('Initialized default app $fbApp');
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
  late CollectionReference members;
  int seqNum = 0;
  final ctlMyText1 = TextEditingController();

  @override
  void initState() {
    super.initState();
    members = FirebaseFirestore.instance.collection('members');
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
              child: const Text('회원정보 추가', 
                                  style: TextStyle(fontSize: 24),),
              onPressed: () => doInsert(), 
            ),
            SizedBox(
              width: 240,
              child: TextField(
                controller: ctlMyText1,
              ),
            ),
            const SizedBox(height: 10,),
            ElevatedButton(
              child: const Text('회원정보 조회', 
                                  style: TextStyle(fontSize: 24),),
              onPressed: () => doSelectOne(), 
            ),
            ElevatedButton(
              child: const Text('회원정보 수정', 
                                  style: TextStyle(fontSize: 24),),
              onPressed: () => doUpdate(), 
            ),
            ElevatedButton(
              child: const Text('회원정보 삭제', 
                                  style: TextStyle(fontSize: 24),),
              onPressed: () => doDelete(), 
            ),
          ],
        ),
      ),
    );
  }

  Future<void> doInsert() async {
    // 회원정보를 firestore 문서로 추가
    String sNum = ctlMyText1.text;
    int nNum = int.parse(sNum);
    String sId = 'member$nNum';
    print("sId: $sId");

    var documentReference = await members.doc(sId);
    print(documentReference == null);

    if(documentReference == null) {
      members.doc(sId).set({
        'pw': '1234',
        'email': 'test1@test.com',
      });
    } else {
      print('회원 정보가 이미 존재합니다.');
    }
  }

  Future<void> doSelectOne() async {
    String sNum = ctlMyText1.text;
    int nNum = int.parse(sNum);
    String sId = 'member$nNum';

    var documentSnapshot = await members.doc(sId).get();
    print(documentSnapshot != null);

    if(documentSnapshot != null) {
      String pw = documentSnapshot.get('pw');
      String email = documentSnapshot.get('email');
      print('pw : $pw');
      print('email: $email');
    } else {
      print('회원 정보가 존재하지 않습니다.');
    }
  }

  Future<void> doUpdate() async {
    String sNum = ctlMyText1.text;
    int nNum = int.parse(sNum);
    String sId = 'member$nNum';

    var documentReference = await members.doc(sId);
    if(documentReference != null) {
      members.doc(sId).update({
        'email': 'xxxx@test.com',
      });
    } else {
      print('회원 정보가 존재하지 않습니다.');
    }
  }

  Future<void> doDelete() async {
    String sNum = ctlMyText1.text;
    int nNum = int.parse(sNum);
    String sId = 'member$nNum';

    var documentReference = await members.doc(sId);
    if(documentReference != null) {
      documentReference.delete();
    } else {
      print("회원 정보가 존재하지 않습니다.");
    }
  }
}
