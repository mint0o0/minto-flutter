import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gauge_indicator/gauge_indicator.dart';
import 'package:minto/src/tutoriall.dart';
import 'package:minto/src/myhistory.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:minto/src/presentation/view/pages/create_or_import_screen.dart';
import 'package:minto/src/fesitival_detail.dart';

void main() {
  runApp(MyPaging());
}

class MyPaging extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: MyPage(),
    );
  }
}

class MyPageController extends GetxController {
  var festivalId = ''.obs;
  var festivalName = ''.obs;
  var festivalImageUrl = ''.obs;
  var isLoading = true.obs;
  var monthlyFestivalCount = 0.obs;
  var totalFestivalCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchFestivalDetails();
    fetchFestivalCounts();
  }

  Future<void> fetchFestivalDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final id = prefs.getString('festivalId');
    festivalId.value = id ?? ''; // Update the festivalId observable
    log("마이페이지2에서의 festivalID:$id ");
    if (id != null && id.isNotEmpty) {
      final response = await http.get(Uri.parse('http://3.34.98.150:8080/festival/$id'));

      if (response.statusCode == 200) {
        final data = jsonDecode(utf8.decode(response.bodyBytes));
        festivalName.value = data['name'];
        festivalImageUrl.value = data['imageList'][0];
        isLoading.value = false;
      } else {
        isLoading.value = false;
        throw Exception('Failed to load festival details');
      }
    } else {
      isLoading.value = false;
    }
  }

  Future<void> fetchFestivalCounts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final accesstoken = prefs.getString('accesstoken');
    final headers = {'Authorization': 'Bearer $accesstoken'};

    final now = DateTime.now();
    final month = now.month;

    final monthlyResponse = await http.get(
      Uri.parse('http://3.34.98.150:8080/member/visitFestival/$month'),
      headers: headers,
    );

    if (monthlyResponse.statusCode == 200) {
      print("http://3.34.98.150:8080/member/visitFestival/$month에서 200떴어염");
      final Map<String, dynamic> monthlyData = jsonDecode(monthlyResponse.body);
      monthlyFestivalCount.value = monthlyData.length;
    } else {
      throw Exception('Failed to load monthly festival count');
    }

    final totalResponse = await http.get(
      Uri.parse('http://3.34.98.150:8080/member/visit/festival'),
      headers: headers,
    );

    if (totalResponse.statusCode == 200) {
      print("http://3.34.98.150:8080/member/visit/festival에서 200떴어염");
      final totalData = jsonDecode(totalResponse.body);
      log(totalData.toString());
      totalFestivalCount.value = totalData.length;
    } else {
      throw Exception('Failed to load total festival count');
    }
  }
}

class MyPage extends StatelessWidget {
  final MyPageController controller = Get.put(MyPageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          } else {
            return ListView(
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
                            if (controller.festivalName.value.isNotEmpty &&
                                controller.festivalImageUrl.value.isNotEmpty) {
                              Get.to(() => FestivalDetail(festivalId: controller.festivalId.value));
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
                                        child: controller.festivalImageUrl.value.isNotEmpty
                                            ? Image.network(
                                                controller.festivalImageUrl.value,
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
                                          controller.festivalName.value.isNotEmpty
                                              ? controller.festivalName.value
                                              : "참여중인 축제가 아직 없습니다!",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 16, fontFamily: 'GmarketSans'),
                                        ),
                                      ),
                                      if (controller.festivalImageUrl.value.isNotEmpty)
                                        Text(
                                          "참여중",
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                              color: Colors.green,
                                              fontSize: 16,
                                              fontFamily: 'GmarketSans'),
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
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
                        child: Text(
                          '축제 방문 기록',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                            fontFamily: 'GmarketSans',
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: 2.0),
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: GestureDetector(
                          onTap: () {
                            Get.to(MyHistory());
                            print("축제기록이 눌렸습니다");
                          },
                          child: Material(
                            elevation: 4,
                            borderRadius: BorderRadius.circular(30),
                            child: Container(
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Color.fromARGB(109, 206, 206, 206),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                            '이번달 참여축제수',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontFamily: 'GmarketSans'),
                                          ),
                                          SizedBox(height: 10),
                                          Obx(() => Text(
                                                '${controller.monthlyFestivalCount}',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(fontFamily: 'GmarketSans'),
                                              )),
                                          SizedBox(height: 10),
                                          AnimatedRadialGauge(
                                            duration: const Duration(seconds: 1),
                                            curve: Curves.elasticOut,
                                            radius: 50,
                                            value: controller.monthlyFestivalCount.toDouble(),
                                            axis: GaugeAxis(
                                              min: 0,
                                              max: 30,
                                              degrees: 180,
                                              style: const GaugeAxisStyle(
                                                thickness: 20,
                                                background: Color(0xFFDFE2EC),
                                                segmentSpacing: 4,
                                              ),
                                              pointer: GaugePointer.needle(
                                                width: 16,
                                                height: 30,
                                                borderRadius: 16,
                                                color: Color(0xFF193663),
                                              ),
                                              progressBar: const GaugeProgressBar.rounded(
                                                color: Color(0xFFB4C2F8),
                                              ),
                                              segments: [
                                                const GaugeSegment(
                                                  from: 0,
                                                  to: 10,
                                                  color: Color(0xFFD9DEEB),
                                                  cornerRadius: Radius.zero,
                                                ),
                                                const GaugeSegment(
                                                  from: 10,
                                                  to: 20,
                                                  color: Color(0xFFD9DEEB),
                                                  cornerRadius: Radius.zero,
                                                ),
                                                const GaugeSegment(
                                                  from: 20,
                                                  to: 30,
                                                  color: Color(0xFFD9DEEB),
                                                  cornerRadius: Radius.zero,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            '참여한 총 축제수',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontFamily: 'GmarketSans'),
                                          ),
                                          SizedBox(height: 10),
                                          Obx(() => Text(
                                                '${controller.totalFestivalCount}',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(fontFamily: 'GmarketSans'),
                                              )),
                                          SizedBox(height: 10),
                                          AnimatedRadialGauge(
                                            duration: const Duration(seconds: 1),
                                            curve: Curves.elasticOut,
                                            radius: 50,
                                            value: controller.totalFestivalCount.toDouble(),
                                            axis: GaugeAxis(
                                              min: 0,
                                              max: 360,
                                              degrees: 180,
                                              style: const GaugeAxisStyle(
                                                thickness: 20,
                                                background: Color(0xFFDFE2EC),
                                                segmentSpacing: 4,
                                              ),
                                              pointer: GaugePointer.needle(
                                                width: 16,
                                                height: 30,
                                                borderRadius: 16,
                                                color: Color(0xFF193663),
                                              ),
                                              progressBar: const GaugeProgressBar.rounded(
                                                color: Color(0xFFB4C2F8),
                                              ),
                                              segments: [
                                                const GaugeSegment(
                                                  from: 0,
                                                  to: 120,
                                                  color: Color(0xFFD9DEEB),
                                                  cornerRadius: Radius.zero,
                                                ),
                                                const GaugeSegment(
                                                  from: 120,
                                                  to: 240,
                                                  color: Color(0xFFD9DEEB),
                                                  cornerRadius: Radius.zero,
                                                ),
                                                const GaugeSegment(
                                                  from: 240,
                                                  to: 360,
                                                  color: Color(0xFFD9DEEB),
                                                  cornerRadius: Radius.zero,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => IntroductionAnimationScreen(),
                            ),
                          );
                        },
                        child: Card(
                          elevation: 4,
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 93, 167, 139),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              '튜토리얼',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontSize: 16,
                                fontFamily: 'GmarketSans',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      GestureDetector(
                        onTap: () async {
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          await prefs.remove('privateKey');
                          await prefs.remove('address');
                          await prefs.remove('festivalId');
                          Get.offAndToNamed('/createOrImportWallet');
                          print("로그아웃버튼 눌림");
                        },
                        child: Card(
                          elevation: 4,
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 93, 167, 139),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              '로그아웃',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontSize: 16,
                                fontFamily: 'GmarketSans',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      GestureDetector(
                        onTap: () => onDeveloperInfo(context),
                        child: Card(
                          elevation: 4,
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 93, 167, 139),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              '개발자정보',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontSize: 16,
                                fontFamily: 'GmarketSans',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
        }),
      ),
    );
  }
}

void onDeveloperInfo(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('개발자 정보'),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              Text('프론트: 박유나 \nrealyuna@cau.ac.kr'),
              Text('\n'),
              Text('백엔드: 한상구 \nhansanggu@cau.ac.kr'),
              Text('\n'),
              Text('팀리더: 이지학 \neasyhak@cau.ac.kr'),
            ],
          ),
        ),
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
