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

  var isSelected1 = [false, false, true];
  var isSelected2 = [false, false, true];
  var isSelected3 = [false, false, true];

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
            const Text('multi-select', textScaleFactor: 2,),
            ToggleButtons(
              children: const [
                Icon(Icons.ac_unit),
                Icon(Icons.call),
                Icon(Icons.cake)
              ], 
              onPressed: (int index) {
                setState(() {
                  isSelected1[index] = !isSelected1[index];
                  print('isSelected1 : $isSelected1');
                });
              },
              isSelected: isSelected1
            ),
            const SizedBox(height: 20,),
            const Text('single-select', textScaleFactor: 2,),
            ToggleButtons(
              children: const [
                Icon(Icons.ac_unit),
                Icon(Icons.call),
                Icon(Icons.cake)
              ], 
              onPressed: (int index) {
                setState(() {
                  for(var i = 0; i < isSelected2.length; i++) {
                    if(i == index) {
                      isSelected2[i] = true;
                    } else {
                      isSelected2[i] = false;
                    }
                  }
                  print('isSelected2 : $isSelected2');
                });
              },
              isSelected: isSelected2
            ),
            const SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }
}
