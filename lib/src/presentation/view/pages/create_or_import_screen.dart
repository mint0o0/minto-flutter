import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

import 'admin/admin_login_screen.dart';

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
      Timer(const Duration(milliseconds: 100), () {
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
    _controller.dispose();
    //_controller = null;
  }

  _getVideoBackground() {
    return AnimatedOpacity(
      opacity: _visible ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 1000),
      child: VideoPlayer(_controller),
    );
  }

  _getBackgroundColor() {
    return Container(
      color: const Color.fromARGB(104, 28, 28, 28).withAlpha(120),
    );
  }

  _getLoginButtons() {
    return <Widget>[
      Padding(
  padding: const EdgeInsets.all(16.0), // 16 logical pixels of padding on all sides
  child: GestureDetector(
    onTap: () {
    Get.toNamed('/generateMnemonic');
  
    },
    child: Container(
      // margin: EdgeInsets.symmetric(horizontal: 64.0),
      padding: const EdgeInsets.all(16.0), // 16 logical pixels of padding inside the container
      decoration: BoxDecoration(
        color: Colors.white, // Background color of the container
        borderRadius: BorderRadius.circular(8.0), // Rounded corners
      ),
      child: Center(
        child: Text(
          '전자지갑 생성',
          style: TextStyle(
            color:Colors.black, // Text color
            fontSize: 18.0, // Font size
          ),
        ),
      ),
    ),
  ),
),
      Padding(
  padding: const EdgeInsets.all(16.0), // 16 logical pixels of padding on all sides
  child: GestureDetector(
    onTap: () {
    Get.toNamed('/importWallet');
    },
    child: Container(
      // margin: EdgeInsets.symmetric(horizontal: 64.0),
      padding: const EdgeInsets.all(16.0), // 16 logical pixels of padding inside the container
      decoration: BoxDecoration(
        color: Colors.blue, // Background color of the container
        borderRadius: BorderRadius.circular(8.0), // Rounded corners
      ),
      child: Center(
        child: Text(
          '기존지갑 입력',
          style: TextStyle(
            color: Colors.white, // Text color
            fontSize: 18.0, // Font size
          ),
        ),
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
        const SizedBox(
          height: 50.0,
        ),
        const Image(
          image: AssetImage("assets/images/first_logo.png"),
          width: 150.0,
        ),
        const Text(
          "MINTO",
          style: TextStyle(color: Colors.white, fontSize: 40),
        ),
        Container(
          margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 40.0),
          alignment: Alignment.center,
          child: const Text(
            "민토와 함께 축제를\n특별하고 소중한 추억으로 만들어요",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
        const SizedBox(height: 10),
        // "지갑을 생성하는 이유" 텍스트와 관련된 기능 추가
        // InkWell(
        //   onTap: () {
        //     showDialog(
        //       context: context,
        //       builder: (BuildContext context) {
        //         return AlertDialog(
        //           content: Column(
        //             mainAxisSize: MainAxisSize.min,
        //             children: [
        //               Image(
        //                 image: AssetImage("assets/images/help1.png"),
        //                 height: 100,
        //               ),
        //               SizedBox(height: 8),
        //               Text(
        //                 "NFT발급 서비스를 위해서 필요합니다!",
        //                 textAlign: TextAlign.center,
        //               ),
        //             ],
        //           ),
        //         );
        //       },
        //     );
        //   },
        //   child: Container(
        //     margin: const EdgeInsets.symmetric(horizontal: 20),
        //     alignment: Alignment.center,
        //     child: Text(
        //       "지갑을 생성하는 이유",
        //       style: TextStyle(
        //         color: Colors.white,
        //         decoration: TextDecoration.underline,
        //       ),
        //     ),
        //   ),
        // ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () {
            Get.to(AdminLoginScreen());
            //Get.to(AdmingLoginScreen());
            log("관리자 text가 눌렸습니다");
          },
          child: Container(
            margin: const EdgeInsets.only(top: 20),
            alignment: Alignment.center,
            child: const Text(
              "관리자 이신가요?",
              style: TextStyle(
                color: Color.fromARGB(255, 255, 88, 88),
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ),
        // 로그인 버튼 등
        ..._getLoginButtons(),
        const SizedBox(height: 18),
        InkWell(
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return const AlertDialog(
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image(
                        image: AssetImage("assets/images/help1.png"),
                        height: 100,
                      ),
                      SizedBox(height: 8),
                      Text(
                        "NFT발급 서비스를 위해서 필요합니다!\n\nNFT(대체불가토큰) 란?\n독특하고 복제 불가능한 디지털 자산의\n소유권을 나타내는 증명서",
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              },
            );
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            alignment: Alignment.center,
            child: const Text(
              "지갑을 생성하는 이유",
              style: TextStyle(
                color: Colors.white,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ),
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
