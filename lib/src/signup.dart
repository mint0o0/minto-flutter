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
