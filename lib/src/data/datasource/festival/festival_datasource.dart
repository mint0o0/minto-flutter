import 'package:minto/src/data/model/festival/festival_model.dart';

class FestivalDataSource {
  Future<List<FestivalModel>> getFestivals() async {
    return [
      FestivalModel(
        name: "태안 세계튤립꽃박람회",
        startTime: "2024-04-10",
        endTime: "2024-05-07",
        imageList: ["https://kfescdn.visitkorea.or.kr/kfes/upload/contents/db/e8901e50-b9db-4264-aeea-253689e3d34a_4.jpg", "https://kfescdn.visitkorea.or.kr/kfes/upload/contents/db/e8901e50-b9db-4264-aeea-253689e3d34a_5.jpg"],
        location: "충청남도 태안군 안면읍 꽃지해안로 400 ",
        description: "천혜의 자연경관을 갖춘 충남 태안 코리아플라워파크에서 4월 12일부터 5월 7일까지 제13회 태안 세계튤립꽃꽃박람회가 펼쳐진다.",
        missions: [],
        createdDate: "2021-09-01",
        updateDate: "2021-09-01",
      ),
      FestivalModel(
        name: "봄꽃페스타",
        startTime: "2024-04-19",
        endTime: "2024-05-26",
        imageList: ["https://kfescdn.visitkorea.or.kr/kfes/upload/contents/db/4d459641-ef78-490a-89c1-c1bd9226a61a_4.png", "https://kfescdn.visitkorea.or.kr/kfes/upload/contents/db/4d459641-ef78-490a-89c1-c1bd9226a61a_5.jpg"],
        location: "경기도 가평군 상면 수목원로 432",
        description: "봄볕에 반짝이는 땅과 신록으로 물든 아침고요수목원은 축령산의 빼어난 산세와 어우러져 그림 같은 풍경을 자아낸다.",
        missions: [],
        createdDate: "2021-09-01",
        updateDate: "2021-09-01",
      ),
    ];
  }
}