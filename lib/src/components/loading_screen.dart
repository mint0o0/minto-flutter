import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:animated_size_and_fade/animated_size_and_fade.dart';
import 'dart:async';
import 'package:minto/src/app.dart';

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
      // 12초 뒤에 이동
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => App()),
      );
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
              duration: Duration(seconds: 6), // 6초동안 애니메이션 반복
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
                SizedBox(height: 120),
                AnimatedOpacity(
                  duration: Duration(milliseconds: 400),
                  opacity: _showFirstText ? 1.0 : 0.0,
                  child: Text(
                    "조금만 기다려주세요",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                AnimatedOpacity(
                  duration: Duration(milliseconds: 400),
                  opacity: _showFirstText ? 0.0 : 1.0,
                  child: Text(
                    "거의 다 됐어요",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
