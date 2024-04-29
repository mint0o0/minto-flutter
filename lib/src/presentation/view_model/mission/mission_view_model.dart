import 'package:minto/src/data/model/mission/mission_model.dart';
import 'package:minto/src/data/repository/mission/mission_repository.dart';
import 'package:get/get.dart';

class MissionViewModel extends GetxController {
  final MissionRepository _missionRepository = MissionRepository();
  final RxList<MissionModel> missionList = <MissionModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchMissions();
  }

  Future<void> fetchMissions() async {
    final List<MissionModel> missions = await _missionRepository.getMissions();
    missionList.assignAll(missions);
  }
}
