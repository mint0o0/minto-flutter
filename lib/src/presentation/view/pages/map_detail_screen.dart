import 'package:flutter/material.dart';

import '../../../map_widget.dart';

class MapDetail extends StatelessWidget {
  const MapDetail({
    super.key,
    required this.latitude,
    required this.longitude,
    required this.festivalId,
  });
  final String latitude;
  final String longitude;
  final String festivalId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.0), // 왼쪽 둥근 모서리
            bottomRight: Radius.circular(20.0), // 오른쪽 둥근 모서리
          ),
        ),
        backgroundColor: Color.fromARGB(255, 93, 167, 139),
        title: Text("자세히 보기",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        centerTitle: true,
      ),
      body: MapWidget(
        latitude: double.parse(latitude),
        longitude: double.parse(longitude),
        festivalId: festivalId,
      ),
    );
  }
}
