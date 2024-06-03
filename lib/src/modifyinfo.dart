import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:minto/src/app.dart'; // App 클래스 import
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';








String? globalAccessToken;
String? globalRefreshToken;
class SignupController extends GetxController {
  SharedPreferences? prefs;
  String selectedArea = "서울";
  String selectedGender = "여자";
  //String selectedBirthday = '2000-01-01';
  int selectedBirthday = 20000101;
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
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('accesstoken', globalAccessToken.toString());
      print("39204829843029");
      //print(accessToken);
      
      //globalAccessToken = data['refreshToken'];
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
    print(selectedBirthday);
    print( selectedGender.substring(0, 1));
    var url = Uri.parse('http://3.34.98.150:8080/auth/signup');
    var response = await http.post(url, headers:{"Content-Type":"application/json"} , body: json.encode({
      "walletAddress": prefs!.getString('address') ?? '',
      "area": selectedArea,
      "age": selectedBirthday,
      "gender": selectedGender.substring(0, 1)
    }));

    if (response.statusCode == 200) {
      print("여까진 옴2");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("회원가입 성공"),
          backgroundColor: Color.fromARGB(255, 93, 167, 139),
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
 //String _selectedDate = '2000-01-01'; 
 void _showKeywordDialog(BuildContext context) async {
  List<String> keywords = [
    "지역축제",
    "음악축제",
    "대학축제",
    "전시회",
    "군대행사",
    "게임행사",
    "영화제",
    "종교축제",
  ];
  List<String> selectedKeywords = [];

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Text("관심있는 축제키워드 4개를 선택하세요!"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: keywords.map((keyword) {
                return CheckboxListTile(
                  title: Text(keyword),
                  value: selectedKeywords.contains(keyword),
                  onChanged: (bool? value) {
                    if (value == true && selectedKeywords.length < 4) {
                      setState(() {
                        selectedKeywords.add(keyword);
                      });
                    } else if (value == false) {
                      setState(() {
                        selectedKeywords.remove(keyword);
                      });
                    }
                  },
                );
              }).toList(),
            ),
            actions: [
              if (selectedKeywords.length == 4)
                TextButton(
                  onPressed: () async {
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    await prefs.setStringList('mycategory', selectedKeywords);
                    Navigator.of(context).pop();
                  },
                  child: Text('확인'),
                ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('취소'),
              ),
            ],
          );
        },
      );
    },
  );
}

 int _selectedDate = 20000101;
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.7,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 93, 167, 139),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      '축제를 시작할\n마지막 단계에요!',
                      style: TextStyle(
                        fontSize: 30.0,
                        color: Colors.white,
                        fontFamily: 'GmarketSans',
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  SizedBox(height: 24.0),
                  Row(
                    children: [
                      Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text("지역", style: TextStyle(
                                color: Colors.white, // Text color
                                fontSize: 18.0, // Font size
                              ),),
                          ), Padding(
  padding: const EdgeInsets.all(16.0), // You can adjust the padding values as needed
  child: DropdownButton<String>(
    value: _signupController.selectedArea,
    onChanged: (String? newValue) {
      if (newValue != null) {
        setState(() {
          _signupController.selectedArea = newValue;
        });
      }
    },
    items: _signupController.areas
        .map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value, style: TextStyle(
          color: Colors.white, // Text color
          fontSize: 18.0, // Font size
        ),),
      );
    }).toList(),
  ),
),
                    ],
                  ),
                
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text("성별", style: TextStyle(
                                color: Colors.white, // Text color
                                fontSize: 18.0, // Font size
                              ),),
                          ), Padding(
  padding: const EdgeInsets.all(16.0), // 16 logical pixels of padding on all sides
  child: DropdownButton<String>(
    value: _signupController.selectedGender,
    onChanged: (String? newValue) {
      if (newValue != null) {
        setState(() {
          _signupController.selectedGender = newValue;
        });
      }
    },
    items: _signupController.genders
        .map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value, style: TextStyle(
          color: Colors.white, // Text color
          fontSize: 18.0, // Font size
        ),),
      );
    }).toList(),
  ),
),
                    ],
                  ),
                 
                  SizedBox(height: 10),
                  Padding(
  padding: const EdgeInsets.all(16.0), // 16 logical pixels of padding on all sides
  child: GestureDetector(
    onTap: () async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime(2000),
        firstDate: DateTime(1900),
        lastDate: DateTime.now(),
      );
      if (picked != null) {
        setState(() {
          _selectedDate = picked.year * 10000 + picked.month * 100 + picked.day;
          _signupController.selectedBirthday = _selectedDate;
        });
      }
    },
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          '생년월일 선택',
           style: TextStyle(
          color: Colors.white, // Text color
          fontSize: 18.0, // Font size
        ),
        ),
        Text(
          _selectedDate.toString(),
           style: TextStyle(
          color: Colors.white, // Text color
          fontSize: 18.0, // Font size
        ),
        ),
      ],
    ),
  ),
)
, SizedBox(height: 15),
Row(
  children: [
    Text("키워드 선택:"),ElevatedButton(
  onPressed: () {
    _showKeywordDialog(context);
  },
  child: Text('✅'),
),
  ],
),
                  SizedBox(height: 25),
                  Padding(
  padding: const EdgeInsets.symmetric(horizontal: 64.0), // 16 logical pixels of padding on all sides
  child: GestureDetector(
    onTap: () {
      _signupController.signup(context);
    },
    child: Container(
      // margin: EdgeInsets.symmetric(horizontal: 64.0),
      padding: const EdgeInsets.all(16.0), // 16 logical pixels of padding inside the container
      decoration: BoxDecoration(
        color: Colors.blue, // Background color of the container
        borderRadius: BorderRadius.circular(8.0), // Rounded corners
      ),
      child: Center(
        child: Text(
          '회원가입',
          style: TextStyle(
            color: Colors.white, // Text color
            fontSize: 18.0, // Font size
          ),
        ),
      ),
    ),
  ),
)


                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              padding: EdgeInsets.symmetric(horizontal: 24.0,vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            contentPadding: EdgeInsets.zero,
                            content: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Image.asset('assets/images/stat_3d_icon.png'),
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text(
                                      '사용자 여러분에게 축제를 추천해주는\n 통계에 쓰입니다!',
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: Text(
                      '(?) 이 정보를 왜 수집하나요?',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontFamily: 'GmarketSans',
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );


  }
}

void main() {
  runApp(Signingup());
}
