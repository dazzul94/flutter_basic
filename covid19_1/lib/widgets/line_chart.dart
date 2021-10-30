import 'package:covid19_1/constant.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../main.dart';

class LineReportChart extends StatelessWidget {

  var myData;

  @override
  Widget build(BuildContext context) {
    // 데이터 사용 - 변경에 대한 알림 받기 true
    myData = Provider.of<MyData>(context, listen: true);
    
    return AspectRatio(
      aspectRatio: 2.2,
      child: LineChart(
        LineChartData(
          gridData: FlGridData(show: true),
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: getSports(),
              isCurved: false,
              dotData: FlDotData(show: true),
              belowBarData: BarAreaData(show: false),
              colors: [kPrimaryColor],
              barWidth: 4,
            ),
          ],
        ),
      ),
    );
  }

  List<FlSpot> getSports() {
    List<double> barChartDatas = [0, 0, 0, 0, 0, 0, 0];

    if (myData.barChartDatas.length != 0) {
      barChartDatas = myData.barChartDatas;
    }
    List<FlSpot> flspots = [];


    for(int i = 0; i < barChartDatas.length; i++) {
      flspots.add(FlSpot(i.toDouble(), barChartDatas[i]));
    }
    return flspots;

    // return [
    //   FlSpot(0, .5),
    //   FlSpot(1, 1.5),
    //   FlSpot(2, .5),
    //   FlSpot(3, .7),
    //   FlSpot(4, .2),
    //   FlSpot(5, 2),
    //   FlSpot(6, 1.5),
    //   FlSpot(7, 1.7),
    //   FlSpot(8, 1),
    //   FlSpot(9, 2.8),
    //   FlSpot(10, 2.5),
    //   FlSpot(11, 2.65),
    // ];
  }
}
