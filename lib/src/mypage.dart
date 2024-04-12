import 'package:flutter/material.dart';
import 'package:gauge_indicator/gauge_indicator.dart';
import 'package:minto/src/tutoriall.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:minto/src/presentation/view/pages/create_or_import_screen.dart';
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

class RoundedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  RoundedButton({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(text),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 60),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        fixedSize: Size(200, 50), // 버튼의 고정된 크기를 지정합니다.
      ),
    );
  }
}

class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset('assets/images/minto_icon.png', width: 180, height: 80),
        backgroundColor: Color.fromARGB(200, 191, 169, 231),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '▶ 축제 방문 기록',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                print("축제기록이 눌렸습니다");
              },
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(20),
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
                            ),
                            SizedBox(height: 10),
                            Text(
                              '3',
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 10),
                            AnimatedRadialGauge(
                              duration: const Duration(seconds: 1),
                              curve: Curves.elasticOut,
                              radius: 50,
                              value: 3,
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
                            ),
                            SizedBox(height: 10),
                            Text(
                              '45',
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 10),
                            AnimatedRadialGauge(
                              duration: const Duration(seconds: 1),
                              curve: Curves.elasticOut,
                              radius: 50,
                              value: 45,
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
            SizedBox(height: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RoundedButton(
                  text: '앱 사용법',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => IntroductionAnimationScreen()),
                    );
                  },
                ),
                SizedBox(height: 20),
                RoundedButton(
  text: '로그아웃하기',
  onPressed: () async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('privateKey');
    await prefs.remove('address');
    Get.offAndToNamed('/createOrImportWallet');
    print("로그아웃버튼 눌림");
  },
),
                SizedBox(height: 20),
                RoundedButton(
                  text: '개발자 정보',
                  onPressed: () => onDeveloperInfo(context),
                ),
              ],
            ),
          ],
        ),
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
                Text('팀리더: 이지학 \easyhak@cau.ac.kr'),
              
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // 다이얼로그 닫기
              },
              child: Text('닫기'),
            ),
          ],
        );
      },
    );
  }
