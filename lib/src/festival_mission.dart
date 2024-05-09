
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:get/get.dart';
import 'package:minto/src/components/loading_screen.dart';
import 'package:minto/src/misson_detail.dart';


class FestivalMission extends StatelessWidget {
  final Map<String, dynamic> festivalData;

  FestivalMission({required this.festivalData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title: Text(festivalData['name']),
         title: Text('미션 카드',style:TextStyle(fontFamily:'GmarketSans',color: Colors.white,fontWeight: FontWeight.bold),),
         centerTitle: true,
        backgroundColor: Color.fromARGB(255, 93, 167, 139),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: festivalData['missions'].length,
          itemBuilder: (context, index) {
            var mission = festivalData['missions'][index];
            var imageUrl = mission['imageList'][0]; // 첫 번째 이미지만 사용

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 4,
                color: Colors.white, // 카드 배경 흰색으로 변경
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0), // 카드 모서리 둥글게
                ),
                child: InkWell(
                  onTap: () {
                    Get.to(MissionDetailPage(missionData: mission),);
                    // 미션을 클릭할 때 할 작업 추가
                    print('미션 클릭됨');
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)), // 이미지 위쪽 모서리 둥글게
                        child: AspectRatio(
                          aspectRatio: 16 / 9, // 이미지 비율 설정
                          child: Image.network(
                            imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          '미션${index + 1}: ${mission['name']}\n${mission['location']}',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
      
    );
  }
}

