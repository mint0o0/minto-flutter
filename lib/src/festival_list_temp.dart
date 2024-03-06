import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';

void main() {
  runApp(const FestivalList());
}

class FestivalList extends StatelessWidget {
  const FestivalList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        //아래배경
        scaffoldBackgroundColor: Colors.white,
      ),
      home: Scaffold(
        body: ListView(
          children: [
            Material(
              elevation: 12,
              color:Colors.transparent,
              child:
            ClipRRect(
              //elevation: 12, // 그림자 깊이
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              //borderRadius: BorderRadius.circular(30), // 모서리 둥글게
              //color: Colors.transparent,
              child: 
            //위의 배경을 컨테이너로 만듦
            Container(
              //보라색 배경 비율
              
              height: MediaQuery.of(context).size.height * 0.5,
              decoration:BoxDecoration(
                
                gradient:LinearGradient(
                  begin:Alignment.topLeft,
                  end:Alignment.bottomRight,
                  colors: [Color.fromARGB(255, 93, 22, 206),Color.fromARGB(255, 63, 76, 151),Color.fromARGB(255, 65, 181, 234)],
                  //colors: [Color.fromARGB(255, 138, 172, 251),Color.fromARGB(255, 234, 218, 255),Color.fromARGB(255, 255, 180, 146)],
                  )
                  ),
              //color: const Color(0xDD7149E3),
              padding: EdgeInsets.fromLTRB(16, 40, 16, 0),
              alignment: Alignment.topLeft,
              child: Column(
                //세로에 위젯들 배열
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //위젯1 
                  Text(
                    '축/제/리/스/트',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  //위젯2
                  Text(
                    '축제를 즐겨보세요',
                    style: TextStyle(
                      color: const Color.fromARGB(166, 255, 255, 255),
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 16),
                  //위젯3 검색바
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: '검색어를 입력하세요...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(height: 32),
                  //위젯 5 
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          ClipOval(
                            child: Image.asset(
                              'assets/images/location_icon.jpg',
                              width: 60,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            '지역축제',
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          ClipOval(
                            child: Image.asset(
                              'assets/images/location_icon.jpg',
                              width: 60,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            '음악 축제',
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          ClipOval(
                            child: Image.asset(
                              'assets/images/location_icon.jpg',
                              width: 60,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            '박람회',
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          ClipOval(
                            child: Image.asset(
                              'assets/images/location_icon.jpg',
                              width: 60,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            '전시회',
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),),),
            SizedBox(height: 16),
            //위젯6
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                '추천 축제',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(height: 8),
            //위젯7 카드 스위치 이용한 위젯
            buildFestivalWidget(),
            SizedBox(height: 16),
            //위젯8
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                '축제 탐색하기',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            SizedBox(height: 16),
            //위젯9 카드
            buildFestivalList(),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget buildFestivalWidget() {
    final List<String> festivalList = [
      'assets/images/festival_example.png',
      'assets/images/festival_example_1.jpg',
      'assets/images/festival_example_2.jpg',
    ];

    return Container(
      height: 250,
      width: double.infinity,
      child: Swiper(
        itemCount: festivalList.length,
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
                festivalList[index],
                fit: BoxFit.cover,
              ),
            ),
          );
        },
        itemHeight: 200,
        itemWidth: 400,
        layout: SwiperLayout.TINDER,
      ),
    );
  }

  Widget buildFestivalList() {
    final List<List<dynamic>> festivalData = [
      ['assets/images/festival_example.png', 'fest1_name', 'fest1_location', '20240306'],
      ['assets/images/festival_example.png', 'fest2_name', 'fest2_location', '20240306'],
      ['assets/images/festival_example.png', 'fest3_name', 'fest3_location', '20240306'],
      ['assets/images/festival_example.png', 'fest4_name', 'fest4_location', '20240306'],
      ['assets/images/festival_example.png', 'fest5_name', 'fest5_location', '20240306'],
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: List.generate(
          (festivalData.length / 2).ceil(),
          (index) {
            int startIndex = index * 2;
            int endIndex = (index + 1) * 2;
            if (endIndex > festivalData.length) {
              endIndex = festivalData.length;
            }
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                endIndex - startIndex,
                (idx) {
                  return Expanded(
                    child: Card(
                      child: Column(
                        children: [
                          Image.asset(
                            festivalData[startIndex + idx][0],
                            height: 100,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  festivalData[startIndex + idx][1],
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(festivalData[startIndex + idx][2]),
                                SizedBox(height: 4),
                                Text(festivalData[startIndex + idx][3]),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
