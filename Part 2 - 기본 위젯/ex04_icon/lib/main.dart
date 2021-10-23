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
      body: Row(
        children: [
          Icon(
            Icons.camera_alt,
            color: Colors.red,
            size: 35.0,
          ),
          Icon(
            Icons.add_reaction,
            color: Colors.pink[50],
            size: 35.0,
          ),
          Icon(
            Icons.access_alarm,
            color: Colors.cyan,
            size: 35.0,
          ),
          Icon(
            Icons.camera_alt,
            color: Colors.red,
            size: 35.0,
          ),
          Icon(
            Icons.add_reaction,
            color: Colors.pink[50],
            size: 35.0,
          ),
          Icon(
            Icons.access_alarm,
            color: Colors.cyan,
            size: 35.0,
          ),
          Icon(
            Icons.camera_alt,
            color: Colors.red,
            size: 35.0,
          ),
          Icon(
            Icons.add_reaction,
            color: Colors.pink[50],
            size: 35.0,
          ),
          Icon(
            Icons.access_alarm,
            color: Colors.cyan,
            size: 35.0,
          ),
          Icon(
            Icons.camera_alt,
            color: Colors.red,
            size: 35.0,
          ),
          Icon(
            Icons.add_reaction,
            color: Colors.pink[50],
            size: 35.0,
          ),
          Icon(
            Icons.access_alarm,
            color: Colors.cyan,
            size: 35.0,
          ),
        ],
      ),
    );
  }
}
