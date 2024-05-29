import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:minto/src/fesitival_detail.dart';
import 'package:get/get.dart';
import 'package:minto/src/myhistory.dart';
import 'package:minto/src/tutoriall.dart';
void main() {
  runApp(MyPaging());
}

class MyPaging extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyPage(),
    );
  }
}

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  String festivalId = '';
  String festivalName = '';
  String festivalImageUrl = '';
  bool isLoading = true;
  List<FestivalInfo> recentFestivals = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchFestivalDetails();
    fetchRecentFestivalImages();
  }

  Future<void> fetchFestivalDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final id = prefs.getString('festivalId');
    setState(() {
      festivalId = id ?? '';
    });
    log("마이페이지2에서의 festivalID:$id ");
    if (id != null && id.isNotEmpty) {
      final response = await http.get(Uri.parse('http://3.34.98.150:8080/festival/$id'));
      if (response.statusCode == 200) {
        final data = jsonDecode(utf8.decode(response.bodyBytes));
        setState(() {
          festivalName = data['name'];
          festivalImageUrl = data['imageList'][0];
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        throw Exception('Failed to load festival details');
      }
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> fetchRecentFestivalImages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString('accesstoken');
    final response = await http.get(
      Uri.parse('http://3.34.98.150:8080/member/visit/festival'),
      headers: {
        'Authorization': 'Bearer $accessToken',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(utf8.decode(response.bodyBytes));
      List<FestivalInfo> festivals = [];
      for (var festival in data) {
        if (festival['imageList'] != null && festival['imageList'].isNotEmpty) {
          festivals.add(FestivalInfo(
            name: festival['name'],
            imageUrl: festival['imageList'][0],
          ));
        }
      }
      setState(() {
        recentFestivals = festivals.take(4).toList();
      });
    } else {
      throw Exception('Failed to load recent festival images');
    }
  }

  Future<void> _refreshData() async {
    setState(() {
      isLoading = true;
    });
    await fetchFestivalDetails();
    await fetchRecentFestivalImages();
  }

  Widget buildFestivalWidget() {
    final List<Map<String, dynamic>> festivalList = [
      {
        'imagePath': 'assets/images/festival_example.png',
        'title': '축제 제목 1',
        'date': '2024-06-01',
        'id': '66321b74788e207ba11e5ade',
      },
      {
        'imagePath': 'assets/images/festival_example_1.jpg',
        'title': '축제 제목 2',
        'date': '2024-06-05',
        'id': '66321b74788e207ba11e5ade',
      },
      {
        'imagePath': 'assets/images/festival_example_2.jpg',
        'title': '축제 제목 3',
        'date': '2024-06-10',
        'id': '66321b74788e207ba11e5ade',
      },
    ];

    return SizedBox(
      height: 250,
      child: PageView.builder(
        itemCount: festivalList.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: GestureDetector(
              onTap: () {
                Get.to(FestivalDetail(festivalId: festivalList[index]['id']));
                log("스와이핑 카드가 눌렸습니다");
              },
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
                        child: Image.asset(
                          festivalList[index]['imagePath'],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        festivalList[index]['title'],
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        festivalList[index]['date'],
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 93, 167, 139),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(16.0),
                          child: GestureDetector(
                            onTap: () {
                              if (festivalName.isNotEmpty && festivalImageUrl.isNotEmpty) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('진행중인 축제'),
                                      content: Text('지금 <$festivalName>에 참여중이세요!'),
                                      actions: [
                                        Column(
                                          children: [
                                            Center(
                                              child: Builder(
                                              builder: (context) => ElevatedButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => FestivalDetail(festivalId: festivalId),
                                                    ),
                                                  ).then((_) => _refreshData());
                                                },
                                                child: Text('축제 이동하기'),
                                              ),
                                                                                        ),
                                            ),
                                          Center(
                                            child: Builder(
                                              builder: (context) => ElevatedButton(
                                                onPressed: () async {
                                                  Navigator.of(context).pop();
                                                  SharedPreferences prefs = await SharedPreferences.getInstance();
                                                  await prefs.remove('festivalId');
                                                  setState(() {
                                                    festivalId = '';
                                                    festivalName = '';
                                                    festivalImageUrl = '';
                                                  });
                                                },
                                                child: Text('축제 참여종료'),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                      ]);
                                  },
                                );
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('진행중인 축제'),
                                      content: Text('참여중인 축제가 아직 없습니다! 축제를 탐색하고 참여해보세요!'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('닫기'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            },
                            child: Material(
                              elevation: 4,
                              borderRadius: BorderRadius.circular(30),
                              child: Container(
                                padding: EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(108, 255, 255, 255),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(20),
                                          child: festivalImageUrl.isNotEmpty
                                              ? Image.network(
                                                  festivalImageUrl,
                                                  width: 40,
                                                  height: 40,
                                                  fit: BoxFit.cover,
                                                )
                                              : Image.asset(
                                                  'assets/images/first_logo.png',
                                                  width: 40,
                                                  height: 40,
                                                  fit: BoxFit.cover,
                                                ),
                                        ),
                                        SizedBox(width: 8),
                                        Expanded(
                                          child: Text(
                                            festivalName.isNotEmpty
                                                ? festivalName
                                                : "참여중인 축제가 아직 없습니다!",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontSize: 16, fontFamily: 'GmarketSans'),
                                          ),
                                        ),
                                        if (festivalImageUrl.isNotEmpty)
                                          Text(
                                            "참여중",
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                                color: Colors.green, fontSize: 16, fontFamily: 'GmarketSans'),
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 13),
                        GestureDetector(
                          onTap: () {
                            Get.to(MyHistory());
                            log("불투명한 박스가 눌렸습니다");
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 16.0),
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(244, 255, 255, 255).withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(20), boxShadow: [
      BoxShadow(
        color: const Color.fromARGB(87, 0, 0, 0).withOpacity(0.5), // 그림자의 색상과 불투명도
        spreadRadius: 5, // 그림자의 퍼짐 정도
        blurRadius: 7, // 그림자의 흐림 정도
        offset: Offset(0, 3), // 그림자의 위치 (x, y)
      ),
    ],
                                ),
                                //padding: EdgeInsets.symmetric(horizontal: 16.0), // 좌우 패딩 추가
                                child: Column(
                                  children: [
                                     
                                  Row(
                                    children: [
                                      
                                      ClipOval(
                                        child: Image.asset(
                                          'assets/images/first_logo.png',
                                          width: 80,
                                          height: 80,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          ElevatedButton(
                                            onPressed: () {
                                              log("내정보수정이 눌렸습니다");
                                            },
                                            child: Text("내 정보 수정"),
                                          ),
                                        SizedBox(width: 16),
                                          ElevatedButton(
                                            onPressed: () {
                                              log("튜토리얼버튼이 눌렸습니다");
                                              Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => IntroductionAnimationScreen()),
                            );
                                            },
                                            child: Text("앱 사용법"),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text("최근 방문한 축제"),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: recentFestivals.map((festival) {
                                        return Column(
                                          children: [
                                            ClipOval(
                                              child: Image.network(
                                                festival.imageUrl,
                                                width: 60,
                                                height: 60,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            SizedBox(height: 4),
                                            Text(
                                              festival.name.split(' ')[0], // Get the first word before whitespace
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontFamily: 'GmarketSans',
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 4.0), // Padding for the "추천축제" text
                        child: Text(
                          "이런 축제는 어떠세요?",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  buildFestivalWidget(),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () async{
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          await prefs.remove('privateKey');
                          await prefs.remove('address');
                          Get.offAndToNamed('/createOrImportWallet');
                            log("로그아웃이 눌렸습니다.");
                          },
                          child: Text(
                            '로그아웃',
                            style: TextStyle(color: Colors.grey, fontSize: 12.0),
                          ),
                        ),
                        SizedBox(width: 16.0),
                        GestureDetector(
                          onTap: () {
                            // 개발자 정보 메시지
// 개발자 정보 메시지 박스 표시
                          log("개발자정보가 눌렸습니다.");
                        },
                        child: Text(
                          '개발자 정보',
                          style: TextStyle(color: Colors.grey, fontSize: 12.0),
                        ),
                    )],
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}

class FestivalInfo {
  final String name;
  final String imageUrl;
  FestivalInfo({required this.name, required this.imageUrl});
}
