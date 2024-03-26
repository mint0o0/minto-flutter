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
              
              height: MediaQuery.of(context).size.height * 0.4,
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
                  SizedBox(height: 20),
                  //위젯3 검색바
                 // 위젯3 검색바
Row(
  children: [
    Expanded(
      child: Container(
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
    ),
    SizedBox(width: 8), // 아이콘과 검색 바 사이 간격 조절
    buildSearchButton(context), // 검색 버튼 추가
  ],
),
SizedBox(height: 20),
buildMapButton(context),

                  SizedBox(height: 25),

                  //위젯 5 
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Column(
                  //       children: [
                  //         ClipOval(
                  //           child: Image.asset(
                  //             'assets/images/location_icon.jpg',
                  //             width: 60,
                  //           ),
                  //         ),
                  //         SizedBox(height: 8),
                  //         Text(
                  //           '지역축제',
                  //           style: TextStyle(fontSize: 12),
                  //         ),
                  //       ],
                  //     ),
                  //     Column(
                  //       children: [
                  //         ClipOval(
                  //           child: Image.asset(
                  //             'assets/images/location_icon.jpg',
                  //             width: 60,
                  //           ),
                  //         ),
                  //         SizedBox(height: 8),
                  //         Text(
                  //           '음악 축제',
                  //           style: TextStyle(fontSize: 12),
                  //         ),
                  //       ],
                  //     ),
                  //     Column(
                  //       children: [
                  //         ClipOval(
                  //           child: Image.asset(
                  //             'assets/images/location_icon.jpg',
                  //             width: 60,
                  //           ),
                  //         ),
                  //         SizedBox(height: 8),
                  //         Text(
                  //           '박람회',
                  //           style: TextStyle(fontSize: 12),
                  //         ),
                  //       ],
                  //     ),
                  //     Column(
                  //       children: [
                  //         ClipOval(
                  //           child: Image.asset(
                  //             'assets/images/location_icon.jpg',
                  //             width: 60,
                  //           ),
                  //         ),
                  //         SizedBox(height: 8),
                  //         Text(
                  //           '전시회',
                  //           style: TextStyle(fontSize: 12),
                  //         ),
                  //       ],
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),),),
            SizedBox(height: 30),
            //위젯6
            Padding(
               
              padding: const EdgeInsets.symmetric(horizontal: 10),
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
            //SizedBox(height: 3),
            //위젯7 카드 스위치 이용한 위젯
            buildFestivalWidget(),
            SizedBox(height: 14),
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
            SizedBox(height: 14),
            //위젯9 카드
            buildFestivalList(),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
Widget buildSearchButton(BuildContext context) {
  return IconButton(
    onPressed: () {
      // 검색 버튼 클릭 시 실행되는 동작을 정의합니다.
      // 여기에 검색 기능을 구현할 수 있습니다.
    },
    icon: Icon(
      Icons.search, 
      
    ),
  );
}

Widget buildMapButton(BuildContext context) {
  return InkWell(
    onTap: () {
      // 버튼을 눌렀을 때 실행되는 동작을 정의합니다.
      print("지도 버튼이 눌렸습니다");
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Text(
        '📍지도로 축제 한눈에 보기',
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.bold,
          color: const Color.fromARGB(255, 255, 255, 255),
          //decoration: TextDecoration.underline, 
        ),
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
      children: [
        ...List.generate(
          endIndex - startIndex,
          (idx) {
            return Expanded(
              child: AspectRatio(
                aspectRatio: 1/2,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                 color: Color.fromARGB(255, 191, 137, 228),
                  elevation: 10,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        flex: 3,
                        child: ClipRRect(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                          child: Image.asset(
                            festivalData[startIndex + idx][0],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                festivalData[startIndex + idx][1],
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(festivalData[startIndex + idx][2],style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 11,
                                  //fontWeight: FontWeight.bold,
                                ),),
                              SizedBox(height: 4),
                              Text(festivalData[startIndex + idx][3],style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 11,
                                  //fontWeight: FontWeight.bold,
                                ),),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        // 마지막 줄의 마지막 아이템이 왼쪽에 위치하도록 빈 Expanded 위젯 추가
        if (endIndex%2!=0)
         if (endIndex == festivalData.length) Expanded(child: SizedBox()),
        
       
      ],
    );
  },
),
    ),
  );
}


}
