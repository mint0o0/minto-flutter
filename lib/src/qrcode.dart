import 'dart:async';
import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner; //qrscan 패키지를 scanner 별칭으로 사용.
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(QRex());
}

class QRex extends StatefulWidget {
  @override
  _QRexState createState() => _QRexState();
}

class _QRexState extends State<QRex> {
  String _output = 'Empty Scan Code';

  @override
  void initState() {
    super.initState();
    _requestCameraPermission();
  }

  Future<void> _requestCameraPermission() async {
    final status = await Permission.camera.request();
    if (status != PermissionStatus.granted) {
      // 카메라 권한이 거부되었을 때 처리할 내용을 여기에 추가하세요.
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[300],
        body: Builder(
          builder: (BuildContext context) {
            return Center(
              child: Text(_output, style: TextStyle(color: Colors.black)),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _scan(),
          tooltip: 'scan',
          child: const Icon(Icons.camera_alt),
        ),
      ),
    );
  }

  Future<void> _scan() async {
    String? barcode = await scanner.scan();
    if (barcode != null) {
      setState(() => _output = barcode);
    }
  }
}