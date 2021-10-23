import 'dart:io';

// 비동기를 사용하는 경우
void main() async {
  // print('시작1');
  // myRequest1();
  // print('끝1');

  // 결과를 기다렸다 변수에 받음
  print('시작2');

  // var val = await myRequest2(10);
  var val = await myRequest3(10);
  print('val : $val');
  print('끝2');
}

Future<int> myRequest1() async {
  print('요청 시작1');
  for (int i = 0; i < 10; i++) {
    stdout.write('$i ');

    await Future.delayed(Duration(seconds: 1));
  }
  print('\n 요청 끝1');
  return 10;
}

Future<int> myRequest2(num) {
  // 결과가 미래에 생김
  var req = Future(() {
    print('작업 시작2');
    int rNum = 0;
    for (int i = 0; i < num; i++) {
      rNum = rNum + i;
    }
    print('작업 끝2');
    return rNum;
  });
  return req;
}

Future<int> myRequest3(num) {
  // 결과가 미래에 생김
  return Future(() {
    print('작업 시작3');
    int rNum = 0;
    for (int i = 0; i < num; i++) {
      rNum = rNum + i;
    }
    print('작업 끝3');
    return rNum;
  });
}