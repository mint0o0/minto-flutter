import 'package:minto/src/data/model/festival/festival_model.dart';
import 'package:minto/src/data/repository/festival/festival_repository.dart';
import 'package:get/get.dart';

class FestivalViewModel extends GetxController {
  final FestivalRepository _festivalRepository = FestivalRepository();
  final RxList<FestivalModel> festivalList = <FestivalModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchFestivals();
  }

  Future<void> fetchFestivals() async {
    final List<FestivalModel> festivals =
        await _festivalRepository.getFestivals();
    festivalList.assignAll(festivals);
  }
}
