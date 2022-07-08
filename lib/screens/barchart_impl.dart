import 'dart:math';

import 'package:barchart_app/model/data_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BarchartImpl extends StatelessWidget {
  BarchartImpl({Key? key}) : super(key: key);

   final List<ChartDataItem> _myData = List.generate(
      18,
      (index) => ChartDataItem(
            x: index,
            y1: Random().nextInt(20) + Random().nextDouble(),
            y2: Random().nextInt(20) + Random().nextDouble(),
            y3: Random().nextInt(20) + Random().nextDouble(),
          ));

  @override
  Widget build(BuildContext context) {

    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bar Chart Implementation'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SizedBox(
            width: 3000,
            child: BarChart(BarChartData(
                borderData: FlBorderData(
                    border: const Border(
                  top: BorderSide.none,
                  right: BorderSide.none,
                  left: BorderSide(width: 1),
                  bottom: BorderSide(width: 1),
                )),
                groupsSpace: 10,
                barGroups: _myData
                    .map((dataItem) =>
                        BarChartGroupData(x: dataItem.x, barRods: [
                          BarChartRodData(
                              toY: dataItem.y1,
                              width: 10,
                              color: Colors.red),
                          // BarChartRodData(
                          //     toY: dataItem.y2, width: 15, color: Colors.red),
                          // BarChartRodData(
                          //     toY: dataItem.y3, width: 15, color: Colors.blue),
                        ]))
                    .toList())),
          ),
        ),
      ),
    );
  }
}