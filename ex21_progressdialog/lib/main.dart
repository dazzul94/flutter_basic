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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: const Text('Show ProgressDialog',
                                style: TextStyle(fontSize: 24),),
              onPressed: () => _showProgressDialog('loading....'), 
            )
          ],
        ),
      ),
    );
  }

  Future _showProgressDialog(String message) async {
    await showDialog(
      context: context,
      barrierDismissible: false, // false : user must tap button! 
      builder: (BuildContext context) {  

        // 테스트할 때 3초 후 창 닫기
        Future.delayed(const Duration(seconds: 3), () {
          Navigator.pop(context);
        });

        return Theme(
          data: ThemeData(dialogBackgroundColor: Colors.white), 
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0)
            ),
            content: SizedBox(
              height: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 50.0,
                    width: 50.0,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.black),
                      strokeWidth: 5.0,
                    ),
                  ),
                  const SizedBox(height: 20.0,),
                  Text(
                    message,
                    style: const TextStyle(fontSize: 24, height: 1.5),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
