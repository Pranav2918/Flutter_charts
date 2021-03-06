import 'package:barchart_app/screens/bar_chart.dart';
import 'package:barchart_app/screens/barchart_impl.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyChartApp());
}

class MyChartApp extends StatelessWidget {
  const MyChartApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: BarChart(),
    );
  }
}