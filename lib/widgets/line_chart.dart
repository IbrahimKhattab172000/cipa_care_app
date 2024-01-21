import 'package:cipa_care_app/models/temprature.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class LineChart extends StatelessWidget {
  final String title;
  final List<Temperature> data;
  final Color color;

  const LineChart({
    Key? key,
    required this.title,
    required this.data,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      primaryXAxis: CategoryAxis(),
      title: ChartTitle(
        text: title,
        backgroundColor: Colors.white,
        alignment: ChartAlignment.center,
      ),
      tooltipBehavior: TooltipBehavior(enable: true),
      series: <LineSeries<Temperature, String>>[
        LineSeries<Temperature, String>(
          dataSource: data,
          color: Colors.transparent,
          pointColorMapper: (Temperature temperature, _) => Colors.white,
          xValueMapper: (Temperature temperature, _) =>
              DateFormat('MM/dd HH:mm').format(temperature.timeStamp.toLocal()),
          yValueMapper: (Temperature temperature, _) =>
              temperature.degree.toDouble(),
          dataLabelSettings: const DataLabelSettings(
            isVisible: true,
            textStyle: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
