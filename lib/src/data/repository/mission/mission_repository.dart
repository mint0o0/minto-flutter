import 'package:minto/src/data/datasource/mission/mission_datasource.dart';
import 'package:minto/src/data/model/mission/mission_model.dart';

class MissionRepository {
  final MissionDataSource _missionDataSource = MissionDataSource();

  Future<List<MissionModel>> getMissions() async {
    return await _missionDataSource.getMissions();
  }
}
