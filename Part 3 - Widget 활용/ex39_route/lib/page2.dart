import 'package:flutter/material.dart';

class Page2 extends StatefulWidget {
  String data = '';
  Page2({Key? key, required this.data}) : super(key: key);

  @override
  _Page2State createState() => _Page2State();
}


class _Page2State extends State<Page2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page 2'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text('2페이지 추가',
                                style: TextStyle(fontSize: 24),),
              onPressed: () async {
                // var 로 설정, String으로 받으면 에러 발생
                var result = await Navigator.pushNamed(context, '/page2');
                print('result(from 2) : $result');
                setState(() {
                  widget.data = result as String;
                });
              }, 
            ),
            const SizedBox(height: 20,),
            ElevatedButton(
              child: const Text('3페이지 추가',
                                style: TextStyle(fontSize: 24)),
              onPressed: () async {
                await Navigator.pushNamed(
                  context, '/page3'
                ).then((result) {
                  print('result(from 3 : $result');
                  setState(() {
                    widget.data = result as String;
                  });
                });
              },
            ),
            Text(widget.data, style: const TextStyle(fontSize: 30),),
          ],
        ),
      ),
    );
  }

}