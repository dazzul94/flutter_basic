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
  bool _chk1 = false;
  bool? _chk2 = true;
  bool _chk3 = false;

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
            Checkbox(
              value: _chk1, 
              onChanged: (bool? value) {
                setState(() {
                  _chk1 = value!;
                });
                print('Checkbox1 : $_chk1');
              }
            ),
            Checkbox(
              value: _chk2, 
              checkColor: Colors.pink,
              activeColor: Colors.green,
              onChanged: (value) {
                setState(() {
                  _chk2 = value!;
                });
                print('Checkbox2 : $_chk2');
              }
            ),
            Switch(
              value: _chk3, 
              activeColor: Colors.red,
              activeTrackColor: Colors.cyan,
              inactiveThumbColor: Colors.lightGreen,
              inactiveTrackColor: Colors.lightGreen,
              onChanged: (value) {
                setState(() {
                  _chk3 = value;
                });
                print('Switch : $_chk3');
              }
            )
          ],
        ),
      ),
    );
  }
}
