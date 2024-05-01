import 'dart:developer';

import 'package:crypto/crypto.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../app.dart';
import '../../../controller/wallet/wallet_controller.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:minto/src/signup.dart';

String? globalAccessToken;
String? globalRefreshToken;

class ImportWallet extends StatefulWidget {
  const ImportWallet({Key? key}) : super(key: key);

  @override
  _ImportWalletState createState() => _ImportWalletState();
}

class _ImportWalletState extends State<ImportWallet> {
  bool isVerified = false;
  String verificationText = '';

  void verifyMnemonic(String mnemonic) {
    final walletController = Get.put(WalletController());
    print(mnemonic);

    if (verificationText.trim() == mnemonic.trim()) {
      walletController.getPrivateKey(mnemonic).then((privateKey) {
        print(privateKey);
        setState(() {
          isVerified = true;
        });
      });
    }
  }

  Future<Map<String, int>> readCSV(String path) async {
    // CSV 파일을 로드
    final String rawCSV = await rootBundle.loadString(path);

    // CSV 파일을 파싱하여 리스트로 변환
    List<List<dynamic>> csvTable = const CsvToListConverter().convert(rawCSV);
    Map<String, int> map = {};
    for (int i = 0; i < csvTable[0].length; i++) {
      map[csvTable[0][i].trim()] = i;
    }
    return map;
  }

  Future<bool> validateMnemonic(String mnemonic) async {
    // print("Mnemonic Validation Button clicked");
    final bip39EnglishWordList = await readCSV('assets/bip39/english.csv');
    List<String> wordList = mnemonic.split(' '); // 니모닉을 단어 리스트로 분할

    if (wordList.length % 3 != 0) {
      // 니모닉 길이 확인
      return false;
    }
    // log(bip39EnglishWordList.toString());
    // 첫 번째 해시 체크섬 비트 수 계산
    int checksumBits = (wordList.length ~/ 3) ~/ 4;
    List<int> binary = [];
    for (String word in wordList) {
      int? index = bip39EnglishWordList[word];

      print('index: $index');
      if (index == null) {
        // 잘못된 단어가 있는 경우
        print("여기서 잘못됨");
        print(word);
        return false;
      }
      String binaryStr = index.toRadixString(2).padLeft(11, '0');
      for (int i = 0; i < binaryStr.length; i++) {
        binary.add(int.parse(binaryStr[i]));
      }
    }

    // 이진 문자열의 첫 부분에 대한 해시 체크섬 생성
    List<int> checksum =
        sha256.convert(binary.sublist(0, (binary.length ~/ 33 * 32))).bytes;

    // 해시 체크섬과 비교
    for (int i = 0; i < checksumBits; i++) {
      if (checksum[i] != binary[binary.length - checksumBits + i]) {
        return false;
      }
    }

    return true;
  }

  Future<void> getToWalletPage() async {
    final walletController = Get.put(WalletController());
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final privateKey = await walletController.getPrivateKey(verificationText);
    await prefs.setString('privateKey', privateKey);
    var address = await walletController.getPublicKey(privateKey);
    await prefs.setString('address', address.toString());

    // Send HTTP request to check if the address exists
    final response = await http
        .get(Uri.parse('http://3.34.98.150:8080/auth/exist/$address'));

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      final exists = responseBody as bool;
      if (exists) {
        // If the address exists, attempt login
        var url = Uri.parse('http://3.34.98.150:8080/auth/login');
        var loginResponse = await http.post(url,
            headers: {"Content-Type": "application/json"},
            body: json.encode({
              "walletAddress": prefs!.getString('address') ?? '',
            }));

        if (loginResponse.statusCode == 200) {
          final loginResponseBody = json.decode(loginResponse.body);
          globalAccessToken = loginResponseBody['accessToken'];
          globalRefreshToken = loginResponseBody['refreshToken'];
          print("아양어어어어엉");
          print(globalAccessToken);
          print(globalRefreshToken);
          // Move to the App page after successful login
          Get.to(() => App());
        } else {
          print('Failed to login: ${loginResponse.statusCode}');
          // Handle login failure
        }
      } else {
        Get.to(() => Signingup());
      }
    } else {
      // Handle error when the server returns an error response
      print('Failed to check address existence: ${response.statusCode}');
      // Redirect to a suitable error page or display an error message
    }
  }

 @override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.white,
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
        color: Colors.grey.withOpacity(0.5), // 그림자 색상과 투명도 설정
        spreadRadius: 5, // 그림자 확산 범위
        blurRadius: 7, // 그림자 흐림 정도
        offset: Offset(0, 3), // 그림자 위치 조절 (가로, 세로)
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
                    '추억을 담을 지갑으로\n로그인해보세요!',
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
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16.0),
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(71, 255, 255, 255),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: '지갑의 key를 입력하세요',
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
               Container(
  margin: EdgeInsets.symmetric(horizontal: 64.0),
  padding: EdgeInsets.symmetric(horizontal: 64.0),
  decoration: BoxDecoration(
    color: Colors.blue, // 버튼의 배경색을 파란색으로 설정
    borderRadius: BorderRadius.circular(10.0),
  ),
  child: InkWell(
    onTap: () async {
      var check = await validateMnemonic(verificationText);
      print('-----------------');
      print(check);
      setState(() {
        isVerified = true;
      });
    },
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 12.0),
      child: Center(
        child: Text(
          "검증",
          style: TextStyle(
            fontFamily: 'GmarketSans',
            color: Colors.white, // 버튼의 텍스트 색상을 흰색으로 설정
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  ),
),

                SizedBox(height: 16.0),
                Container(
  margin: EdgeInsets.symmetric(horizontal: 64.0),
  padding: EdgeInsets.symmetric(horizontal: 64.0),
  decoration: BoxDecoration(
    color: isVerified ? Colors.blue : Colors.grey, // 버튼의 배경색을 조건에 따라 파란색 또는 회색으로 설정
    borderRadius: BorderRadius.circular(10.0),
  ),
  child: InkWell(
    onTap: isVerified ? () => getToWalletPage() : null,
    borderRadius: BorderRadius.circular(10.0),
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 12.0),
      child: Center(
        child: Text(
          "입력",
          style: TextStyle(
            fontFamily: 'GmarketSans',
            color: Colors.white, // 버튼의 텍스트 색상을 흰색으로 설정
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  ),
),

                SizedBox(height: 24.0),
              ],
            ),
          ),Container(
  height: MediaQuery.of(context).size.height * 0.3, // 초록색 컨테이너 아래 공간의 높이 조정
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
                      Image.asset('assets/images/key_3d_icon.webp'),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          '전자지갑의 로그인 방식으로 니모닉을 이용합니다.\n이것은 임의의 단어의 조합으로 지갑의 열쇠가 됩니다.',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Image.asset('assets/images/help2.png'),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'mnemonic이 없다면 전페이지로 돌아가서 지갑생성을 눌러주세요!\n저희가 버튼 하나로 발급해드립니다!',
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
          '(?) 지갑의 key를 모르시나요?',
          textAlign: TextAlign.left,
          style: TextStyle(
            fontFamily: 'GmarketSans',
            color: Colors.blue,
            //decoration: TextDecoration.underline,
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