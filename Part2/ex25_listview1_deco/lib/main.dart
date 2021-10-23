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
        visualDensity: VisualDensity.adaptivePlatformDensity,
        // ListTime 클릭시 리플 효과 색상 변경
        splashColor: Colors.red,
        // 불투명한 색상보다 스플래시 효과를 더 강조한다.
        highlightColor: Colors.black.withOpacity(.5),
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

  var _checkboxValue = false;
  var _radioValue = 0;
  var _switdhValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: getMyList(),
      ),
    );
  }

  List<Widget> getMyList() {
    List<Widget> myList = [
      Container(
        // width: double.infinity,       // 안드로이드에서 match_parent
        height: 100,
        alignment: Alignment.center,
        color: Colors.amber[600],
        child: Text('onTab이 없어 클릭 안됨', style: TextStyle(fontSize: 30),)
      ),
      ListTile(
        title: Text('Basic #1'),
        subtitle: Text('타이틀과 서브타이틀로만 구성'),
        trailing: Icon(Icons.more_vert),
        onTap: () {
          print('Basic #1');
        },
      ),
      Divider(
        color: Colors.black,
        height: 5,
        indent: 10,
        endIndent: 10,
      ),
      ListTile(
        leading: FlutterLogo(size: 50.0,),
        title: Text('Basic #2'),
        trailing: Icon(Icons.autorenew),
        onTap: () {
          print('Basic #2');
        },
      ),
      Divider(
        color: Colors.black,
        height: 5,
      ),
      ListTile(
        leading: Icon(
          Icons.account_box,
          size: 50.0,
        ),
        title: Text('Basic #3'),
        subtitle: Text('기본형의 모든 요소 사용'),
        trailing: Icon(Icons.arrow_back_ios),
        onTap: () {
          print('Basic #3');
        },
      ),
      Divider(
        color: Colors.black,
        height: 5,
      ),
      ListTile(
        leading: Icon(
          Icons.account_box,
          size: 50.0,
        ),
        title: Text('Basic #3 - isThreeLine: false'),
        subtitle: Text('내용이 길면 다음 줄로 내용이 넘어간다. 그러나 공간이 확장 어쩌고 저쩌고 북치기 박치기 퓨슈퓨슉 냠냠 자장면 피자 햄버거 양아치 아이코스 슬기로운 산촌생활'),
        trailing: Icon(Icons.arrow_back_ios),
        onTap: () {
          print('Basic #3 - isThreeLine: false');
        },
      ),
      Divider(
        color: Colors.black,
        height: 5,
      ),
      ListTile(
        leading: Icon(
          Icons.account_box,
          size: 50.0,
        ),
        title: Text('Basic #3 - isThreeLine: true'),
        subtitle: Text('내용이 길면 다음 줄로 내용이 넘어간다. 그러나 공간이 확장 어쩌고 저쩌고 북치기 박치기 퓨슈퓨슉 냠냠 자장면 피자 햄버거 양아치 아이코스 슬기로운 산촌생활'),
        isThreeLine: true,
        trailing: Icon(Icons.arrow_back_ios),
        onTap: () {
          print('Basic #3 - isThreeLine: true');
        },
      ),
      Divider(
        color: Colors.black,
        height: 5,
      ),
      CheckboxListTile(
        value: _checkboxValue, 
        title: Text('CheckBox ListTile'),
        secondary: _checkboxValue ? Icon(Icons.thumb_up) : Icon(Icons.thumb_down),
        onChanged: (bool? value) {
          setState(() {
            _checkboxValue = value!;
          });
          print('CheckBox ListTile');
        },
      ),
      Divider(
        color: Colors.black,
        height: 5,
      ),
      RadioListTile(
        title: Text('GOOD'),
        groupValue: _radioValue, 
        value: 1, 
        selected: true,
        onChanged: (int? value) {
          setState(() {
            _radioValue = value!;
          });
        }
      ),
      Divider(
        color: Colors.black,
        height: 5,
      ),
      SwitchListTile(
        title: Text('Switch ListTile'),
        subtitle: Text(_switdhValue?'on':'off'),
        value: _switdhValue, 
        onChanged: (bool value) {
          setState(() {
            _switdhValue = value;
          });
          print('Switch ListTile');
        },
        secondary: Icon(Icons.lightbulb_outline),
      ),
      // 클릭시 리플 효과 표시됨(Card -> ListTile)
      Card(
        color: Colors.amber[100],
        elevation: 0,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.black, width: 1),
          borderRadius: BorderRadius.circular(0),
        ),
        child: ListTile(
          leading: Icon(
            Icons.account_box,
            size: 50.0,
          ),
          title: Text(
            'Card -> ListTile',
            style: TextStyle(fontSize: 18, color: Colors.blue),
          ),
          subtitle: Text('클릭시 리플 효과 표시됨'),
          trailing: Icon(Icons.arrow_forward_ios),
          onTap: () {
            print('fff');
          },
        ),
      ),
      // 클릭시 리플 효과 표시됨(Card -> InkWell)
      Card(
        color: Colors.amber[100],
        elevation: 0,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.black, width: 1),
          borderRadius: BorderRadius.circular(0),
        ),
        child: InkWell(
          onTap: () {
            print('ggg');
          },
          child: Row(
            children: [
              SizedBox(
                width: 100,
                height: 150,
                child: Icon(
                  Icons.account_box,
                  size: 50.0,
                ),
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Title",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "location",
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Population: 22 / 06/ 2020',
                          style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Icon(Icons.data_usage),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        )
      ),
    ];

    return myList;
  }
}
