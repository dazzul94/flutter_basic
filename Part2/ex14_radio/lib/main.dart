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

enum Fruit { apple, banana }

class _MyHomePageState extends State<MyHomePage> {

  Fruit _myGroup1 = Fruit.apple;
  Fruit _myGroup2 = Fruit.banana;

  bool _btn = true;

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
            ListTile(
              title: const Text('사과'),
              leading: Radio<Fruit>(
                groupValue: _myGroup1,
                value: Fruit.apple,
                onChanged: (Fruit? value) {
                  setState(() {
                    _myGroup1 = value!;
                    print(_myGroup1);  
                  });
                }
              ),
            ),
            ListTile(
              title: const Text('바나나'),
              leading: Radio<Fruit>(
                groupValue: _myGroup1,
                value: Fruit.banana,
                onChanged: (Fruit? value) {
                  setState(() {
                    _myGroup1 = value!;
                    print(_myGroup1);  
                  });
                }
              ),
            ),
            const SizedBox(height: 50,),
            RadioListTile<Fruit>(
              title: const Text('사과'),
              groupValue: _myGroup2,
              value: Fruit.apple,
              onChanged: (value) {
                setState(() {
                  _myGroup2 = value!;
                  print(_myGroup2);
                  _btn = true;
                });
              },
            ),
            RadioListTile<Fruit>(
              title: const Text('바나나'),
              groupValue: _myGroup2,
              value: Fruit.banana,
              onChanged: (value) {
                setState(() {
                  _myGroup2 = value!;
                  print(_myGroup2);
                  _btn = false;
                });
              },
            ),
            const SizedBox(height: 50,),
            ElevatedButton(
              child: const Text('ElevatedButton',
                                style: TextStyle(fontSize: 24, color: Colors.white), ),
              onPressed: _btn? _onClick1 : null, 
            )
          ],
        ),
      ),
    );
  }

  void _onClick1() {
    print('Radio 2 : $_myGroup2');
  }
}
