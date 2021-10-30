import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:xml2json/xml2json.dart';

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
          children: [
            ElevatedButton(
              child: const Text('JSON Parsing', 
                                style: TextStyle(fontSize: 24),),
              onPressed: () {
                getJsonData();
              }, 
            ),
            SizedBox(height: 30,),
            ElevatedButton(
              child: const Text('XML Parsing',
                                style: TextStyle(fontSize: 24),),
              onPressed: () {
                getXMLData();
              }, 
            )
          ],
        ),
      ),
    );
  }
}

void getJsonData() {
  String json = '''
    {"items": {"item": 
      [
        {"id": "1", "name": "홍길동"},
        {"id": "2", "name": "전우치"},
        {"id": "3", "name": "손오공"}
      ]
    }}
  ''';

  var data1 = jsonDecode(json);
  print(data1);

  List data2 = data1['items']['item'];
  print(data2);

  print("=====================================================");
  for (int i=0; i < data2.length; i++) {
    print(data2[i]['id']);
  }

  print("=====================================================");
  for (var item in data2) {
    print(item['name']);
  }
}

void getXMLData() {
  String xmlData = '''
    <items>
      <item>
        <id>1</id>
        <name>홍길동</name>
      </item>
      <item>
        <id>2</id>
        <name>전우치</name>
      </item>
      <item>
        <id>3</id>
        <name>손오공</name>
      </item>
    </items>
  ''';


  Xml2Json xml2json = Xml2Json();
  xml2json.parse(xmlData);

  var json = xml2json.toParker();
  print(json);

  var data1 = jsonDecode(json);
  print(data1);

  List data2 = data1['items']['item'];
  print(data2);

  print("=====================================================");
  for (int i=0; i < data2.length; i++) {
    print(data2[i]['id']);
  }
  print("=====================================================");
  for (var item in data2) {
    print(item['name']);
  }
}
