void main() {
  print('시작 1-1');
  var myReq1 = myRequest1(10);
  myReq1.then( (data) {
    // 결과가 오면 나중에 출력
    print('작업1-1 : $data');
  }, onError: (e) {
    print(e);
  });
  print('끝 1-1');
  print('======================================');

  print('시작 1-2');
  myRequest1(10).then( (data) {
    // 결과가 오면 나중에 출력
    print('작업1-2 : $data');
  }, onError: (e) {
    print(e);
  });
  print('끝 1-2');
  print('======================================');

  int nCount = 10;

  // 클래스 형태로 사용하기
  Future<int> myRequest2 = new Future(() {
    int rNum = 10;
    for (int i = 0; i < nCount; i++) {
      rNum = rNum + i;
    }
    return rNum;
  });

  print('시작2');
  myRequest2.then( (data) {
    // 결과가 오면 나중에 출력
    print('작업2 : $data');
  }, onError: (e) {
    print(e);
  });
  print('끝2');
}

// 메서드 형태로 사용하기
Future<int> myRequest1(num) {
  return Future(() {
    int rNum = 10;
    for (int i = 0; i < num; i++) {
      rNum = rNum + i;
    }
    return rNum;
  });
}