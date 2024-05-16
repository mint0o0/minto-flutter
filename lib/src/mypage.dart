import 'package:flutter/material.dart';
import 'package:gauge_indicator/gauge_indicator.dart';
import 'package:minto/src/tutoriall.dart';
import 'package:minto/src/myhistory.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:minto/src/presentation/view/pages/create_or_import_screen.dart';
import 'package:minto/src/fesitival_detail.dart';
void main() {
  runApp(MyPaging());
}

class MyPaging extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyPage(),
    );
  }
}

// class RoundedButton extends StatelessWidget {
//   final String text;
//   final VoidCallback onPressed;

//   RoundedButton({required this.text, required this.onPressed});

class MyPage extends StatelessWidget {
@override
/////////////////////////////////////////////////////
Widget build(BuildContext context) {
 
  return Scaffold(
    backgroundColor: Colors.white,
    body: SafeArea(
      child: ListView(
        
        children: [




          Container(
            height: MediaQuery.of(context).size.height * 0.5,
            decoration: BoxDecoration(
    color: Color.fromARGB(255, 93, 167, 139),
    borderRadius: BorderRadius.only(
      bottomLeft: Radius.circular(20.0),
      bottomRight: Radius.circular(20.0),
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.5), // 그림자 색상과 투명도 설정
        spreadRadius: 5, // 그림자 확산 범위
        blurRadius: 7, // 그림자 흐림 정도
        offset: Offset(0, 3), // 그림자 위치 조절 (가로, 세로)
      ),
    ],
  ),
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                
                
                
                //                 Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical:1),
                //   child: Text(
                //     '참여중인 축제',
                //     style: TextStyle(
                //       fontSize: 20.0,
                //       color: Colors.white,
                //       fontFamily: 'GmarketSans',
                //       fontWeight: FontWeight.bold,
                //     ),
                //     textAlign: TextAlign.center,
                //   ),
                // ),

                
                
                
                
                
                
                
                
                
                
                
                Padding(
  padding: EdgeInsets.all(16.0),
  child: GestureDetector(
    onTap: () {
       Get.to(() => FestivalDetail(festivalId: "6632093c788e207ba11e5acf"));
      //print("눌렸습니다");
    },
    child: Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Color.fromARGB(109, 206, 206, 206),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          Row(
  children: [
    ClipRRect(
      borderRadius: BorderRadius.circular(20), // 동그랗게 만들기 위한 BorderRadius 설정
      child: Image.network(
        'https://image.dnews.co.kr/photo/photo/2023/03/10/202303101334447130498-2-357792.jpg',
        width: 40, // 이미지 크기 설정
        height: 40, // 이미지 크기 설정
        fit: BoxFit.cover,
      ),
    ),
    SizedBox(width: 8), // 이미지와 텍스트 사이의 간격 조정
    Expanded(
      child: Text(
        "고양 꽃 박람회",
        textAlign: TextAlign.center, // 텍스트를 가운데 정렬합니다.
        style: TextStyle(fontSize: 16, fontFamily: 'GmarketSans'), // 텍스트 크기 설정
      ),
    ),
    Text(
      "참여중",
       textAlign: TextAlign.right, 
      style: TextStyle(color:Colors.green,fontSize: 16, fontFamily: 'GmarketSans'), // 텍스트 크기 설정
    ),
  ],
)
          ],
        ),
      ),
    ),
  ),
),






SizedBox(height: 2,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical:5),
                  child: Text(
                    '축제 방문 기록',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                      fontFamily: 'GmarketSans',
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),










                SizedBox(height: 2.0),
                Padding(
  padding: EdgeInsets.all(16.0),
  child: GestureDetector(
    onTap: () {
      Get.to(MyHistory());
      print("축제기록이 눌렸습니다");
    },
    child: Material(
      elevation: 4,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Color.fromARGB(109, 206, 206, 206),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      '이번달 참여축제수',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontFamily: 'GmarketSans',),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '3',
                      textAlign: TextAlign.center,
                       style: TextStyle(fontFamily: 'GmarketSans',),
                    ),
                    SizedBox(height: 10),
                    AnimatedRadialGauge(
                      duration: const Duration(seconds: 1),
                      curve: Curves.elasticOut,
                      radius: 50,
                      value: 3,
                      axis: GaugeAxis(
                        min: 0,
                        max: 30,
                        degrees: 180,
                        style: const GaugeAxisStyle(
                          thickness: 20,
                          background: Color(0xFFDFE2EC),
                          segmentSpacing: 4,
                        ),
                        pointer: GaugePointer.needle(
                          width: 16,
                          height: 30,
                          borderRadius: 16,
                          color: Color(0xFF193663),
                        ),
                        progressBar: const GaugeProgressBar.rounded(
                          color: Color(0xFFB4C2F8),
                        ),
                        segments: [
                          const GaugeSegment(
                            from: 0,
                            to: 10,
                            color: Color(0xFFD9DEEB),
                            cornerRadius: Radius.zero,
                          ),
                          const GaugeSegment(
                            from: 10,
                            to: 20,
                            color: Color(0xFFD9DEEB),
                            cornerRadius: Radius.zero,
                          ),
                          const GaugeSegment(
                            from: 20,
                            to: 30,
                            color: Color(0xFFD9DEEB),
                            cornerRadius: Radius.zero,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      '참여한 총 축제수',
                      textAlign: TextAlign.center,
                       style: TextStyle(fontFamily: 'GmarketSans',),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '45',
                      textAlign: TextAlign.center,
                       style: TextStyle(fontFamily: 'GmarketSans',),
                    ),
                    SizedBox(height: 10),
                    AnimatedRadialGauge(
                      duration: const Duration(seconds: 1),
                      curve: Curves.elasticOut,
                      radius: 50,
                      value: 45,
                      axis: GaugeAxis(
                        min: 0,
                        max: 360,
                        degrees: 180,
                        style: const GaugeAxisStyle(
                          thickness: 20,
                          background: Color(0xFFDFE2EC),
                          segmentSpacing: 4,
                        ),
                        pointer: GaugePointer.needle(
                          width: 16,
                          height: 30,
                          borderRadius: 16,
                          color: Color(0xFF193663),
                        ),
                        progressBar: const GaugeProgressBar.rounded(
                          color: Color(0xFFB4C2F8),
                        ),
                        segments: [
                          const GaugeSegment(
                            from: 0,
                            to: 120,
                            color: Color(0xFFD9DEEB),
                            cornerRadius: Radius.zero,
                          ),
                          const GaugeSegment(
                            from: 120,
                            to: 240,
                            color: Color(0xFFD9DEEB),
                            cornerRadius: Radius.zero,
                          ),
                          const GaugeSegment(
                            from: 240,
                            to: 360,
                            color: Color(0xFFD9DEEB),
                            cornerRadius: Radius.zero,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  ),
),
                

                //SizedBox(height: 8.0),
               
              ],
            ),
          ),Container(
  height: MediaQuery.of(context).size.height * 0.5, // 초록색 컨테이너 아래 공간의 높이 조정
  padding: EdgeInsets.symmetric(horizontal: 16.0,vertical: 16.0),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      GestureDetector(
      onTap:() {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => IntroductionAnimationScreen()),
                          );
                        },
      child:Card(elevation:10,child: Container(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 93, 167, 139),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          '튜토리얼',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
            fontSize: 16,
            fontFamily: 'GmarketSans',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),),
    ),
      SizedBox(height:20.0),
      GestureDetector(
      onTap:  () async {
                          SharedPreferences prefs = await SharedPreferences.getInstance();
                          await prefs.remove('privateKey');
                          await prefs.remove('address');
                          Get.offAndToNamed('/createOrImportWallet');
                          print("로그아웃버튼 눌림");
                        },
      child:Card(elevation:10,child: Container(
        
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        decoration: BoxDecoration(
          
          color: const Color.fromARGB(255, 93, 167, 139),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          '로그아웃',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
            fontSize: 16,
            fontFamily: 'GmarketSans',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),),
    ),
    SizedBox(height:20.0),
      GestureDetector(
      onTap: () => onDeveloperInfo(context),
      child:Card(elevation:10,child: Container(
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 93, 167, 139),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          '개발자정보',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
            fontSize: 16,
            fontFamily: 'GmarketSans',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),),
    ),
      
    ],
  ),
),
        ],
      ),
    ),
  );
}


////////////////////////////////////////////////////////////////////////////


//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       onPressed: onPressed,
//       child: Text(text),
//       style: ElevatedButton.styleFrom(
//         padding: EdgeInsets.symmetric(vertical: 15, horizontal: 60),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(20),
//         ),
//         fixedSize: Size(200, 50), // 버튼의 고정된 크기를 지정합니다.
//       ),
//     );
//   }
// }

// class MyPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       // appBar: AppBar(
//       //   centerTitle: true,
//       //   title: Image.asset('assets/images/minto_icon.png', width: 180, height: 80),
//       //   backgroundColor: Color.fromARGB(200, 191, 169, 231),
//       // ),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: ListView(
//             children: [
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     '▶ 축제 방문 기록',
//                     textAlign: TextAlign.left,
//                     style: TextStyle(
//                       fontFamily: 'GmarketSans',
//                       fontWeight: FontWeight.bold,
//                       fontSize: 20,
//                     ),
//                   ),
//                   SizedBox(height: 10),
//                   GestureDetector(
//                     onTap: () {
//                       print("축제기록이 눌렸습니다");
//                     },
//                     child: Material(
//   elevation: 4, // Adjust the elevation value as per your preference
//   borderRadius: BorderRadius.circular(20),
  
//   child: Container(
//     padding: EdgeInsets.all(20),
//     decoration: BoxDecoration(
//       color: Colors.grey[200],
//       borderRadius: BorderRadius.circular(20),
//     ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             children: [
//                               Column(
//                                 children: [
//                                   Text(
//                                     '이번달 참여축제수',
//                                     textAlign: TextAlign.center,
//                                   ),
//                                   SizedBox(height: 10),
//                                   Text(
//                                     '3',
//                                     textAlign: TextAlign.center,
//                                   ),
//                                   SizedBox(height: 10),
//                                   AnimatedRadialGauge(
//                                     duration: const Duration(seconds: 1),
//                                     curve: Curves.elasticOut,
//                                     radius: 50,
//                                     value: 3,
//                                     axis: GaugeAxis(
//                                       min: 0,
//                                       max: 30,
//                                       degrees: 180,
//                                       style: const GaugeAxisStyle(
//                                         thickness: 20,
//                                         background: Color(0xFFDFE2EC),
//                                         segmentSpacing: 4,
//                                       ),
//                                       pointer: GaugePointer.needle(
//                                         width: 16,
//                                         height: 30,
//                                         borderRadius: 16,
//                                         color: Color(0xFF193663),
//                                       ),
//                                       progressBar: const GaugeProgressBar.rounded(
//                                         color: Color(0xFFB4C2F8),
//                                       ),
//                                       segments: [
//                                         const GaugeSegment(
//                                           from: 0,
//                                           to: 10,
//                                           color: Color(0xFFD9DEEB),
//                                           cornerRadius: Radius.zero,
//                                         ),
//                                         const GaugeSegment(
//                                           from: 10,
//                                           to: 20,
//                                           color: Color(0xFFD9DEEB),
//                                           cornerRadius: Radius.zero,
//                                         ),
//                                         const GaugeSegment(
//                                           from: 20,
//                                           to: 30,
//                                           color: Color(0xFFD9DEEB),
//                                           cornerRadius: Radius.zero,
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               Column(
//                                 children: [
//                                   Text(
//                                     '참여한 총 축제수',
//                                     textAlign: TextAlign.center,
//                                   ),
//                                   SizedBox(height: 10),
//                                   Text(
//                                     '45',
//                                     textAlign: TextAlign.center,
//                                   ),
//                                   SizedBox(height: 10),
//                                   AnimatedRadialGauge(
//                                     duration: const Duration(seconds: 1),
//                                     curve: Curves.elasticOut,
//                                     radius: 50,
//                                     value: 45,
//                                     axis: GaugeAxis(
//                                       min: 0,
//                                       max: 360,
//                                       degrees: 180,
//                                       style: const GaugeAxisStyle(
//                                         thickness: 20,
//                                         background: Color(0xFFDFE2EC),
//                                         segmentSpacing: 4,
//                                       ),
//                                       pointer: GaugePointer.needle(
//                                         width: 16,
//                                         height: 30,
//                                         borderRadius: 16,
//                                         color: Color(0xFF193663),
//                                       ),
//                                       progressBar: const GaugeProgressBar.rounded(
//                                         color: Color(0xFFB4C2F8),
//                                       ),
//                                       segments: [
//                                         const GaugeSegment(
//                                           from: 0,
//                                           to: 120,
//                                           color: Color(0xFFD9DEEB),
//                                           cornerRadius: Radius.zero,
//                                         ),
//                                         const GaugeSegment(
//                                           from: 120,
//                                           to: 240,
//                                           color: Color(0xFFD9DEEB),
//                                           cornerRadius: Radius.zero,
//                                         ),
//                                         const GaugeSegment(
//                                           from: 240,
//                                           to: 360,
//                                           color: Color(0xFFD9DEEB),
//                                           cornerRadius: Radius.zero,
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),),
//                   ),
//                   SizedBox(height: 20),
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       RoundedButton(
//                         text: '앱 사용법',
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(builder: (context) => IntroductionAnimationScreen()),
//                           );
//                         },
//                       ),
//                       SizedBox(height: 20),
//                       RoundedButton(
//                         text: '로그아웃하기',
//                         onPressed: () async {
//                           SharedPreferences prefs = await SharedPreferences.getInstance();
//                           await prefs.remove('privateKey');
//                           await prefs.remove('address');
//                           Get.offAndToNamed('/createOrImportWallet');
//                           print("로그아웃버튼 눌림");
//                         },
//                       ),
//                       SizedBox(height: 20),
//                       RoundedButton(
//                         text: '개발자 정보',
//                         onPressed: () => onDeveloperInfo(context),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
 // }
}

void onDeveloperInfo(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('개발자 정보'),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              Text('프론트: 박유나 \nrealyuna@cau.ac.kr'),
              Text('\n'),
              Text('백엔드: 한상구 \nhansanggu@cau.ac.kr'),
              Text('\n'),
              Text('팀리더: 이지학 \neasyhak@cau.ac.kr'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // 다이얼로그 닫기
            },
            child: Text('닫기'),
          ),
        ],
      );
    },
  );
}
