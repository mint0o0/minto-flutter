import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

class Statistics {
  final String id;
  final String festivalId;
  final DateTime date;
  final int localVisitor;
  final int foreignVisitor;
  final int localConsumption;
  final int foreignConsumption;
  final int restaurantConsumption;
  final int lodgingConsumption;
  final int shoppingConsumption;
  final int serviceConsumption;
  final List<Map<String, int>> completedMissionCount;

  Statistics({
    required this.id,
    required this.festivalId,
    required this.date,
    required this.localVisitor,
    required this.foreignVisitor,
    required this.localConsumption,
    required this.foreignConsumption,
    required this.restaurantConsumption,
    required this.lodgingConsumption,
    required this.shoppingConsumption,
    required this.serviceConsumption,
    required this.completedMissionCount,
  });

  factory Statistics.fromJson(Map<String, dynamic> json) {
    return Statistics(
      id: json['_id']['\$oid'],
      festivalId: json['festivalId'],
      date: DateTime.parse(json['date']['\$date']),
      localVisitor: json['localVisitor'],
      foreignVisitor: json['foreignVisitor'],
      localConsumption: json['localConsumption'],
      foreignConsumption: json['foreignConsumption'],
      restaurantConsumption: json['restaurantConsumption'],
      lodgingConsumption: json['lodgingConsumption'],
      shoppingConsumption: json['shoppingConsumption'],
      serviceConsumption: json['serviceConsumption'],
      completedMissionCount: List<Map<String, int>>.from(
          json['completedMissionCount']
              .map((item) => Map<String, int>.from(item))),
    );
  }
}

Future<List<Statistics>> fetchStatisticsData() async {
  final List<Map<String, dynamic>> jsonData = [
    {
      "_id": {"\$oid": "6641bb8bcdb1319953ec0c83"},
      "festivalId": "6632093c788e207ba11e5acf",
      "date": {"\$date": "2024-05-23T14:30:00Z"},
      "localVisitor": 150,
      "foreignVisitor": 75,
      "localConsumption": 50000,
      "foreignConsumption": 30000,
      "restaurantConsumption": 20000,
      "lodgingConsumption": 15000,
      "shoppingConsumption": 25000,
      "serviceConsumption": 10000,
      "completedMissionCount": [
        {"missionId1": 5},
        {"missionId2": 3},
        {"missionId3": 7}
      ]
    },
    {
      "_id": {"\$oid": "6641bb8bcdb1319953ec0c84"},
      "festivalId": "66321b54788e207ba11e5ada",
      "date": {"\$date": "2024-05-24T14:30:00Z"},
      "localVisitor": 200,
      "foreignVisitor": 90,
      "localConsumption": 60000,
      "foreignConsumption": 35000,
      "restaurantConsumption": 25000,
      "lodgingConsumption": 20000,
      "shoppingConsumption": 30000,
      "serviceConsumption": 15000,
      "completedMissionCount": [
        {"missionId1": 6},
        {"missionId2": 4},
        {"missionId3": 8}
      ]
    },
    {
      "_id": {"\$oid": "6641bb8bcdb1319953ec0c85"},
      "festivalId": "663e4d6a42c25b5dcd7af376",
      "date": {"\$date": "2024-05-25T14:30:00Z"},
      "localVisitor": 180,
      "foreignVisitor": 80,
      "localConsumption": 55000,
      "foreignConsumption": 32000,
      "restaurantConsumption": 22000,
      "lodgingConsumption": 16000,
      "shoppingConsumption": 27000,
      "serviceConsumption": 11000,
      "completedMissionCount": [
        {"missionId1": 7},
        {"missionId2": 5},
        {"missionId3": 9}
      ]
    },
    {
      "_id": {"\$oid": "6641bb8bcdb1319953ec0c86"},
      "festivalId": "6667cda45b2f6ddf38021915",
      "date": {"\$date": "2024-05-26T14:30:00Z"},
      "localVisitor": 170,
      "foreignVisitor": 85,
      "localConsumption": 57000,
      "foreignConsumption": 34000,
      "restaurantConsumption": 23000,
      "lodgingConsumption": 17000,
      "shoppingConsumption": 28000,
      "serviceConsumption": 12000,
      "completedMissionCount": [
        {"missionId1": 8},
        {"missionId2": 6},
        {"missionId3": 10}
      ]
    },
    {
      "_id": {"\$oid": "6641bb8bcdb1319953ec0c87"},
      "festivalId": "663215fc788e207ba11e5ad2",
      "date": {"\$date": "2024-05-27T14:30:00Z"},
      "localVisitor": 190,
      "foreignVisitor": 95,
      "localConsumption": 59000,
      "foreignConsumption": 36000,
      "restaurantConsumption": 24000,
      "lodgingConsumption": 18000,
      "shoppingConsumption": 29000,
      "serviceConsumption": 13000,
      "completedMissionCount": [
        {"missionId1": 9},
        {"missionId2": 7},
        {"missionId3": 11}
      ]
    }
  ];

  return jsonData.map((json) => Statistics.fromJson(json)).toList();
}

class AdminStatistics extends StatelessWidget {
  final String festivalId = Get.arguments as String;

  AdminStatistics({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 93, 167, 139),
        title: Text(
          '통계 보기',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'GmarketSans',
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: FutureBuilder<List<Statistics>>(
        future: fetchStatisticsData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 24),
                  const Text(
                    '일별 방문객 추이',
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'GmarketSans',
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                  Center(
                    child: SizedBox(
                      width: MediaQueryData.fromView(
                                  WidgetsBinding.instance.window)
                              .size
                              .width *
                          0.8,
                      height: MediaQueryData.fromView(
                                  WidgetsBinding.instance.window)
                              .size
                              .height *
                          0.4,
                      child: TotalVisitorTrendChart(
                          statisticsList: snapshot.data!),
                    ),
                  ),
                  SizedBox(height: 24),
                  Text(
                    '내/외국인 방문자 추이',
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'GmarketSans',
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                  Center(
                    child: SizedBox(
                      width: MediaQueryData.fromView(
                                  WidgetsBinding.instance!.window)
                              .size
                              .width *
                          0.8,
                      height: MediaQueryData.fromView(
                                  WidgetsBinding.instance!.window)
                              .size
                              .height *
                          0.4,
                      child: LocalForeignVisitorTrendChart(
                          statisticsList: snapshot.data!),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    '업종별 소비액 추이',
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'GmarketSans',
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                  Center(
                    child: SizedBox(
                      width: MediaQueryData.fromView(
                                  WidgetsBinding.instance.window)
                              .size
                              .width *
                          0.8,
                      height: MediaQueryData.fromView(
                                  WidgetsBinding.instance.window)
                              .size
                              .height *
                          0.4,
                      child: CategoryConsumptionTrendChart(
                          statisticsList: snapshot.data!),
                    ),
                  ),
                  SizedBox(height: 24),
                  const Text(
                    '완료된 미션 수',
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'GmarketSans',
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                  Center(
                    child: SizedBox(
                      width: MediaQueryData.fromView(
                                  WidgetsBinding.instance!.window)
                              .size
                              .width *
                          0.8,
                      height: MediaQueryData.fromView(
                                  WidgetsBinding.instance!.window)
                              .size
                              .height *
                          0.4,
                      child: CompletedMissionsChart(
                          statisticsList: snapshot.data!),
                    ),
                  ),
                  SizedBox(height: 24),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}

class CategoryConsumptionTrendChart extends StatelessWidget {
  final List<Statistics> statisticsList;

  CategoryConsumptionTrendChart({Key? key, required this.statisticsList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        barGroups: statisticsList.map((s) {
          return BarChartGroupData(
            x: s.date.millisecondsSinceEpoch,
            barRods: [
              BarChartRodData(
                toY: s.restaurantConsumption.toDouble(),
                color: Colors.orange,
              ),
              BarChartRodData(
                toY: s.lodgingConsumption.toDouble(),
                color: Colors.blue,
              ),
              BarChartRodData(
                toY: s.shoppingConsumption.toDouble(),
                color: Colors.green,
              ),
              BarChartRodData(
                toY: s.serviceConsumption.toDouble(),
                color: Colors.purple,
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}

class CompletedMissionsChart extends StatelessWidget {
  final List<Statistics> statisticsList;

  CompletedMissionsChart({Key? key, required this.statisticsList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        barGroups: statisticsList.map((s) {
          return BarChartGroupData(
            x: s.date.millisecondsSinceEpoch,
            barRods: s.completedMissionCount.map((mission) {
              return BarChartRodData(
                toY: mission.values.first.toDouble(),
                color: Colors.pink,
              );
            }).toList(),
          );
        }).toList(),
      ),
    );
  }
}

class LocalForeignVisitorTrendChart extends StatelessWidget {
  final List<Statistics> statisticsList;

  LocalForeignVisitorTrendChart({Key? key, required this.statisticsList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        gridData: FlGridData(show: false),
        titlesData: FlTitlesData(
            show: true,
            bottomTitles: AxisTitles(sideTitles: SideTitles(
              getTitlesWidget: (value, meta) {
                return Text(
                  DateFormat('MM-dd').format(
                      DateTime.fromMillisecondsSinceEpoch(value.toInt())),
                  style: TextStyle(color: Colors.black),
                );
              },
            ))),
        // borderData: FlBorderData(show: false),
        lineBarsData: [
          LineChartBarData(
            spots: statisticsList
                .map((s) => FlSpot(s.date.millisecondsSinceEpoch.toDouble(),
                    s.localVisitor.toDouble()))
                .toList(),
            isCurved: true,
            color: Colors.green,
            barWidth: 2,
          ),
          LineChartBarData(
            spots: statisticsList
                .map((s) => FlSpot(s.date.millisecondsSinceEpoch.toDouble(),
                    s.foreignVisitor.toDouble()))
                .toList(),
            isCurved: true,
            color: Colors.red,
            barWidth: 2,
          ),
        ],
        lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(
            // tooltipBgColor: Colors.blueAccent,
            getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
              return touchedBarSpots.map((barSpot) {
                final flSpot = barSpot;
                return LineTooltipItem(
                  '${DateTime.fromMillisecondsSinceEpoch(flSpot.x.toInt())} : ${flSpot.y}',
                  const TextStyle(color: Colors.white),
                );
              }).toList();
            },
          ),
        ),
      ),
    );
  }
}

class TotalVisitorTrendChart extends StatelessWidget {
  final List<Statistics> statisticsList;

  TotalVisitorTrendChart({Key? key, required this.statisticsList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        gridData: FlGridData(show: false),
        titlesData: FlTitlesData(
            show: true,
            bottomTitles: AxisTitles(sideTitles: SideTitles(
              getTitlesWidget: (value, meta) {
                return Text(
                  DateFormat('MM-dd').format(
                      DateTime.fromMillisecondsSinceEpoch(value.toInt())),
                  style: TextStyle(color: Colors.black),
                );
              },
            ))),
        // borderData: FlBorderData(show: false),
        lineBarsData: [
          LineChartBarData(
            spots: statisticsList
                .map((s) => FlSpot(s.date.millisecondsSinceEpoch.toDouble(),
                    (s.localVisitor + s.foreignVisitor).toDouble()))
                .toList(),
            isCurved: true,
            color: Colors.blue,
            barWidth: 2,
          ),
        ],
        lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(
            // tooltipBgColor: Colors.blueAccent,
            getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
              return touchedBarSpots.map((barSpot) {
                final flSpot = barSpot;
                return LineTooltipItem(
                  '${DateTime.fromMillisecondsSinceEpoch(flSpot.x.toInt())} : ${flSpot.y}',
                  const TextStyle(color: Colors.white),
                );
              }).toList();
            },
          ),
        ),
      ),
    );
  }
}
