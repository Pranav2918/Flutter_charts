import 'package:barchart_app/model/gender_model.dart';
import 'package:barchart_app/network/network_helper.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class BarChart extends StatefulWidget {
  const BarChart({Key? key}) : super(key: key);

  @override
  State<BarChart> createState() => _BarChartState();
}

class _BarChartState extends State<BarChart> {

  List<GenderModel> genderList = [];
  bool isLoading = true;
  NetworkHelper _networkHelper = NetworkHelper();


  @override
  void initState() {
    getGenderData();
    super.initState();
  }

  void getGenderData() async {
    var response = await _networkHelper.get("https://api.genderize.io/?name[]=Thor&name[]=Tonny&name[]=Hulk&name[]=Pranav&name[]=Maeve");
    print("Res ${response.body}");
    List<GenderModel> tempData = genderModelFromJson(response.body);
    setState(() {
      genderList = tempData;
      isLoading = false;
    });
  }

  List<charts.Series<GenderModel, String>> generateData() {
    return [
      charts.Series<GenderModel, String>(
        data: genderList,
        id: 'gender',
        colorFn: (_, __) => charts.MaterialPalette.teal.shadeDefault,
        domainFn: (GenderModel genderModel, _) => genderModel.name,
        measureFn: (GenderModel genderModel, _) => genderModel.count,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bar Chart With API"),
      ),
      body: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : Container(
                height: 300,
                child: charts.BarChart(
                  generateData(),
                  animate: true,
                ),
              ),
      ),
    );
  }
}
