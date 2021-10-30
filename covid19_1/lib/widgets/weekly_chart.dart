import 'package:covid19_1/constant.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../main.dart';

class WeeklyChart extends StatelessWidget {

  var myData;

  @override
  Widget build(BuildContext context) {
    // 데이터 사용 - 변경에 대한 알림 받기 true
    myData = Provider.of<MyData>(context, listen: true);

    return AspectRatio(
      aspectRatio: 1.7,
      child: BarChart(
        BarChartData(
          barGroups: getBarGroups(),
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(
            leftTitles: SideTitles(
              showTitles: false,
            ),
            bottomTitles: SideTitles(
              showTitles: true,
              getTitles: getDay,
            ),
          ),
        ),
      ),
    );
  }

  getBarGroups() {
    List<double> barChartDatas = [0, 0, 0, 0, 0, 0, 0];

    if (myData.barChartDatas.length != 0) {
      barChartDatas = myData.barChartDatas;
    }
    // print(barChartDatas);
    
    List<BarChartGroupData> barChartGroups = [];
    barChartDatas.asMap().forEach(
          (i, value) => barChartGroups.add(
            BarChartGroupData(
              x: i,
              barRods: [
                BarChartRodData(
                  y: value,
                  //This is not the proper way, this is just for demo
                  colors: i == 6 ? [kDeathColor] : [kInactiveChartColor],
                  width: 16,
                )
              ],
            ),
          ),
        );
    return barChartGroups;

  }

  String getDay(double value) {
    if (myData.barChartDay.length == 0)
      return '';
    else
      return myData.barChartDay[value.toInt()];
  }

}

String getWeek(double value) {
  switch (value.toInt()) {
    case 0:
      return 'MON';
    case 1:
      return 'TUE';
    case 2:
      return 'WED';
    case 3:
      return 'THU';
    case 4:
      return 'FRI';
    case 5:
      return 'SAT';
    case 6:
      return 'SUN';
    default:
      return '';
  }
}
