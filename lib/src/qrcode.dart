import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';




void main() {
  runApp(QRex());
}

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
      print("출력억");
      print(walletAddress);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[300],
        body: Center(
          child: Text('QRex App'),
        ),
      ),
    );
  }

  Future<void> _scan() async {
    String? barcode = await scanner.scan();
    if (barcode != null) {
      _sendRequest(barcode);
    }
  }

  Future<void> _sendRequest(String barcode) async {
    final url = Uri.parse('http://3.34.98.150:8080/mission/complete');
    final headers = { 'Content-Type': 'application/json','Authorization': 'Bearer $walletAddress'};
    final body = json.encode({
    "festivalId": "6603c1402f041fd10124645d",
    "missionIndex": 2
});

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        print('200입니다');
        print('Response: ${response.body}');
      } else if (response.statusCode == 201) {
        print('201입니다');
        print('Response: ${response.body}');
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error sending request: $e');
    }
  }
}
