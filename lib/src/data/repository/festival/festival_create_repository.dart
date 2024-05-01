import 'package:minto/src/data/model/festival/festival_create_model.dart';
import 'package:minto/src/data/datasource/festival/festival_create_datasource.dart';

class FestivalCreateRepository {
  final FestivalCreateDataSource _festivalCreateDataSource =
      FestivalCreateDataSource();

  Future<void> createFestival(FestivalCreateModel festivalCreateModel) async {
    return await _festivalCreateDataSource.createFestival(festivalCreateModel);
  }
}
