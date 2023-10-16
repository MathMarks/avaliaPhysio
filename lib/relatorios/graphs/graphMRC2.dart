import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class graphmrcT extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  //graphmrcT({Key? key}) : super(key: key);
  final List<_AvalData> dataAval;
  const graphmrcT({Key? key, required this.dataAval}) : super(key: key);

  @override
  State<graphmrcT> createState() => graphmrcTState();
}

class graphmrcTState extends State<graphmrcT> {
  List<_AvalData> data = [];

  @override
  void initState() {
    // TODO: implement initState
    data = widget.dataAval;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.dataAval);
    return Scaffold(
        appBar: AppBar(
          title: const Text('MRCs realizados'),
        ),
        body: Column(children: [
          //Initialize the chart widget
          SfCartesianChart(
              primaryXAxis: CategoryAxis(labelRotation: 90),
              // Chart title
              title: ChartTitle(text: 'Analise dos resultados das avaliações'),
              // Enable legend
              legend: Legend(isVisible: false),
              // Enable tooltip
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <ChartSeries<_AvalData, String>>[
                LineSeries<_AvalData, String>(
                    dataSource: data,
                    xValueMapper: (_AvalData sales, _) => sales.year,
                    yValueMapper: (_AvalData sales, _) => sales.sales,
                    name: 'Resultado',
                    // Enable data label
                    dataLabelSettings: const DataLabelSettings(isVisible: true))
              ]),
          // Expanded(
          //   child: Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     //Initialize the spark charts widget
          //     child: SfSparkLineChart.custom(
          //       //Enable the trackball
          //       trackball: SparkChartTrackball(
          //           activationMode: SparkChartActivationMode.tap),
          //       //Enable marker
          //       marker: SparkChartMarker(
          //           displayMode: SparkChartMarkerDisplayMode.all),
          //       //Enable data label
          //       labelDisplayMode: SparkChartLabelDisplayMode.all,
          //       xValueMapper: (int index) => data[index].year,
          //       yValueMapper: (int index) => data[index].sales,
          //       dataCount: 5,
          //     ),
          //   ),
          // )
        ]));
  }
}

class _AvalData {
  _AvalData(this.year, this.sales);

  final String year;
  final int sales;
}

List<_AvalData> buildGraphData(
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docsAval) {
  var row = [];
  var nomeFisioSnap;
  String date;
  _AvalData test;

  List<_AvalData> listaDeAval = [];

  List<List<dynamic>> resultado = [];

  for (var element in docsAval) {
    row.add(element['resultado']);
    date = DateFormat('dd/MM/yy HH:mm:ss')
        .format(element['data'].toDate())
        .toString();
    row.add(date);
    //print(row);
    resultado.add(row);
    test = _AvalData(date, element['resultado']);
    listaDeAval.add(test);
    //print(resultado);
    row = [];
  }

  //print(listaDeAval[1].year);

  return listaDeAval;
}

List<List<String>> buildCsvData(
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docsAval) {
  List<String> row = [];
  String date;
  _AvalData test;
  int num = 0;
  List<List<String>> resultado = [];

  for (var element in docsAval) {
    row.add(num.toString());
    row.add(element['resultado'].toString());
    date = DateFormat('dd/MM/yy HH:mm:ss')
        .format(element['data'].toDate())
        .toString();
    row.add(date);
    // print(row);
    resultado.add(row);

    test = _AvalData(date, element['resultado']);

    // print(resultado);
    row = [];
    num++;
  }

  return resultado;
}
