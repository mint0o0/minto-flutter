import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:card_swiper/card_swiper.dart';

class FestivalScreen extends StatelessWidget {
  const FestivalScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> festivalList = [
      'assets/images/festival_example.png',
      'assets/images/festival_example_1.jpg',
      'assets/images/festival_example_2.jpg',
    ];

    return Column(
      children: [
        Container(
          height: 250,
          width: double.infinity,
          child: Swiper(
            // Todo: 백엔드에서 받아오는 이미지의 갯수만큼 변경
            itemCount: 3,
            autoplay: true,
            autoplayDelay: 3000,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Image.asset(
                    // Todo: 백엔드에서 받아온 이미지로 변경
                    // Todo: 받아온 이미지에 간단한 정보 작성
                    festivalList[index],
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
            itemHeight: 200,
            itemWidth: 400,
            layout: SwiperLayout.TINDER,
          )
        ),
      ]
    );
  }
}
