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
  // 별도의 설정없이도 로컬 시간이 표시된다.
  String _selectedDate = DateTime.now().toString();

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
            Text('$_selectedDate', style: TextStyle(fontSize: 30),),
            ElevatedButton(
              child: const Text('Show DatePicker', 
                                style: TextStyle(fontSize: 24),),
              onPressed: () => selectDate(), 
            )
          ],
        ),
      ),
    );
  }

  DateTime selectNowDate() {
    DateTime _now =  DateTime.now();
    return _now;
  }

  bool _predicate(DateTime day) {
    // if ( (day.isAfter(DateTime(2020, 1, 5)) && 
    //       day.isBefore(DateTime(2020, 1, 9)))) {
    //   return true;
    // }
    // if (day.weekday != 6 && day.weekday != 7) {
    //   if (day != DateTime(day.year, day.month, 25)) {
    //     return true;
    //   }
    //   return true;
    // }

    List days = [1, 2, 3, 4, 5, 6, 7];
    if (!days.contains(day.day.toInt())) {
      return true;
    }
    return false;
  }

  Future selectDate() async {
    DateTime _now = DateTime.now();

    DateTime? picked = await showDatePicker(
      context: context, 
      // initialDatePickerMode: DatePickerMode.year,
      initialDate: selectNowDate(), 
      firstDate: DateTime(_now.year - 2),
      lastDate: DateTime(_now.year + 2),
      selectableDayPredicate: _predicate,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          // ThemeData.light(), ThemeData.dark()
          data: ThemeData(primarySwatch: Colors.pink), 
          child: child!
        )
      },
    );
    if(picked != null) {
      setState(() {
        _selectedDate = picked.toString().substring(0, 10);
      });
    }
  }
}
