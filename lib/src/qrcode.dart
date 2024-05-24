import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:minto/src/festival_mission.dart';
// void main() {
//   runApp(QRex());
// }

class QRex extends StatefulWidget {
  
  @override
  _QRexState createState() => _QRexState();
}


class _QRexState extends State<QRex> {
  String walletAddress = '';

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    await _requestCameraPermission();
    await loadSharedPreferences();
    _scan();
  }

  Future<void> _requestCameraPermission() async {
    final status = await Permission.camera.request();
    if (status != PermissionStatus.granted) {
      log("camera permission is denied");
    }
  }

  Future<void> loadSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      walletAddress = prefs.getString('accesstoken') ?? '';
      print(walletAddress);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 224, 224, 224),
        body: Center(
          child: Text('QR코드를 찍을 카메라를 로딩중입니다.'),
        ),
      ),
    );
  }

  Future<void> _scan() async {
    String? barcode = await scanner.scan();
    if (barcode != null) {
      // Assuming the barcode contains a JSON string with festivalId and missionIndex
      try {
        final data = json.decode(barcode);
        log("****************************************************");
        log("data: $data");
        final String festivalId = data['festivalId'];
        log("festivalId: $festivalId");
        final int missionIndex = data['missionIndex'];
        log("festivalId: $missionIndex");
        log("****************************************************");
        _sendRequest(festivalId, missionIndex);
      } catch (e) {
        print('Error parsing barcode: $e');
      }
    }
  }

  Future<void> _sendRequest(String festivalId, int missionIndex) async {
    final url = Uri.parse('http://3.34.98.150:8080/member/mission/complete');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $walletAddress'
    };
    final body = json.encode({
      "festivalId": festivalId,
      "missionIndex": missionIndex
    });

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        print('Request successful: ${response.body}');
        print("200입니다");
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('festivalId', festivalId);
        log("qr코드를 보낸값이 200이 뜬후 shared에 있는 festivalid: $festivalId");
        //Get.back();
        _navigateBackTwoPages();
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error sending request: $e');
    }
  }
  void _navigateBackTwoPages() {
    int count = 0;
    Get.until((route) => count++ == 2);
  }
}
