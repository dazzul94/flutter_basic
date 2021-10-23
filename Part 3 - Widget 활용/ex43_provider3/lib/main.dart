import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyData extends ChangeNotifier {
  String name = '홍길동';
  int age = 25;

  void change(String name, int age) {
    print('change called...');
    this.name = name;
    this.age = age;

    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MyData>(
      create: (_) => MyData(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const Page1(),
      )
    );
  }
}

class Page1 extends StatefulWidget {
  const Page1({ Key? key }) : super(key: key);

  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  late MyData myData;

  @override
  Widget build(BuildContext context) {
    // 데이터 사용 - 변경에 대한 알림 받기 false
    myData = Provider.of<MyData>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Page 1'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text('2페이지 추가',
                                style: TextStyle(fontSize: 24),),
              onPressed: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) => const Page2()),
                );
              }, 
            ),
            const SizedBox(height: 50,),
            ElevatedButton(
              child: const Text('전우치로', 
                                style: TextStyle(fontSize: 24),),
              style: ElevatedButton.styleFrom(
                primary: Colors.greenAccent,
              ),
              onPressed: () {
                myData.change('전우치1', 30);
              }, 
            ),
            ElevatedButton(
              child: const Text('홍길동으로', 
                                style: TextStyle(fontSize: 24)),
              style: ElevatedButton.styleFrom(
                primary: Colors.greenAccent,
              ),
              onPressed: () {
                myData.change('홍길동1', 25);
              },
            ),
            const SizedBox(height: 50,),
            Text(
              '${myData.name} - ${myData.age}',
              style: const TextStyle(fontSize: 30),
            ),
            Consumer<MyData>(
              builder: (context, myData, child) {
                print("여기도 빌드됨");
                return Text('${myData.name} - ${myData.age}',
                            style: const TextStyle(fontSize: 30),);
              }
            ),
          ],
        ),
      ),
    );
  }
}

class Page2 extends StatefulWidget {
  const Page2({ Key? key }) : super(key: key);

  @override
  _Page2State createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  late MyData myData;

  @override
  Widget build(BuildContext context) {
    // 데이터 사용 - 변경에 대한 알림 받기 false
    myData = Provider.of<MyData>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Page 2'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text('2페이지 제거',
                                style: TextStyle(fontSize: 24),),
              style: ElevatedButton.styleFrom(
                primary: Colors.orange,
              ),
              onPressed: () {
                Navigator.pop(context);
              }, 
            ),
            const SizedBox(height: 50,),
            ElevatedButton(
              child: const Text('전우치로', 
                                style: TextStyle(fontSize: 24),),
              style: ElevatedButton.styleFrom(
                primary: Colors.greenAccent,
              ),
              onPressed: () {
                myData.change('전우치2', 31);
              }, 
            ),
            ElevatedButton(
              child: const Text('홍길동으로', 
                                style: TextStyle(fontSize: 24)),
              style: ElevatedButton.styleFrom(
                primary: Colors.greenAccent,
              ),
              onPressed: () {
                myData.change('홍길동2', 26);
              },
            ),
            const SizedBox(height: 50,),
            Text(
              '${myData.name} - ${myData.age}',
              style: const TextStyle(fontSize: 30),
            ),
            Consumer<MyData>(
              builder: (context, myData, child) {
                return Text('${myData.name} - ${myData.age}',
                            style: const TextStyle(fontSize: 30),);
              }
            ),
          ],
        ),
      ),
    );
  }
}
