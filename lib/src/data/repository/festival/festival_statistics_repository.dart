import 'package:minto/src/data/datasource/festival/festival_statistics_datasource.dart';
import 'package:minto/src/data/model/festival/festival_statistics_model.dart';

class FestivalStatisticsRepository {
  final FestivalStatisticsDataSource _festivalStatisticsDataSource =
      FestivalStatisticsDataSource();

  Future<FestivalStatisticsModel> getFestivalStatistics() async {
    return await _festivalStatisticsDataSource.getFestivalStatistics();
  }
}
