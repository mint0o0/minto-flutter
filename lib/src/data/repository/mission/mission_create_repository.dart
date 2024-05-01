import 'package:minto/src/data/model/mission/mission_create_model.dart';
import 'package:minto/src/data/datasource/mission/mission_create_datasource.dart';

class MissionCreateRepository {
  final MissionCreateDataSource _missionCreateDataSource =
      MissionCreateDataSource();

  Future<void> createMission(MissionCreateModel missionCreateModel) async {
    return await _missionCreateDataSource.createMission(missionCreateModel);
  }
}
