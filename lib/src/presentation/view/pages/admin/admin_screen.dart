import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:minto/src/presentation/view/pages/admin/admin_create_festival_screen.dart';
import 'package:minto/src/presentation/view/pages/admin/festival_statistics_screen.dart';
import 'package:minto/src/presentation/view_model/festival/festival_view_model.dart';

class AdminScreen extends StatelessWidget {
  final FestivalViewModel festivalViewModel = Get.put(FestivalViewModel());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: ListView(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () =>
                        {Get.to(() => AdminCreateFestivalScreen())},
                    child: const Text("create festival"),
                  ),
                  ElevatedButton(
                    onPressed: () => {Get.toNamed('/')},
                    child: const Text("logout"),
                  ),
                  /*            GetBuilder<FestivalViewModel>(
                    init: FestivalViewModel(),
                    builder: (FestivalViewModel festivalViewModel) {
                      return Expanded(
                        child: ListView.builder(
                          itemCount: festivalViewModel.festivalList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              title: Text(festivalViewModel.festivalList[index].name),
                              subtitle: Text(festivalViewModel.festivalList[index].location),
                            );
                          },
                        ),
                      );
                    },
                  ),*/
                  buildFestivalList(festivalViewModel),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildFestivalList(FestivalViewModel festivalViewModel) {
    return Column(
      children: [
        for (final festival in festivalViewModel.festivalList) ...[
          GestureDetector(
            onTap: () => {
              // Get.toNamed('/festival/${festival.id}');
              Get.to(FestivalStatisticsScreen()),
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ClipRRect(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(15)),
                    child: Image.network(
                      festival.imageList.isNotEmpty
                          ? festival.imageList[0]
                          : '',
                      // 첫 번째 이미지 사용
                      height: 200, // 이미지 높이 조정 필요
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          festival.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text.rich(
                          TextSpan(
                            text: '장소: ',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold, // 장소 부분은 bold로 설정
                              color: Colors.black,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: festival.location,
                                style: const TextStyle(
                                  fontFamily: 'GmarketSans',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  // ${festival.location}은 light로 설정
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text.rich(
                          TextSpan(
                            text: '시작일: ',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold, // 장소 부분은 bold로 설정
                              color: Colors.black,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: festival.startTime,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  // ${festival.location}은 light로 설정
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text.rich(
                          TextSpan(
                            text: '종료일: ',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold, // 장소 부분은 bold로 설정
                              color: Colors.black,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: festival.endTime,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  // ${festival.location}은 light로 설정
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ],
    );
  }
}
