import 'package:flutter/material.dart';

void main() {
  runApp(FestivalDetail());
}

class FestivalDetail extends StatelessWidget {
  final Map<String, dynamic> festivalData = {
            "id": "663215fc788e207ba11e5ad2",
            "name": "고창청보리밭 축제",
            "startTime": "2024-04-20T00:00:00",
            "endTime": "2024-05-12T00:00:00",
            "phone":"031-999-0897",
            "instaID":"gochang",
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
            "description": "고창 청보리밭 축제는 전북특별자치도 고창군의 주요 생태자원 중 하나인 청보리밭을 중심으로 하는 고창군의 대표축제이다. 2004년 처음 개최한 이래로 해마다 평균 50만여 명이 방문하는 전국 경관 농업의 1번지 축제로서 그 오랜 역사를 만들어가고 있다. 보리의 생육 기간 중 가장 아름다울 때는 ‘청보리’ 기간이라고 한다. 보리가 가장 환상적인 모습을 띠는 이 기간, 매년 4월 중순부터 5월 중순까지 고창군 공음면 학원농장 일대의 약 77만㎡ 땅에서 ‘고창 청보리밭 축제’는 주인공의 모습을 드러낸다. \n 봄바람에 파릇하게 흩날리는 청보리의 모습은 오선지 위에서 음표들이 춤추듯이 만들어내는 음악의 모습과 비슷하다고 연상시켜, 이번 제21회 축제는 ‘청보리밭’과 ‘음악’을 제재로 삼았다. ‘초록 물결 음악 노트’라는 슬로건 아래 더욱 다채롭고 흥겨운 모습으로, 오는 4월 20일부터 5월 12일까지 방문객의 발걸음을 함께 맞춰나갈 예정이다.\n 축제 기간 내내 오감을 만족시키는 프로그램을 경험할 수 있을 것이다. 청보리와 유채꽃이 광활하게 펼쳐진 청보리밭을 보면 시각이, 전문 공연팀과 고창 군민이 만드는 다양한 버스킹의 음악을 들으면 청각이, 우리 지역 농특산물로 만든 음식을 먹으면 미각이, 보리 놀이터 및 보리 새싹 키우기 체험을 하면 촉각이, 청보리밭 축제에 사랑하는 사람과 추억이 더해져 오랜 향기를 남기면 후각이 즐거운 축제이다. 특히 제21회 청보리밭 축제는 세 가지의 목표를 갖고 개최하고자 한다. 첫째, 음악으로 힐링하는 보리밭이다. 다양한 장르의 음악 공연으로 다채로운 축제 분위기를 조성하고 방문객이 함께 어우러지고자 한다. 둘째, 아이들의 놀이 공간 확대이다. 다목적 전시관 내 ‘보리알 놀이터’ 및 ‘보릿가루 글씨쓰기 체험’의 구성으로 아이들만이 즐길 수 있는 활동을 기획하였다. 그로 인해 축제를 즐길 수 있는 연령대를 기존보다 확대하고자 한다. 마지막으로, 축제장의 청결도를 높이는 것이다. 축제장 쓰레기 수거, 이동식 화장실 증설, 오수 배출구 개선 등의 방안을 실천하고자 한다. \n [행사내용] \n 1. 메인프로그램 :개막식, 음악공연 \n 2. 부대프로그램 : 버스킹, 체험프로그램 등\n 3. 소비자 참여 프로그램 : 보물찾기, 보리알놀이터,k-pop 랜덤플레이 댄스 등\n 4. 기타 내용 : 고창사랑상품권(액면 10%할인) 이용 관광객에 대한 관내 지정 음식점, 숙박업소 추가 할인",
            "missions": [
                {
                    "name": "공 옮기기",
                    "description": "열심히 공을 옮겨요",
                    "location": "310관 앞",
                    "startTime": "2024-03-20T00:00:00.000+00:00",
                    "endTime": "2024-03-22T00:00:00.000+00:00",
                    "imageList": [
                        "https://picsum.photos/200",
                        "https://picsum.photos/200",
                        "https://picsum.photos/200"
                    ]
                }
            ],
            "category": "지역축제"
        };

  @override
  Widget build(BuildContext context) {
    String category = festivalData['category'];
    String name = festivalData['name'];
    String startTime = festivalData['startTime'];
    String endTime = festivalData['endTime'];
    List<String> imageList = festivalData['imageList'];
    String description = festivalData['description'];
    String location = festivalData['location'];
    String price = festivalData['price'];
    String phoneNumber = festivalData['phone'];
    String instaID = festivalData['instaID'];
    //String posterImage = festivalData['posterImage'];

    bool festivalInProgress =
        DateTime.now().isAfter(DateTime.parse(startTime)) &&
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
        //posterImage: posterImage,
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
  //final String posterImage;

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
    //required this.posterImage,
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
            expandedHeight: 200.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('축제 상세 정보'),
              background: Image.network(
                widget.imageList[0],
                fit: BoxFit.cover,
              ),
            ),
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
                      ),
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
              _buildInfoRow(
                iconPath: 'assets/images/point_3d_icon.png',
                text: widget.location,
              ),
              _buildInfoRow(
                iconPath: 'assets/images/coin_3d_icon.png',
                text: widget.price,
              ),
              _buildInfoRow(
                iconPath: 'assets/images/phonecall_3d_icon.webp',
                text: widget.phoneNumber,
              ),
              _buildInfoRow(
                iconPath: 'assets/images/insta_3d_icon.png',
                text: widget.instaID,
              ),
              SizedBox(height: 16.0),
              Divider(),
              Text("길찾기"),
              
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
}
