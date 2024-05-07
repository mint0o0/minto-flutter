import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:minto/src/components/address_info.dart';
import 'package:minto/src/app.dart'; // App 클래스 import
import 'package:minto/src/presentation/view/pages/import_wallet_screen.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
String? globalAccessToken;
String? globalRefreshToken;
class SignupController extends GetxController {
  SharedPreferences? prefs;
  String selectedArea = "서울";
  String selectedGender = "여자";
  int selectedAge = 20;
  late String accessToken;
  late String refreshToken;
  List<String> areas = [
    "서울", "부산", "대구", "인천", "광주", "대전", "울산", "세종",
    "경기", "충북", "충남", "경북", "경남", "전남", "전북", "강원", "제주"
  ];

  List<String> genders = ["여자", "남자"];
  void login(BuildContext context) async {
    print("dddddd");
    prefs = await SharedPreferences.getInstance();
    print(prefs!.getString('address') ?? '');
    var url = Uri.parse('http://3.34.98.150:8080/auth/login');
    var response = await http.post(url, headers:{"Content-Type":"application/json"} ,body: json.encode({
      "walletAddress": prefs!.getString('address') ?? '',
    }));

    if (response.statusCode == 200) {
      print("로그인까진 성공한듯");
      var data = jsonDecode(response.body);
      globalAccessToken = data['accessToken'];
      print("39204829843029");
      //print(accessToken);
      
      globalAccessToken = data['refreshToken'];
      //print(refreshToken);
      print("39204829843029");
      // 성공하면 App으로 이동
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => App()),
      );
    } else {
      print('로그인 실패');
    }
  }
  void signup(BuildContext context) async {
     prefs = await SharedPreferences.getInstance();
    print("여까진 옴1");
    print(prefs!.getString('address') ?? '');
    print(selectedArea);
    print(selectedAge.toString());
    print( selectedGender.substring(0, 1));
    var url = Uri.parse('http://3.34.98.150:8080/auth/signup');
    var response = await http.post(url, headers:{"Content-Type":"application/json"} , body: json.encode({
      "walletAddress": prefs!.getString('address') ?? '',
      "area": selectedArea,
      "age": selectedAge.toString(),
      "gender": selectedGender.substring(0, 1)
    }));

    if (response.statusCode == 200) {
      print("여까진 옴2");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("회원가입 성공"),
          backgroundColor: Colors.green,
        ),
      );
      login(context);

    } 
    
    else {
      print("여까진 옴3");
      print("오류: ${response.statusCode}");
    print("오류 메시지: ${response.body}");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("회원가입 실패"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}

class Signingup extends StatefulWidget {
  @override
  _SigningupState createState() => _SigningupState();
}

class _SigningupState extends State<Signingup> {
  SignupController _signupController = SignupController();

  @override
  Widget build(BuildContext context) {
//     return Scaffold(
//     //backgroundColor: Colors.white,
//     body: SafeArea(
//       child: ListView(
        
//         children: [
//           Container(
//             height: MediaQuery.of(context).size.height * 0.7,
//             decoration: BoxDecoration(
//     color: Color.fromARGB(255, 93, 167, 139),
//     borderRadius: BorderRadius.only(
//       bottomLeft: Radius.circular(20.0),
//       bottomRight: Radius.circular(20.0),
//     ),
//     boxShadow: [
//       BoxShadow(
//         color: Colors.grey.withOpacity(0.5), // 그림자 색상과 투명도 설정
//         spreadRadius: 5, // 그림자 확산 범위
//         blurRadius: 7, // 그림자 흐림 정도
//         offset: Offset(0, 3), // 그림자 위치 조절 (가로, 세로)
//       ),
//     ],
//   ),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                   child: Text(
//                     '축제를 시작할\n마지막 단계에요!',
//                     style: TextStyle(
//                       fontSize: 30.0,
//                       color: Colors.white,
//                       fontFamily: 'GmarketSans',
//                       fontWeight: FontWeight.bold,
//                     ),
//                     textAlign: TextAlign.left,
//                   ),
//                 ),
//                 SizedBox(height: 24.0),
//                 Text("지역"),
//               DropdownButton<String>(
//                 value: _signupController.selectedArea,
//                 onChanged: (String? newValue) {
//                   if(newValue != null) {
//                     setState(() {
//                       _signupController.selectedArea = newValue;
//                     });
//                   }
//                 },
//                 items: _signupController.areas
//                     .map<DropdownMenuItem<String>>((String value) {
//                   return DropdownMenuItem<String>(
//                     value: value,
//                     child: Text(value),
//                   );
//                 }).toList(),
//               ),
//               SizedBox(height: 10),
//               Text("성별"),
//               DropdownButton<String>(
//                 value: _signupController.selectedGender,
//                 onChanged: (String? newValue) {
//                   if(newValue != null) {
//                     setState(() {
//                       _signupController.selectedGender = newValue;
//                     });
//                   }
//                 },
//                 items: _signupController.genders
//                     .map<DropdownMenuItem<String>>((String value) {
//                   return DropdownMenuItem<String>(
//                     value: value,
//                     child: Text(value),
//                   );
//                 }).toList(),
//               ),
//               SizedBox(height: 10),
//               Text("나이"),
//               Slider(
//                 value: _signupController.selectedAge.toDouble(),
//                 min: 1,
//                 max: 100,
//                 divisions: 99,
//                 label: _signupController.selectedAge.toString(),
//                 onChanged: (double value) {
//                   setState(() {
//                     _signupController.selectedAge = value.toInt();
//                   });
//                 },
//               ),
              
//               ElevatedButton(
//                 onPressed: () {
//                   _signupController.signup(context);
//                 },
//                 child: Text('회원가입'),
//               ),
                
                
//               ],
//             ),
//           ),Container(
//   height: MediaQuery.of(context).size.height * 0.3, // 초록색 컨테이너 아래 공간의 높이 조정
//   padding: EdgeInsets.symmetric(horizontal: 24.0,vertical: 16.0),
//   child: Column(
//     crossAxisAlignment: CrossAxisAlignment.stretch,
//     children: [
//       GestureDetector(
//         onTap: () {
//           showDialog(
//             context: context,
//             builder: (BuildContext context) {
//               return AlertDialog(
//                 contentPadding: EdgeInsets.zero,
//                 content: SingleChildScrollView(
//                   child: Column(
//                     children: [
//                       Image.asset('assets/images/stat_3d_icon.png'),
//                       Padding(
//                         padding: const EdgeInsets.all(16.0),
//                         child: Text(
//                           '사용자여러분에게 축제를 추천해주는 통계에 쓰입니다!',
//                           textAlign: TextAlign.center,
//                         ),
//                       ),
                     
//                     ],
//                   ),
//                 ),
//               );
//             },
//           );
//         },
        
//         child: Text(
//           '(?) 이 정보를 왜 수집하나요?',
//           textAlign: TextAlign.left,
//           style: TextStyle(
//             fontFamily: 'GmarketSans',
//             color: Colors.blue,
//             //decoration: TextDecoration.underline,
//           ),
//         ),
//       ),
//     ],
//   ),
// ),
//         ],
//       ),
//     ),
//   );
// }
    ///////////////////////////////////////////////////////////////
    ///
    ///
    ///
    return Scaffold(
      appBar: AppBar(
        title: Text('회원정보등록'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text("지역"),
              DropdownButton<String>(
                value: _signupController.selectedArea,
                onChanged: (String? newValue) {
                  if(newValue != null) {
                    setState(() {
                      _signupController.selectedArea = newValue;
                    });
                  }
                },
                items: _signupController.areas
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              Text("성별"),
              DropdownButton<String>(
                value: _signupController.selectedGender,
                onChanged: (String? newValue) {
                  if(newValue != null) {
                    setState(() {
                      _signupController.selectedGender = newValue;
                    });
                  }
                },
                items: _signupController.genders
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              Text("나이"),
              Slider(
                value: _signupController.selectedAge.toDouble(),
                min: 1,
                max: 100,
                divisions: 99,
                label: _signupController.selectedAge.toString(),
                onChanged: (double value) {
                  setState(() {
                    _signupController.selectedAge = value.toInt();
                  });
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _signupController.signup(context);
                },
                child: Text('회원가입'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(Signingup());
}
