import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:minto/src/qrcode.dart';
class MissionDetailPage extends StatelessWidget {
  final Map<String, dynamic> missionData;

  MissionDetailPage({required this.missionData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: ContinuousRectangleBorder(
    borderRadius: BorderRadius.only(
      bottomLeft: Radius.circular(20.0), // 왼쪽 둥근 모서리
      bottomRight: Radius.circular(20.0), // 오른쪽 둥근 모서리
    ),
  ),
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 93, 167, 139),
        title: Text(missionData['name'],style: TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
            fontFamily: 'GmarketSans',
            fontWeight: FontWeight.bold,
          ),),
          centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 미션 사진들 가로 스크롤 위젯
            Container(
              height: 200, // 적절한 높이 설정
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: missionData['imageList'].length,
                itemBuilder: (context, index) {
                  var imageUrl = missionData['imageList'][index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network(imageUrl),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            // 미션 설명
            Text(
              '미션 설명:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
            ),
            SizedBox(height: 10),
            Text(
              missionData['description'],
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            // 미션 장소
            Text(
              '미션 장소: ${missionData['location']}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
            ),
            SizedBox(height: 20),
            // 미션 시작 및 종료 시간
            Text(
              '시작 시간: ${missionData['startTime'].split('T')[0]}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
            ),
            SizedBox(height: 10),
            Text(
              '종료 시간: ${missionData['endTime'].split('T')[0]}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
            ),
            SizedBox(height: 20),
            // 완료 버튼
            GestureDetector(
              onTap: () {
                 Get.to(QRex());
                // 완료 버튼 동작 추가
                print('미션 완료');
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 16),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 93, 167, 139),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '완료',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
