import 'package:minto/src/data/model/festival/festival_model.dart';

class FestivalDataSource {
  Future<List<FestivalModel>> getFestivals() async {
    return [
      FestivalModel(
        name: "Festival 1",
        startTime: "2021-10-01",
        endTime: "2021-10-10",
        imageList: ["image1", "image2"],
        location: "location1",
        description: "description1",
        missions: [],
        createdDate: "2021-09-01",
        updateDate: "2021-09-01",
      ),
      FestivalModel(
        name: "Festival 2",
        startTime: "2021-11-01",
        endTime: "2021-11-10",
        imageList: ["image1", "image2"],
        location: "location2",
        description: "description2",
        missions: [],
        createdDate: "2021-09-01",
        updateDate: "2021-09-01",
      ),
    ];
  }
}