import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:animated_size_and_fade/animated_size_and_fade.dart';
import 'dart:async';
import 'package:minto/src/app.dart';
import 'package:get/get.dart';
void main() {
  runApp(LoadingScreen());
}

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  bool _showFirstText = true;
  late Timer _timer;
  double _circleSize = 0.0;
  bool _showSecondText = false; // 두 번째 텍스트를 표시할지 여부를 나타내는 변수

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 12), (timer) {
      setState(() {
        _showFirstText = !_showFirstText;
      });
    });

    // 원 크기 애니메이션
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _circleSize = _circleSize == 0.0 ? 150.0 : 0.0;
      });
    });

    Timer(Duration(seconds: 12), () {
      // 12초 뒤에 다이얼로그로 메시지 표시
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("알림"),
            content: Text("nft가 다 생성되었습니다!"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  // 다이얼로그 닫기
                },
                child: Text("확인"),
              ),
            ],
          );
        },
      );
      Get.to(() => App());
      _timer.cancel();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // 로고 이미지
            Image.asset(
              'assets/images/first_logo.png', // 로고 이미지 경로
              width: 150, // 로고 이미지 너비
              height: 150, // 로고 이미지 높이
            ),
            // 원 애니메이션
            AnimatedContainer(
  duration: Duration(seconds: _circleSize == 0.0 ? 6 : 0), // _circleSize 값에 따라 duration 설정
  width: _circleSize,
  height: _circleSize,
  decoration: BoxDecoration(
    color: Colors.red,
    shape: BoxShape.circle,
  ),
),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 160),
                AnimatedOpacity(
                  duration: Duration(milliseconds: 400),
                  opacity: _showFirstText ? 1.0 : 0.0,
                  child: Text(
                    "nft 생성까지 조금만 기다려주세요",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                // AnimatedOpacity(
                //   duration: Duration(milliseconds: 400),
                //   opacity: _showSecondText ? 1.0 : 0.0, // 두 번째 텍스트를 표시할지 여부에 따라 투명도 조절
                //   child: Text(
                //     "nft가 다 생성되었습니다!",
                //     style: TextStyle(fontSize: 18),
                //   ),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}