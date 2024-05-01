import 'package:minto/src/data/model/mission/mission_model.dart';

class MissionDataSource {
  Future<List<MissionModel>> getMissions() async {
    return Future.delayed(Duration(seconds: 1), () {
      return [
        MissionModel(
          id: "1",
          name: "name",
          description: "description",
          startTime: DateTime.now().toString(),
          endTime: DateTime.now().toString(),
          imageList: [],
          location: "location",
          createdDate: DateTime.now().toString(),
          updateDate: DateTime.now().toString(),
        ),
        MissionModel(
          id: "2",
          name: "name",
          description: "description",
          startTime: DateTime.now().toString(),
          endTime: DateTime.now().toString(),
          imageList: [],
          location: "location",
          createdDate: DateTime.now().toString(),
          updateDate: DateTime.now().toString(),
        ),
      ];
    });
  }

  Future<void> createMission(MissionModel missionModel) async {
    return Future.delayed(Duration(seconds: 1), () {
      return;
    });
  }
}
