import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartData {
  final String label;
  final double value;

  ChartData(this.label, this.value);
}

class ChartWidget {
  static Widget buildPieChart(
      {required String title, required List<ChartData> data}) {
    return Column(
      children: [
        Text(title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        SfCircularChart(
          legend: const Legend(isVisible: true),
          tooltipBehavior: TooltipBehavior(enable: true),
          series: <CircularSeries>[
            PieSeries<ChartData, String>(
              dataSource: data,
              xValueMapper: (ChartData data, _) => data.label,
              yValueMapper: (ChartData data, _) => data.value,
              dataLabelMapper: (ChartData data, _) => data.label,
              dataLabelSettings: const DataLabelSettings(isVisible: true),
            ),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  static Widget buildLineChart(
      {required String title, required List<ChartData> data}) {
    return Column(
      children: [
        Text(title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        SfCartesianChart(
          primaryXAxis: const CategoryAxis(),
          series: <LineSeries<ChartData, String>>[
            LineSeries<ChartData, String>(
              dataSource: data,
              xValueMapper: (ChartData data, _) => data.label,
              yValueMapper: (ChartData data, _) => data.value,
            ),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  static Widget buildBarChart(
      {required String title, required List<ChartData> data}) {
    return Column(
      children: [
        Text(title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        SfCartesianChart(
          primaryXAxis: const CategoryAxis(),
          series: <BarSeries<ChartData, String>>[
            BarSeries<ChartData, String>(
              dataSource: data,
              xValueMapper: (ChartData data, _) => data.label,
              yValueMapper: (ChartData data, _) => data.value,
            ),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
