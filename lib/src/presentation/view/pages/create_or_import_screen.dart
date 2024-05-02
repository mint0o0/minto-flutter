import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:video_player/video_player.dart';

class CreateOrImportPage extends StatefulWidget {
  CreateOrImportPage({Key? key}) : super(key: key ?? GlobalKey());

  @override
  State<StatefulWidget> createState() => _CreateOrImportPageState();
}

class _CreateOrImportPageState extends State<CreateOrImportPage> {
  late VideoPlayerController _controller;
  bool _visible = false;

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);


    _controller = VideoPlayerController.asset("assets/videos/login_vid.mp4");
    _controller.initialize().then((_) {
      _controller.setLooping(true);
      Timer(Duration(milliseconds: 100), () {
        setState(() {
          _controller.play();
          _visible = true;
        });
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (_controller != null) {
      _controller.dispose();
      //_controller = null;
    }
  }

  _getVideoBackground() {
    return AnimatedOpacity(
      opacity: _visible ? 1.0 : 0.0,
      duration: Duration(milliseconds: 1000),
      child: VideoPlayer(_controller),
    );
  }

  _getBackgroundColor() {
    return Container(
      color: Color.fromARGB(104, 28, 28, 28).withAlpha(120),
    );
  }

 _getLoginButtons() {
  return <Widget>[
    InkWell(
      onTap: () {
        Get.toNamed('/generateMnemonic');
      },
      child: Container(
        margin: const EdgeInsets.only(left: 20, right: 20),
        width: double.infinity,
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
          child: const Text('전자지갑 생성'),
        ),
      ),
    ),
    InkWell(
      onTap: () {
        Get.toNamed('/importWallet');
      },
      child: Container(
        margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
        width: double.infinity,
        child: Container(
          color: Colors.blueAccent,
          padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
          child: const Text(
            '기존지갑 입력',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    ),
  ];
}
  _getContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 50.0,
        ),
        Image(
          image: AssetImage("assets/images/first_logo.png"),
          width: 150.0,
        ),
        Text(
          "MINTO",
          style: TextStyle(color: Colors.white, fontSize: 40),
        ),
        Container(
          margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 40.0),
          alignment: Alignment.center,
          child: Text(
            "민토와 함께 축제를 영구적인 추억으로 만들어요",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
        Spacer(),
        ..._getLoginButtons()
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: <Widget>[
            _getVideoBackground(),
            _getBackgroundColor(),
            _getContent(),
          ],
        ),
      ),
    );
  }
}