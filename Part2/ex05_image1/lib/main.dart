import 'package:flutter/material.dart';
import 'dart:ui';

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

  void getWindowSize() {
    print(MediaQuery.of(context).size);             // 앱 화면 논리적 크기
    print(MediaQuery.of(context).devicePixelRatio); // 화면 배율
    print(window.physicalSize);                     // 앱 화면 실제 크기
  }
  @override
  Widget build(BuildContext context) {

    getWindowSize();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 해당 배율에 이미지가 없으므로 기본 이미지를 사용
          Image.asset('assets/images/300x300a.png'),
          // 해당 배율에 이미지가 있으므로 해당 배율의 분홍 이미지를 사용

          // 기본 폴더의 같은 이름의 이미지는 노랑색 이미지
          // 크기를 지정하지 않으면 배율만큼 자동으로 줄어듬
          Image.asset('assets/images/300x300b.png'),
          // 해당 배율의 이미지라도 크기를 지정하면 지정한 크기가 적용됨
          // Image.asset 의 크기가 지정된 것이지
          // 내부의 이미지 크기가 지정된 것은 아니다.
          Image.asset(
            'assets/images/300x300b.png',
            fit: BoxFit.fill,
            width: 150,
          ),
          // 기본 폴더의 이미지에 크기 지정하기
          Image.asset(
            'assets/images/300x300a.png',
            width: 100,
          ),
        ],
      ),
    );
  }
}
