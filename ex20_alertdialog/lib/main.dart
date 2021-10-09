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
  String _sPersonName = '';

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
              child: const Text('Show AlertDialog',
                                style: TextStyle(fontSize: 24,
                                            color: Colors.white)),
              onPressed: () => _showAlertDialog(context, 'hello~'), 
            )
          ],
        ),
      ),
    );
  }

  Future _showAlertDialog(BuildContext context, String message) async {
    await showDialog(
      context: context,
      barrierDismissible: false,  // user must tap button!
      builder: (BuildContext context) {
        return Theme(
          data: ThemeData(dialogBackgroundColor: Colors.orange), 
          child: AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
            title: Text('AlertDialog Example'),
            content: Container(
              height: 90,
              child: Column(
                children: [
                  Text(message),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Name', hintText: '홍길동'
                    ),
                    onChanged: (value) {
                      _sPersonName = value;
                    },
                  ),
                ],
              ),
            ),
            actions: [
              ElevatedButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.pop(context, 'OK');
                  print('OK - $_sPersonName');
                }, 
              ),
              ElevatedButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.pop(context, 'Cancel');
                  print('Cancel');
                }, 
              )
            ],
          ),
        );
      }
    );
  }
}

