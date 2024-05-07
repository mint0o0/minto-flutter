import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:get/get.dart';
import 'package:minto/src/components/loading_screen.dart';

import 'package:minto/src/utils/func.dart';
import 'package:minto/src/festival_mission.dart';


void main() {
  runApp(FestivalDetail());
}

class FestivalDetail extends StatelessWidget  {
  final Map<String, dynamic> festivalData = {
    "id": "663215fc788e207ba11e5ad2",
    "name": "고창청보리밭 축제",
    "startTime": "2024-04-20T00:00:00",
    "endTime": "2024-05-12T00:00:00",
    "phone": "063-999-0897",
    "instaID": "gochang",
    "imageList": [
      "https://kfescdn.visitkorea.or.kr/kfes/upload/contents/db/1291437e-020b-4fa2-87dc-cb5a48391ca1_3.JPG",
      "https://kfescdn.visitkorea.or.kr/kfes/upload/contents/db/1291437e-020b-4fa2-87dc-cb5a48391ca1_4.jpg",
      "https://kfescdn.visitkorea.or.kr/kfes/upload/contents/db/1291437e-020b-4fa2-87dc-cb5a48391ca1_5.jpg",
      "https://kfescdn.visitkorea.or.kr/kfes/upload/contents/db/1291437e-020b-4fa2-87dc-cb5a48391ca1_6.jpg",
      "https://kfescdn.visitkorea.or.kr/kfes/upload/contents/db/1291437e-020b-4fa2-87dc-cb5a48391ca1_7.jpg"
    ],
    "location": "전북특별자치도 고창군 공음면 학원농장길 150",
    "latitude": "35.37537707168861",
    "longitude": "126.54328005940903",
    "price": "무료",
    "host": "고창청보리밭축제위원회/고창군",
    "description":
        "고창 청보리밭 축제는 전북특별자치도 고창군의 주요 생태자원 중 하나인 청보리밭을 중심으로 하는 고창군의 대표축제이다. 2004년 처음 개최한 이래로 해마다 평균 50만여 명이 방문하는 전국 경관 농업의 1번지 축제로서 그 오랜 역사를 만들어가고 있다. 보리의 생육 기간 중 가장 아름다울 때는 ‘청보리’ 기간이라고 한다. 보리가 가장 환상적인 모습을 띠는 이 기간, 매년 4월 중순부터 5월 중순까지 고창군 공음면 학원농장 일대의 약 77만㎡ 땅에서 ‘고창 청보리밭 축제’는 주인공의 모습을 드러낸다. \n 봄바람에 파릇하게 흩날리는 청보리의 모습은 오선지 위에서 음표들이 춤추듯이 만들어내는 음악의 모습과 비슷하다고 연상시켜, 이번 제21회 축제는 ‘청보리밭’과 ‘음악’을 제재로 삼았다. ‘초록 물결 음악 노트’라는 슬로건 아래 더욱 다채롭고 흥겨운 모습으로, 오는 4월 20일부터 5월 12일까지 방문객의 발걸음을 함께 맞춰나갈 예정이다.\n 축제 기간 내내 오감을 만족시키는 프로그램을 경험할 수 있을 것이다. 청보리와 유채꽃이 광활하게 펼쳐진 청보리밭을 보면 시각이, 전문 공연팀과 고창 군민이 만드는 다양한 버스킹의 음악을 들으면 청각이, 우리 지역 농특산물로 만든 음식을 먹으면 미각이, 보리 놀이터 및 보리 새싹 키우기 체험을 하면 촉각이, 청보리밭 축제에 사랑하는 사람과 추억이 더해져 오랜 향기를 남기면 후각이 즐거운 축제이다. 특히 제21회 청보리밭 축제는 세 가지의 목표를 갖고 개최하고자 한다. 첫째, 음악으로 힐링하는 보리밭이다. 다양한 장르의 음악 공연으로 다채로운 축제 분위기를 조성하고 방문객이 함께 어우러지고자 한다. 둘째, 아이들의 놀이 공간 확대이다. 다목적 전시관 내 ‘보리알 놀이터’ 및 ‘보릿가루 글씨쓰기 체험’의 구성으로 아이들만이 즐길 수 있는 활동을 기획하였다. 그로 인해 축제를 즐길 수 있는 연령대를 기존보다 확대하고자 한다. 마지막으로, 축제장의 청결도를 높이는 것이다. 축제장 쓰레기 수거, 이동식 화장실 증설, 오수 배출구 개선 등의 방안을 실천하고자 한다. \n [행사내용] \n 1. 메인프로그램 :개막식, 음악공연 \n 2. 부대프로그램 : 버스킹, 체험프로그램 등\n 3. 소비자 참여 프로그램 : 보물찾기, 보리알놀이터,k-pop 랜덤플레이 댄스 등\n 4. 기타 내용 : 고창사랑상품권(액면 10%할인) 이용 관광객에 대한 관내 지정 음식점, 숙박업소 추가 할인",
    "missions": [
      {
        "name": "청보리 밭에서 사진찍기",
        "description": "청보리 밭에서 다음과 같은 포즈로 사진을 찍고 직원에게 사진을 보여주세요",
        "location": "부스 a",
        "startTime": "2024-03-20T00:00:00.000+00:00",
        "endTime": "2024-03-22T00:00:00.000+00:00",
        "imageList": [
          "https://img1.daumcdn.net/thumb/S1200x630/?fname=https://t1.daumcdn.net/news/202208/12/newsen/20220812120100672bfaa.jpg",
          "https://images.chosun.com/resizer/eHGODWQLuv3Nf0cjcVJy5C0gY34=/530x278/smart/cloudfront-ap-northeast-1.images.arcpublishing.com/chosun/URY2VDKX4NCYOU2H75DHKERNYM.jpg",
          "https://th.bing.com/th/id/OIP.fr0Fr1VgqqocfSZvjArdwgHaEp?rs=1&pid=ImgDetMain"
        ]
      }
    ],
    "category": "지역축제"
  };

  @override
  Widget build(BuildContext context) {
    String category = festivalData['category'];
    String name = festivalData['name'];
    String startTime = festivalData['startTime'].split('T')[0];
    String endTime = festivalData['endTime'].split('T')[0];
    List<String> imageList = festivalData['imageList'];
    String description = festivalData['description'];
    String location = festivalData['location'];
    String price = festivalData['price'];
    String phoneNumber = festivalData['phone'];
    String instaID = festivalData['instaID'];
    String longitude = festivalData['longitude'];
    String latitude = festivalData['latitude'];
    String host = festivalData['host'];
    Map<String,dynamic> festivalData1=festivalData;
    bool festivalInProgress = DateTime.now().isAfter(DateTime.parse(startTime)) &&
        DateTime.now().isBefore(DateTime.parse(endTime));

    return MaterialApp(
      title: 'Festival Detail',
      home: FestivalDetailScreen(
        category: category,
        name: name,
        startTime: startTime,
        endTime: endTime,
        imageList: imageList,
        description: description,
        location: location,
        price: price,
        phoneNumber: phoneNumber,
        instaID: instaID,
        festivalInProgress: festivalInProgress,
        longitude: longitude,
        latitude: latitude,
        host: host,
        festivalData1: festivalData1,
      ),
    );
  }
}

class FestivalDetailScreen extends StatefulWidget {
  final String category;
  final String name;
  final String startTime;
  final String endTime;
  final List<String> imageList;
  final String description;
  final String location;
  final String price;
  final String phoneNumber;
  final String instaID;
  final bool festivalInProgress;
  final String longitude;
  final String latitude;
  final String host;
  final Map<String,dynamic> festivalData1;
  FestivalDetailScreen({
    required this.category,
    required this.name,
    required this.startTime,
    required this.endTime,
    required this.imageList,
    required this.description,
    required this.location,
    required this.price,
    required this.phoneNumber,
    required this.instaID,
    required this.festivalInProgress,
    required this.longitude,
    required this.latitude,
    required this.host,
    required this.festivalData1,
  });

  @override
  _FestivalDetailScreenState createState() => _FestivalDetailScreenState();
}

class _FestivalDetailScreenState extends State<FestivalDetailScreen> {
  bool showFullDescription = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            floating: true,
            backgroundColor: const Color.fromARGB(255, 255, 255, 255),
            expandedHeight: 200.0,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text('축제 상세 정보', textAlign: TextAlign.center, style: TextStyle(color:Colors.black,fontFamily: 'GmarketSans',fontWeight:FontWeight.normal),),
              background: Image.network(
                widget.imageList[0],
                fit: BoxFit.cover,
              ),
            ),  automaticallyImplyLeading: false,
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(height: 16.0),
              Text(
                widget.category,
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8.0),
              Text(
                widget.name,
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8.0),
              widget.festivalInProgress
                  ? Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(8.0),
                ),alignment: Alignment.center,
                child: Text(
                  '축제 진행중',
                  style: TextStyle(
                    
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              )
                  : SizedBox(),
              SizedBox(height: 8.0),
              Text(
                '${widget.startTime} ~ ${widget.endTime}',
                style: TextStyle(fontSize: 16.0),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16.0),
              SizedBox(
                height: 200.0,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.imageList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: Image.network(
                        widget.imageList[index],
                        width: 200.0,
                        height: 200.0,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: 16.0),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  widget.description,
                  style: TextStyle(fontSize: 16.0),
                  textAlign: TextAlign.justify,
                  overflow: showFullDescription
                      ? TextOverflow.visible
                      : TextOverflow.ellipsis,
                  maxLines: showFullDescription ? null : 3,
                ),
              ),
              SizedBox(height: 8.0),
              widget.description.length > 100
                  ? GestureDetector(
                onTap: () {
                  setState(() {
                    showFullDescription = !showFullDescription;
                  });
                },
                child: Text(
                  showFullDescription ? '접기' : '더보기',
                  style: TextStyle(color: Colors.blue),
                  textAlign: TextAlign.center,
                ),
              )
                  : SizedBox(),
              SizedBox(height: 16.0),
              Divider(),
              SizedBox(height: 16.0),
              _buildInfoRow(
                iconPath: 'assets/images/calendar_3d_icon.png',
                text: '${widget.startTime} ~ ${widget.endTime}',
              ),
              SizedBox(height: 6.0),
              _buildInfoRow(
                iconPath: 'assets/images/point_3d_icon.png',
                text: widget.location,
              ),
              SizedBox(height: 6.0),
              _buildInfoRow(
                iconPath: 'assets/images/coin_3d_icon.png',
                text: widget.price,
              ),
              SizedBox(height: 6.0),
              _buildInfoRow(
                iconPath: 'assets/images/host_3d_icon.webp',
                text: widget.host,
              ),
              SizedBox(height: 6.0),
              _buildInfoRow(
                iconPath: 'assets/images/phonecall_3d_icon.webp',
                text: widget.phoneNumber,
              ),
              SizedBox(height: 6.0),
              _buildInfoRow(
                iconPath: 'assets/images/insta_3d_icon.png',
                text: widget.instaID,
              ),
              SizedBox(height: 16.0),
              Divider(),
              SizedBox(height: 16.0),
              GestureDetector(
                onTap: _navigateToMissionPage,
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Center(
                    child: Text(
                      '미션 수행하러 가기',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
      
              //여기에 미션수행 버튼을 배치해줘!
              SizedBox(height: 16.0),
              Divider(),
              SizedBox(height: 16.0),
              Text("길찾기",style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),),
              SizedBox(height: 16.0),
              SizedBox(
  height: 360,
  width: 360,
  child: _buildMap(),
),
SizedBox(height: 16.0),
Divider(),
SizedBox(height: 16.0),

// 지도 아래에 "추천축제" 텍스트 추가
Text(
  "추천축제",
  style: TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.bold,
  ), textAlign: TextAlign.center,
),

// "추천축제" 텍스트 아래에 Row 추가
Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
    // 첫 번째 Column
    Column(
      children: [
        Image.asset(
          'assets/images/cat0.jpg',
          width: 150.0,
          height: 150.0,
          fit: BoxFit.cover,
        ),
        SizedBox(height: 8.0),
        Text(
          "고양 꽃 박람회",
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
    // 두 번째 Column
    Column(
      children: [
        Image.asset(
          'assets/images/hangang_flower.jpg',
          width: 150.0,
          height: 150.0,
          fit: BoxFit.cover,
        ),
        SizedBox(height: 8.0),
        Text(
          "한강 꽃 축제",
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  ],
),
              //_buildMap(),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow({required String iconPath, required String text}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Image.asset(
            iconPath,
            width: 32.0,
            height: 32.0,
            fit: BoxFit.contain,
          ),
          SizedBox(width: 16.0),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 16.0),
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
    );
  }

 Widget _buildMap() {
  return Scaffold(body:Stack(children:[FlutterMap(
    options: MapOptions(
      initialCenter: LatLng(
        double.parse(widget.latitude),
        double.parse(widget.longitude),
      ),
      initialZoom: 14.4746,
    ),
    children: [
      TileLayer(
        urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
  userAgentPackageName: 'dev.fleaflet.flutter_map.example',
      ),
      
     MarkerLayer(
  markers: [
    Marker(
      point: LatLng(double.parse(widget.latitude),double.parse(widget.longitude),),
      width: 200,
      height: 200,
      child: Icon(Icons.location_pin, size: 50,color:Colors.red),
    ),
  ],
),
    ],
  )]));
}
void _navigateToMissionPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FestivalMission(festivalData: widget.festivalData1)),
    );
  }

}


// class FestivalMission extends StatelessWidget with Func {
//   final Map<String, dynamic> festivalData;
  
//   FestivalMission({required this.festivalData});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(festivalData['name']),
//       ),
//       body: SafeArea(
//         child: ListView.builder(
//           itemCount: festivalData['missions'].length,
//           itemBuilder: (context, index) {
//             var mission = festivalData['missions'][index];
//             return Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Text(
//                     '미션${index + 1}: ${mission['name']}',
//                     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Text(
//                     mission['description'],
//                     style: TextStyle(fontSize: 16),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 200,
//                   child: ListView.builder(
//                     scrollDirection: Axis.horizontal,
//                     itemCount: mission['imageList'].length,
//                     itemBuilder: (context, index) {
//                       var imageUrl = mission['imageList'][index];
//                       return Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Image.network(imageUrl),
//                       );
//                     },
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Text(
//                     '미션장소: ${mission['location']}',
//                     style: TextStyle(fontSize: 16),
//                   ),
//                 ),
//                 if (index != festivalData['missions'].length - 1) Divider(),
//               ],
//             );
//           },
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//          onPressed: () async {
//               print("Create Nft");
//              Navigator.push(
//   context,
//   MaterialPageRoute(builder: (context) => LoadingScreen()),
// ).then((_) async {
//   String imageUrl = await createImage("wide green barley with bright sunshine, like postcard, ((digital art 8K))");
//   await createAndSend(imageUrl, "고창 청보리밭 축제", "2024-05-02");
//   print("미션완료 누름1");
// });
        
//           print("미션완료 누름2");
//             },
      
//         backgroundColor: Colors.red,
//         child: Text(
//           '미션완료',
//           style: TextStyle(color: Colors.white),
//         ),
//       ),
//     );
//   }
// }