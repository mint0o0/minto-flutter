import 'package:minto/src/data/model/festival/festival_create_model.dart';
import 'package:minto/src/data/repository/festival/festival_create_repository.dart';
import 'package:get/get.dart';

class FestivalCreateViewModel extends GetxController {
  final FestivalCreateRepository _festivalCreateRepository =
      FestivalCreateRepository();
  final Rx<FestivalCreateModel> festivalCreateModel = FestivalCreateModel(
          name: "name",
          startTime: DateTime.now().toString(),
          endTime: DateTime.now().toString(),
          imageList: [],
          location: "location",
          description: "description",
          missions: [],
          createdDate: DateTime.now().toString())
      .obs;

  Future<void> createFestival(FestivalCreateModel festivalCreateModel) async {
    await _festivalCreateRepository.createFestival(festivalCreateModel);
  }
}
