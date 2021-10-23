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
  String _chosenValue = 'Flutter';

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
            DropdownButton<String>(
              style: const TextStyle(color: Colors.red),
              value: _chosenValue,
              items: [
                'Android',
                'IOS',
                'Flutter',
                'Node',
                'Java',
                'Python',
                'PHP',
              ].map((value) {
                return DropdownMenuItem(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              hint: const Text("힌트글인데 이걸로 크기 조정을",),
              onChanged: (String? value) {
                popupButtonSelected(value!);
                setState(() {
                  _chosenValue = value!;
                });
              },
            ),
            const SizedBox(),
            PopupMenuButton(
              itemBuilder: (BuildContext context) => 
              <PopupMenuEntry<String>>[
                const PopupMenuItem(child: Text("child 0"), value: "Value 0"),
                const PopupMenuItem(child: Text("child 1"), value: "Value 1"),
                const PopupMenuItem(child: Text("child 2"), value: "Value 2"),
              ],
              onSelected: popupMenuSelected
            )
          ],
        ),
      ),
    );
  }

  void popupButtonSelected(String value) {
    print(value);
  }

  void popupMenuSelected(String value) {
    print(value);
  }
}
