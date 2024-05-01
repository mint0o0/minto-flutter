import 'package:minto/src/data/model/festival/festival_statistics_model.dart';

class FestivalStatisticsDataSource {
  Future<FestivalStatisticsModel> getFestivalStatistics() async {
    return FestivalStatisticsModel(
        visitor_male: 450,
        visitor_female: 550,
        visitor_10s: 200,
        visitor_20s: 400,
        visitor_30s: 300,
        visitor_40s: 250,
        visitor_50s_over: 150,
        visitor_by_date: [
          {'4월 1일': 200},
          {'4월 2일': 350},
          {'4월 3일': 500},
          {'4월 4일': 450},
          {'4월 5일': 600},
          {'4월 6일': 700},
          {'4월 7일': 800}
        ],
        visitor_local: 800,
        visitor_foreign: 700,
        consumption_by_date: [
          {'4월 1일': 10000},
          {'4월 2일': 15000},
          {'4월 3일': 20000},
          {'4월 4일': 18000},
          {'4월 5일': 22000},
          {'4월 6일': 25000},
          {'4월 7일': 28000}
        ],
        completed_mission_by_date: [
          {'미션1': 50},
          {'미션2': 30},
          {'미션3': 40},
          {'미션4': 25}
        ]);
    }
}