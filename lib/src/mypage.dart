import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:minto/src/fesitival_detail.dart';

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

  @override
  void initState() {
    super.initState();
    fetchFestivalDetails();
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

  Future<void> _refreshData() async {
    setState(() {
      isLoading = true;
    });
    await fetchFestivalDetails();
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
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FestivalDetail(festivalId: festivalId),
                                  ),
                                ).then((_) => _refreshData());
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('축제 탐색'),
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
                                  color: Color.fromARGB(109, 206, 206, 206),
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
                        SizedBox(height: 16),
                        GestureDetector(
                          onTap: () {
                            log("불투명한 박스가 눌렸습니다");
                          },
                          child: Container(
                            color: Colors.black.withOpacity(0.2),
                            padding: EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    ClipOval(
                                      child: Image.asset(
                                        'assets/images/fest1.png',
                                        width: 80,
                                        height: 80,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Column(
                          
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {
                                            log("내정보수정이 눌렸습니다");
                                          },
                                          child: Text("내 정보 수정"),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            log("튜토리얼버튼이 눌렸습니다");
                                          },
                                          child: Text("튜토리얼"),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: 16),
                                Padding(
  padding: const EdgeInsets.all(16.0),
  child: Align(
    alignment: Alignment.centerLeft,
    child: Text("최근 방문한 축제"),
  ),
),
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      ClipOval(
                                        child: Image.asset(
                                          'assets/images/fest1.png',
                                          width: 60,
                                          height: 60,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      ClipOval(
                                        child: Image.asset(
                                          'assets/images/fest1.png',
                                          width: 60,
                                          height: 60,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      ClipOval(
                                        child: Image.asset(
                                          'assets/images/fest1.png',
                                          width: 60,
                                          height: 60,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      ClipOval(
                                        child: Image.asset(
                                          'assets/images/fest1.png',
                                          width: 60,
                                          height: 60,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
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
