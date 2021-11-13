import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'dart:async';

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

  int _counter = 0;

  late DatabaseReference _counterRef;
  late DatabaseReference _messagesRef;
  late StreamSubscription<Event> _counterSubscription;
  late StreamSubscription<Event> _messagesSubscription;
  bool _anchorToBottom = false;

  final String _kTestKey = 'Hello';
  final String _kTestValue = 'word!';
  DatabaseError? _error;

  @override
  void initState() {
    super.initState();

    _counterRef = FirebaseDatabase.instance.reference().child('counter');
    _messagesRef = FirebaseDatabase.instance.reference().child('messages');

    // 리스너 설정 - 데이터베이스의 값이 변하면 앱에 반영된다.
    _counterSubscription = _counterRef.onValue.listen((Event event) {
      setState(() {
        _error = null;
        _counter = event.snapshot.value ?? 0;
      });
    }, onError: (Object o) {
      final DatabaseError error = o as DatabaseError;
      setState(() {
        _error = error;
      });
    });

    _messagesSubscription = _messagesRef
    .limitToLast(10)
    .onChildAdded.listen((Event event) {
      print('Child added: ${event.snapshot.value}');
    }, onError: (Object o) {
      final DatabaseError error = o as DatabaseError;
      print('Error: ${error.code} ${error.message}');
    });
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
          children: [
            Flexible(
              child: Center(
                child: _error == null 
                ? Text('Button tapped $_counter time${_counter == 1? '' : 's'}.\n\n'
                       'This includes all devices, ever.',
                )
                : Text('Error retrieving button tap count:\n${_error!.message}'),
              )
            ),
            ElevatedButton(
              child: const Text('Increment as transaction'),
              onPressed: () async {
                await _incrementAsTransaction();
              }, 
            ),
            ListTile(
              title: const Text('Anchor to bottom'),
              leading: Checkbox(
                onChanged: (bool? value) {
                  if(value != null) {
                    setState(() {
                      _anchorToBottom = value;
                    });
                  }
                },
                value: _anchorToBottom,
              ),
            ),
            Flexible(
              child: FirebaseAnimatedList(
                key: ValueKey<bool>(_anchorToBottom),
                query: _messagesRef,
                reverse: _anchorToBottom,
                itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {
                  return SizeTransition(
                    sizeFactor: animation,
                    child: ListTile(
                      trailing: IconButton(
                        onPressed: () => _messagesRef.child(snapshot.key!).remove(),
                        icon: const Icon(Icons.delete),
                      ),
                      title: Text(
                        '$index: ${snapshot.value.toString()}',
                      ),
                    ),
                  );
                },
              )
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _increment,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _messagesSubscription.cancel();
    _counterSubscription.cancel();
  }

  Future<void> _increment() async {
    await _counterRef.set(ServerValue.increment(1));

    await _messagesRef
          .push()
          .set(<String, String>{_kTestKey: '$_kTestValue $_counter'});
  }

  Future<void> _incrementAsTransaction() async {
    // Increment counter in transaction
    final TransactionResult transactionResult = 
      // 여기 수정해야할까?
      await _counterRef.runTransaction((MutableData mutableData) async {
        mutableData.value (mutableData.value ?? 0) + 1;
        return mutableData;
      });

      if(transactionResult.committed) {
        await _messagesRef.push().set(<String, String>{
          _kTestKey: '$_kTestValue ${transactionResult.dataSnapshot?.value}'
        });
      } else {
        print('Transaction not committed');
        if(transactionResult.error != null) {
          print(transactionResult.error!.message);
        }
      }
  }
}
