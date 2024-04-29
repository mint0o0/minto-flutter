import 'package:minto/src/data/model/mission/mission_create_model.dart';

class MissionCreateDataSource {
  Future<void> createMission(MissionCreateModel missionCreateModel) async {
    return Future.delayed(Duration(seconds: 1), () {
      return;
    });
  }
}
