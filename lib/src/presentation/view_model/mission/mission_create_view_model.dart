import 'package:minto/src/data/model/mission/mission_create_model.dart';
import 'package:minto/src/data/repository/mission/mission_create_repository.dart';
import 'package:get/get.dart';

class MissionCreateViewModel extends GetxController {
  final MissionCreateRepository _missionCreateRepository =
      MissionCreateRepository();
  final Rx<MissionCreateModel> missionCreateModel = MissionCreateModel(
          id: "id",
          name: "name",
          description: "description",
          startTime: DateTime.now().toString(),
          endTime: DateTime.now().toString(),
          location: "location",
          imageList: [],
          createdDate: DateTime.now().toString())
      .obs;

  Future<void> createMission(MissionCreateModel missionCreateModel) async {
    await _missionCreateRepository.createMission(missionCreateModel);
  }
}
