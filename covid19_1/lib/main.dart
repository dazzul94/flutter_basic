import 'package:covid19_1/constant.dart';
import 'package:flutter/material.dart';
import 'package:covid19_1/screen/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';    // utf8.decode, jsonDecode
import 'package:xml2json/xml2json.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MyData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Covid 19',
        theme: ThemeData(
            scaffoldBackgroundColor: kBackgroundColor,
            fontFamily: "Poppins",
            // textTheme: TextTheme(
            //   body1: TextStyle(color: kBodyTextColor),
            // )
        ),
        home: HomeScreen(),
      ),
    );
  }
}

class MyData extends ChangeNotifier {
  int decideCnt = 0;
  int clearCnt = 0;
  int deathCnt = 0; 
  String stateDt = '';
  List<double> barChartDatas = [];
  List<String> barChartDay = [];

  MyData() {
    _getRequest().then((value) {
      notifyListeners();
    });
  }
  
  Future<void> _getRequest() async {
    // 일반적으로 8일치면 계산이 됨 -7
    // 아침에는 오늘 데이터가 없어서 9일치가 필요 -8
    // 주말에는 전날 데이터가 없어서 10일치가 필요 -9
    String sToday = DateTime.now()
                            .toString().substring(0, 10).replaceAll('-', '');
    String sYesterday = DateTime.now()
                                .add(Duration(days: -9))
                                .toString().substring(0, 10).replaceAll('-', '');
    // print(sToday);
    // print(sYesterday);

    String sUrl = 'http://openapi.data.go.kr/openapi/service/rest/Covid19/getCovid19InfStateJson';
    // String var1 = Uri.encodeQueryComponent('sServiceKey');
    String var1 = 'serviceKey=Jq85ygWHIFokHtft66EcimSFCbh17XbOauqOKruJKWNqmDizs1gmtFyoWpn0G3ZZW25K06slCQfmWtDGlzV7dA%3D%3D';
    String var2 = 'pageNo=1';
    String var3 = 'numOfRows=20';
    String var4 = 'startCreateDt=$sYesterday';
    String var5 = 'endCreateDt=$sToday';
    String sReqUrl = "$sUrl?$var1&$var2&$var3&$var4&$var5";
    print(sReqUrl);

    var url = Uri.parse(sReqUrl);
    http.Response response = await http.get(
        url,
        // headers: {"Accept": "application/xml"}
    );
    
    var statusCode = response.statusCode; 
    if (statusCode == 200) {
      var responseBody = utf8.decode(response.bodyBytes); // for 한글
      // print(responseBody);
      getXMLData(responseBody);
    }
  }

  void getXMLData(String xmlData) {

    Xml2Json xml2json = Xml2Json();
    xml2json.parse(xmlData);
    var json = xml2json.toParker(); // the only method that worked for my XML type.
    // print(json);    // <-- String

    var data1 = jsonDecode(json);
    // print(data1);   // Json Object
    // print(data1['response']['body']['items']['item']);

    List data2 = data1['response']['body']['items']['item'];
    // List data2 = data1['response']['body']['items'];
    // Map data31 = data2[0];
    // print(data31);

    stateDt = data2[0]['stateDt'].substring(0, 4) + '-' +
              data2[0]['stateDt'].substring(4, 6) + '-' +
              data2[0]['stateDt'].substring(6, 8);
    print(data2.length);

    for (int i=6; i>=0; i--) {
      int cnt1 = int.tryParse(data2[i]['decideCnt']) ?? 0;      // 오늘 
      int cnt2 = int.tryParse(data2[i + 1]['decideCnt']) ?? 0;  // 어제
      int cnt = cnt1 - cnt2;
      barChartDatas.add(cnt.toDouble());

      String sStateDt = data2[i]['stateDt'].substring(4, 8);

      barChartDay.add(sStateDt);
    }
    print(barChartDay);

    int decideCnt1 = int.tryParse(data2[0]['decideCnt']) ?? 0;  // 오늘 
    int decideCnt2 = int.tryParse(data2[1]['decideCnt']) ?? 0;  // 어제
    // print(decideCnt);
    decideCnt = decideCnt1 - decideCnt2;

    int deathCnt1 = int.tryParse(data2[0]['deathCnt']) ?? 0;  // 오늘 
    int deathCnt2 = int.tryParse(data2[1]['deathCnt']) ?? 0;  // 어제
    // print(deathCnt);
    deathCnt = deathCnt1 - deathCnt2;

    int clearCnt1 = int.tryParse(data2[0]['clearCnt']) ?? 0;  // 오늘 
    int clearCnt2 = int.tryParse(data2[1]['clearCnt']) ?? 0;  // 어제
    clearCnt = clearCnt1 - clearCnt2;
  }

}

