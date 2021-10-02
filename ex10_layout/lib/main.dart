import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
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
      // appBar: AppBar(
      //   title: Text(widget.title),
      // ),
      body: SafeArea(
        child: Container(
          color: Colors.cyan,
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  margin: EdgeInsets.only(top:5),
                  width: 280,
                  color: Colors.yellow,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Spacer(flex: 1,),
                      ElevatedButton(child: const Text("Button"), onPressed: () {},),
                      Spacer(flex: 1,),
                      ElevatedButton(child: const Text("Button"), onPressed: () {},),
                      Spacer(flex: 1,),
                      ElevatedButton(child: const Text("Button"), onPressed: () {},),
                      Spacer(flex: 1,),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(5),
                  width: 280,
                  color: Colors.pink,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Spacer(flex: 1,),
                      ElevatedButton(child: const Text("Button"), onPressed: () {},),
                      Spacer(flex: 1,),
                      ElevatedButton(child: const Text("Button"), onPressed: () {},),
                      Spacer(flex: 1,),
                      ElevatedButton(child: const Text("Button"), onPressed: () {},),
                      Spacer(flex: 1,),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}
