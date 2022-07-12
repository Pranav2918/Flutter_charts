import 'package:barchart_app/model/gender_model.dart';
import 'package:barchart_app/network/network_helper.dart';
import 'package:barchart_app/utils/custom_painter.dart';
import 'package:charts_flutter/flutter.dart';
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
  final NetworkHelper _networkHelper = NetworkHelper();

  @override
  void initState() {
    getGenderData();
    super.initState();
  }

  void getGenderData() async {
    var response = await _networkHelper.get(
        "https://api.genderize.io/?name[]=Thor&name[]=Tonny&name[]=Hulk&name[]=Pranav&name[]=Maeve");
    print("Response: ${response.body}");
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
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (GenderModel genderModel, _) => genderModel.name,
        measureFn: (GenderModel genderModel, _) => genderModel.count,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bar Chart With API"),
      ),
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : SizedBox(
                height: 300,
                child: charts.BarChart(
                  behaviors: [
                    LinePointHighlighter(
                        symbolRenderer:
                            CustomCircleSymbolRenderer()
                        )
                  ],
                  selectionModels: [
                    SelectionModelConfig(
                        changedListener: (SelectionModel model) {
                      if (model.hasDatumSelection) {
                        final value = model.selectedSeries[0]
                            .measureFn(model.selectedDatum[0].index);
                        CustomCircleSymbolRenderer.value = value.toString(); // paints the tapped value
                      }
                    })
                  ],
                  generateData(),
                  animate: true,
                ),
              ),
      ),
    );
  }
}
