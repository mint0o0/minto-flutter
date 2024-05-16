import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:card_swiper/card_swiper.dart';
import 'package:minto/src/fesitival_detail.dart';
import 'package:minto/src/components/message_popup.dart';

void main() {
  runApp(const FestivalList());
}

class Festival {
  final String id;
  final String name;
  final String startTime;
  final String endTime;
  final String location;
  final List<String> imageList;

  Festival({
    required this.id,
    required this.name,
    required this.startTime,
    required this.endTime,
    required this.location,
    required this.imageList,
  });

  factory Festival.fromJson(Map<String, dynamic> json) {
    return Festival(
      id: json['id'],
      name: json['name'],
      startTime: (json['startTime'] as String).split('T')[0], // "T"를 기준으로 분리하여 첫 번째 부분 사용
      endTime: (json['endTime'] as String).split('T')[0], // "T"를 기준으로 분리하여 첫 번째 부분 사용
      location: json['location'],
      imageList: List<String>.from(json['imageList']),
    );
  }
}

 


Future<List<Festival>> fetchFestivals(int page) async {
  final response = await http.get(Uri.parse('http://3.34.98.150:8080/festival?page=$page'));

  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes))['content'];
    return data.map((json) => Festival.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load festivals');
  }
}
class FestivalList extends StatefulWidget {
  const FestivalList({Key? key}) : super(key: key);

  @override
  _FestivalListState createState() => _FestivalListState();
}

class _FestivalListState extends State<FestivalList> {
  List<Festival> festivals = [];
  int page = 0;

  @override
  void initState() {
    super.initState();
   
    _loadFestivals();

  }

  Future<void> _loadFestivals() async {
    final List<Festival> fetchedFestivals = await fetchFestivals(page);
    setState(() {
      festivals.addAll(fetchedFestivals);
      page++; // 페이지 증가
    });
     _showMessagePopup();

  }
  void _showMessagePopup() {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return MessagePopup(
        title: "추천축제",
        message: "고양시 국제 꽃 박람회에\n초대되었습니다!\n확인버튼으로 자세히 살펴보세요!",
        okCallback: () {
          Get.to(() => FestivalDetail(festivalId: "6632093c788e207ba11e5acf"));
        },
        cancelCallback: () {
          Navigator.pop(context); // Close the dialog
        },
      );
    },
  );
}
// class FestivalList extends StatelessWidget {
//   const FestivalList({Key? key}) : super(key: key);
  Widget buildLoadMoreButton() {
    return Center(
      child: TextButton(
        onPressed: _loadFestivals,
        child: Text(
          '더 보기',
          style: TextStyle(
            fontFamily: 'GmarketSans',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    //return FutureBuilder<List<Festival>>(
      //future: fetchFestivals(),
      // builder: (context, snapshot) {
      //   if (snapshot.connectionState == ConnectionState.waiting) {
      //     return Center(child: CircularProgressIndicator()); // 데이터를 기다리는 동안 로딩 표시
      //   } else if (snapshot.hasError) {
      //     return Center(child: Text('Error: ${snapshot.error}'));
      //   } else {
      //     final festivals = snapshot.data!;
          return MaterialApp(
            theme: ThemeData.dark().copyWith(
              scaffoldBackgroundColor: Colors.white,
            ),
            home: Scaffold(
              body: SafeArea(child:ListView(
                children: [
                  Material(
                    elevation: 12,
                    color:Colors.transparent,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.5,
                         decoration: BoxDecoration(
                          color:Color.fromARGB(255, 93, 167, 139),
        //                    image: DecorationImage(
        //   image: AssetImage('assets/images/background_image.jpg'),
        //   fit: BoxFit.cover,
        //  ),
                //           gradient: LinearGradient(
                //             begin:Alignment.topCenter,
                //             end:Alignment.bottomCenter,
                //             colors: [//Color.fromRGBO(98, 206, 165, 1),Color.fromRGBO(104, 204, 166, 1)
                //               Color.fromRGBO(255, 116, 119, 1),Color.fromRGBO(230, 149, 151, 1),Color.fromRGBO(206, 181, 183, 1),Color.fromRGBO(181, 214, 214, 1.0),Color.fromRGBO(156, 246, 246, 1.0)
                // ]),
                        ),
                        padding: EdgeInsets.fromLTRB(16, 40, 16, 0),
                        alignment: Alignment.topLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '어서오세요! 민토입니다♥',
                              style: TextStyle(
                                fontFamily:'GmarketSans',
                                color: Colors.white,
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 6),
                            Text(
                              '축제를 즐겨보세요!',
                              style: TextStyle(
                                fontFamily:'GmarketSans',
                                color: const Color.fromARGB(166, 255, 255, 255),
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(height: 15),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 16),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: TextField(
                                      decoration: InputDecoration(
                                        hintText: '검색어를 입력하세요...',
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8),
                                buildSearchButton(context),
                              ],
                            ),
                            SizedBox(height: 27),
                            Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          InkWell(
  onTap: () {
    print("지역축제가 눌림");
  },
  child: Container(
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2), // 그림자 색상 및 투명도 조절
          spreadRadius: 2, // 그림자 확산 정도
          blurRadius: 5, // 그림자 흐림 정도
          offset: Offset(0, 2), // 그림자 위치 조절
        ),
      ],
    ),
    child: ClipOval(
      child: Image.asset(
        'assets/images/location_3d_icon.jpg',
        width: 60,
      ),
    ),
  ),
),
                          SizedBox(height: 8),
                          Text(
                            '지역축제',
                            style: TextStyle(fontSize: 12,color: Colors.white,
                            fontFamily:'GmarketSans',fontWeight: FontWeight.bold,),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          InkWell(
  onTap: () {
    print("음악축제가 눌림");
  },
  child: Container(
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2), // 그림자 색상 및 투명도 조절
          spreadRadius: 2, // 그림자 확산 정도
          blurRadius: 5, // 그림자 흐림 정도
          offset: Offset(0, 2), // 그림자 위치 조절
        ),
      ],
    ),
    child: ClipOval(
      child: Image.asset(
        'assets/images/music_3d_icon.png',
        width: 60,
      ),
    ),
  ),
),
                          SizedBox(height: 8),
                          Text(
                            '음악축제',
                            style: TextStyle(fontSize: 12,color: Colors.white,
                            fontFamily:'GmarketSans',fontWeight: FontWeight.bold,),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          InkWell(
  onTap: () {
    print("대학축제가 눌림");
  },
  child: Container(
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2), // 그림자 색상 및 투명도 조절
          spreadRadius: 2, // 그림자 확산 정도
          blurRadius: 5, // 그림자 흐림 정도
          offset: Offset(0, 2), // 그림자 위치 조절
        ),
      ],
    ),
    child: ClipOval(
      child: Image.asset(
        'assets/images/school_3d_icon.png',
        width: 60,
      ),
    ),
  ),
),

                          SizedBox(height: 8),
                          Text(
                            '대학축제',
                            style: TextStyle(fontSize: 12,color: Colors.white,
                            fontFamily:'GmarketSans',fontWeight: FontWeight.bold,),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                         InkWell(
  onTap: () {
    print("전시회가 눌림");
  },
  child: Container(
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2), // 그림자 색상 및 투명도 조절
          spreadRadius: 2, // 그림자 확산 정도
          blurRadius: 5, // 그림자 흐림 정도
          offset: Offset(0, 2), // 그림자 위치 조절
        ),
      ],
    ),
    child: ClipOval(
      child: Image.asset(
        'assets/images/david_3d_icon.jpg',
        width: 60,
      ),
    ),
  ),
),
                          SizedBox(height: 8),
                          Text(
                            '전시회',
                            style: TextStyle(fontSize: 12,color: Colors.white,
                            fontFamily:'GmarketSans',fontWeight: FontWeight.bold,),
                          ),
                        ],
                      ),
                    ],
                  ),
                  //buildMapButton(context),
                            SizedBox(height: 25),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 45),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: 
                    //Center(child:
                    Text(
                      '추천 축제',
                      style: TextStyle(
                        fontFamily: 'GmarketSans',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.left,
                    ),
                   // )
                  ),
                  
                  buildFestivalWidget(),
                  SizedBox(height: 14),
                  SizedBox(height: 14),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      '축제 탐색하기',
                      style: TextStyle(
                        fontFamily:'GmarketSans',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  SizedBox(height: 30),
                  buildFestivalList(festivals),
                  SizedBox(height:6),
                   buildLoadMoreButton(),
                  SizedBox(height: 16),
                ],
              ),),
            ),
          );
        }
      }//,
    //);
  //}

  Widget buildSearchButton(BuildContext context) {
    return IconButton(
      onPressed: () {
        // 검색 버튼 클릭 시 실행되는 동작을 정의합니다.
        // 여기에 검색 기능을 구현할 수 있습니다.
      },
      icon: Icon(Icons.search),
    );
  }

  // Widget buildMapButton(BuildContext context) {
  //   return InkWell(
  //     onTap: () {
  //       // 버튼을 눌렀을 때 실행되는 동작을 정의합니다.
  //       print("지도 버튼이 눌렸습니다");
  //     },
  //     child: Padding(
  //       padding: const EdgeInsets.symmetric(horizontal: 0),
  //       child: Text(
  //         '📍지도로 축제 한눈에 보기',
  //         style: TextStyle(
  //           fontFamily:'GmarketSans',
  //           fontSize: 13,
  //           fontWeight: FontWeight.bold,
  //           color: const Color.fromARGB(255, 255, 255, 255),
  //         ),
  //       ),
  //     ),
  //   );
  // }

Widget buildFestivalWidget() {
    final List<String> festivalList = [
      'assets/images/festival_example.png',
      'assets/images/festival_example_1.jpg',
      'assets/images/festival_example_2.jpg',
    ];

    return Container(
      height: 250,
      width: double.infinity,
      child: Swiper(
        itemCount: festivalList.length,
        autoplay: true,
        autoplayDelay: 3000,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image.asset(
                festivalList[index],
                fit: BoxFit.cover,
              ),
            ),
          );
        },
        itemHeight: 200,
        itemWidth: 400,
        layout: SwiperLayout.TINDER,
      ),
    );
  }
  // Widget buildLoadMoreButton() {
  //   return Center(
  //     child: TextButton(
  //       onPressed: _loadFestivals,
  //       child: Text(
  //         '더 보기',
  //         style: TextStyle(
  //           fontFamily: 'GmarketSans',
  //           fontSize: 18,
  //           fontWeight: FontWeight.bold,
  //           color: Colors.black,
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget buildFestivalList(List<Festival> festivals) {
  return Column(
    children: [
      for (final festival in festivals) ...[
        GestureDetector(
          onTap: () {
            // 축제 카드를 눌렀을 때 실행되는 부분입니다.
            // 여기서 FestivalDetail을 호출하면 됩니다.
            Get.to(() => FestivalDetail(festivalId: festival.id));
            print("festival list temp에서 찍어본 아이디: $festival.id");
            print(festival.id);
            print("festival list temp에서 찍어본 아이디: $festival.id");
          },
          child:
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                child: Image.network(
                  festival.imageList.isNotEmpty ? festival.imageList[0] : '', // 첫 번째 이미지 사용
                  height: 200, // 이미지 높이 조정 필요
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      festival.name,
                      style: TextStyle(
                        fontFamily:'GmarketSans',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text.rich(
  TextSpan(
    text: '장소: ',
    style: TextStyle(
      fontFamily: 'GmarketSans',
      fontSize: 14,
      fontWeight: FontWeight.bold, // 장소 부분은 bold로 설정
      color: Colors.black,
    ),
    children: <TextSpan>[
      TextSpan(
        text: festival.location,
        style: TextStyle(
          fontFamily: 'GmarketSans',
          fontSize: 14,
          fontWeight: FontWeight.w500, // ${festival.location}은 light로 설정
          color: Colors.black,
        ),
      ),
    ],
  ),
),

                    SizedBox(height: 4),
                    Text.rich(
  TextSpan(
    text: '시작일: ',
    style: TextStyle(
      fontFamily: 'GmarketSans',
      fontSize: 14,
      fontWeight: FontWeight.bold, // 장소 부분은 bold로 설정
      color: Colors.black,
    ),
    children: <TextSpan>[
      TextSpan(
        text: festival.startTime,
        style: TextStyle(
          fontFamily: 'GmarketSans',
          fontSize: 14,
          fontWeight: FontWeight.w500, // ${festival.location}은 light로 설정
          color: Colors.black,
        ),
      ),
    ],
  ),
),
                    SizedBox(height: 4),
                     Text.rich(
  TextSpan(
    text: '종료일: ',
    style: TextStyle(
      fontFamily: 'GmarketSans',
      fontSize: 14,
      fontWeight: FontWeight.bold, // 장소 부분은 bold로 설정
      color: Colors.black,
    ),
    children: <TextSpan>[
      TextSpan(
        text: festival.endTime,
        style: TextStyle(
          fontFamily: 'GmarketSans',
          fontSize: 14,
          fontWeight: FontWeight.w500, // ${festival.location}은 light로 설정
          color: Colors.black,
        ),
      ),
    ],
  ),
),
                  ],
                ),
              ),
            ],
          ),
        ),
  )],
    ],
  );
}

//}
