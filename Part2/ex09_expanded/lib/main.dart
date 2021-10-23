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

  String _image1 = "assets/images/900.png";
  String _image2 = "assets/images/placeholder.png";
  String _image3 = "assets/images/900x600.png";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 5,
              child: Container(
                margin: const EdgeInsets.all(0.0),
                padding: const EdgeInsets.all(0.0),
                color: Colors.cyan,
                alignment: Alignment.topLeft,
                child: Image.asset(
                  _image1,
                  alignment: Alignment.topLeft,
                  //fit: BoxFit.none,
                  width: 390.0,
                  height: 250.0,
                ),
              ),
            ),

            Container(
              margin: const EdgeInsets.only(left: 0, top: 10, right: 0, bottom: 10),
              padding: const EdgeInsets.all(0.0),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.upload_sharp),
                    tooltip: "이미지 위로 이동",
                    iconSize: 50.0,
                    onPressed: () => _onClick1(),
                  ),
                  const SizedBox(width: 20,),
                  IconButton(
                    icon: const Icon(Icons.download_sharp),
                    tooltip: "이미지 아래로 이동",
                    iconSize: 50.0,
                    onPressed: () => _onClick2(),
                  ),
                ],
              ),
            ),

            Expanded(
              flex: 5,
              child:
                Container(
                  margin: const EdgeInsets.all(0.0),
                  padding: const EdgeInsets.all(0.0),
                  color: Colors.cyan,
                  alignment: Alignment.topLeft,
                  child: Image.asset(
                    _image2,
                    alignment: Alignment.topLeft,
                    //fit: BoxFit.none,
                    width: 390.0,
                    height: 250.0,
                  ),
                ),
            )
          ],
        ),
      ),
    );
  }

  void _onClick1() {
    setState(() {
      _image1 = 'assets/images/900.png';
      _image2 = 'assets/images/placeholder.png';
    });
  }

  void _onClick2() {
    setState(() {
      _image1 = 'assets/images/placeholder.png';
      _image2 = 'assets/images/900.png';
    });
  }
}
