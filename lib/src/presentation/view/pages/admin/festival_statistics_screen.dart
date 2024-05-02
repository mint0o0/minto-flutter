import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minto/src/presentation/view/widgets/chart_widget.dart';

class FestivalStatisticsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.back(),
        child: const Icon(Icons.arrow_back),
      ),
      body: SafeArea(
        child: Center(
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              ChartWidget.buildPieChart(
                title: '남/여 비율',
                data: [
                  ChartData('남성', 450),
                  ChartData('여성', 550),
                ],
              ),
              ChartWidget.buildPieChart(
                title: '연령대 분포',
                data: [
                  ChartData('10대', 200),
                  ChartData('20대', 400),
                  ChartData('30대', 300),
                  ChartData('40대', 250),
                  ChartData('50대', 150),
                ],
              ),
              ChartWidget.buildLineChart(
                title: '일별 방문자 추이',
                data: [
                  ChartData('4월 1일', 200),
                  ChartData('4월 2일', 350),
                  ChartData('4월 3일', 500),
                  ChartData('4월 4일', 450),
                  ChartData('4월 5일', 600),
                  ChartData('4월 6일', 700),
                  ChartData('4월 7일', 800),
                ],
              ),
              ChartWidget.buildPieChart(
                title: '내/외국인 비율',
                data: [
                  ChartData('내국인', 800),
                  ChartData('외국인', 700),
                ],
              ),
              ChartWidget.buildLineChart(
                title: '소비액 추이',
                data: [
                  ChartData('4월 1일', 10000),
                  ChartData('4월 2일', 15000),
                  ChartData('4월 3일', 20000),
                  ChartData('4월 4일', 18000),
                  ChartData('4월 5일', 22000),
                  ChartData('4월 6일', 25000),
                  ChartData('4월 7일', 28000),
                ],
              ),
              ChartWidget.buildBarChart(
                title: '미션 완료 통계',
                data: [
                  ChartData('미션1', 50),
                  ChartData('미션2', 30),
                  ChartData('미션3', 40),
                  ChartData('미션4', 25),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
