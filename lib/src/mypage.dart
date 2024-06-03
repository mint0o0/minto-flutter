import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:minto/src/fesitival_detail.dart';
import 'package:minto/src/myhistory.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
            id: festival['id'],
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
    return SizedBox(
      height: 250,
      child: PageView.builder(
        itemCount: recentFestivals.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: GestureDetector(
              onTap: () {
                Get.to(() => FestivalDetail(festivalId: recentFestivals[index].id));
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
                        child: recentFestivals.isEmpty
                            ? Image.asset(
                                'assets/images/question.png',
                                fit: BoxFit.cover,
                              )
                            : Image.network(
                                recentFestivals[index].imageUrl,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        recentFestivals.isEmpty ? "No Festival" : recentFestivals[index].name,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
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
                    height: MediaQuery.of(context).size.height * 0.8,
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
                                      ],
                                    );
                                  },
                                );
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('진행중인 축제'),
                                      content: Text('참여중인 축제가 아직 없습니다! 축제를'),
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
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            decoration: BoxDecoration(
                              color: Colors.pink,
                              borderRadius: BorderRadius.circular(20),
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
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text("최근 방문한 축제  "),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Get.to(MyHistory());
                                        },
                                        child: Text(
                                          '📅',
                                          style: TextStyle(fontSize: 30),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: recentFestivals.isEmpty
                                        ? [
                                            Column(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (BuildContext context) {
                                                        return AlertDialog(
                                                          title: Text("최근에 방문한 축제가 없습니다!"),
                                                          actions: [
                                                            TextButton(
                                                              onPressed: () {
                                                                Navigator.of(context).pop();
                                                              },
                                                              child: Text('확인'),
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    );
                                                  },
                                                  child: ClipOval(
                                                    child: Image.asset(
                                                      'assets/images/question.png',
                                                      width: 60,
                                                      height: 60,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 4),
                                                Text(
                                                  "No Festival",
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontFamily: 'GmarketSans',
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ],
                                            ),
                                          ]
                                        : recentFestivals.map((festival) {
                                            return Column(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    Get.to(() => FestivalDetail(festivalId: festival.id));
                                                  },
                                                  child: ClipOval(
                                                    child: Image.network(
                                                      festival.imageUrl,
                                                      width: 60,
                                                      height: 60,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 4),
                                                Text(
                                                  festival.name.split(' ')[0],
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
                        SizedBox(height: 10),
                        GestureDetector(
                          onTap: () {
                            _showKeywordDialog();
                          },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(6, 255, 255, 255),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Center(
                              child: Text(
                                '카테고리 수정',
                                style: TextStyle(
                                  fontFamily: 'GmarketSans',
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => IntroductionAnimationScreen(),
                              ),
                            );
                          },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: Color.fromARGB(8, 0, 0, 0),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Center(
                              child: Text(
                                '앱 사용법',
                                style: TextStyle(
                                  fontFamily: 'GmarketSans',
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
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
                          onTap: () async {
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
                            log("개발자정보가 눌렸습니다.");
                          },
                          child: Text(
                            '개발자 정보',
                            style: TextStyle(color: Colors.grey, fontSize: 12.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

class FestivalInfo {
  final String id;
  final String name;
  final String imageUrl;

  FestivalInfo({required this.id, required this.name, required this.imageUrl});
}

void _showKeywordDialog() async {
  List<String> keywords = [
    "지역축제",
    "음악축제",
    "대학축제",
    "전시회",
    "군대행사",
    "게임행사",
    "영화제",
    "종교축제"
  ];
  List<String> selectedKeywords = [];

  showDialog(
    context: Get.context!,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Text("관심있는 축제키워드 4개를 선택하세요!"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: keywords.map((keyword) {
                return CheckboxListTile(
                  title: Text(keyword),
                  value: selectedKeywords.contains(keyword),
                  onChanged: (bool? value) {
                    if (value == true && selectedKeywords.length < 4) {
                      setState(() {
                        selectedKeywords.add(keyword);
                      });
                    } else if (value == false) {
                      setState(() {
                        selectedKeywords.remove(keyword);
                      });
                    }
                  },
                );
              }).toList(),
            ),
            actions: [
              if (selectedKeywords.length == 4)
                TextButton(
                  onPressed: () async {
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    await prefs.setStringList('mycategory', selectedKeywords);
                    Navigator.of(context).pop();
                  },
                  child: Text('확인'),
                ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('취소'),
              ),
            ],
          );
        },
      );
    },
  );
}
