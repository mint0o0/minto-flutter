import 'package:minto/src/data/model/festival/festival_model.dart';
import 'package:minto/src/data/datasource/festival/festival_datasource.dart';

class FestivalRepository {
  final FestivalDataSource _festivalDataSource = FestivalDataSource();

  Future<List<FestivalModel>> getFestivals() async {
    return await _festivalDataSource.getFestivals();
  }
}
