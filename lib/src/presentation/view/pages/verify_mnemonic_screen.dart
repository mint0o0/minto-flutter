 import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minto/src/app.dart';
import 'package:minto/src/presentation/view/pages/wallet_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../controller/wallet/wallet_controller.dart';
import 'package:minto/src/signup.dart';
//새로 전자지갑 만들었을때 로그인하는곳

class VerifyMnemonicPage extends StatefulWidget {
  final String mnemonic;

  const VerifyMnemonicPage({Key? key, required this.mnemonic})
      : super(key: key);

  @override
  _VerifyMnemonicPageState createState() => _VerifyMnemonicPageState();
}

class _VerifyMnemonicPageState extends State<VerifyMnemonicPage> {
  bool isVerified = false;
  String verificationText = '';

  void verifyMnemonic() {
    final walletController = Get.put(WalletController());
    print(widget.mnemonic);

    if (verificationText.trim() == widget.mnemonic.trim()) {
      walletController.getPrivateKey(widget.mnemonic).then((privateKey) {
        print(privateKey);
        setState(() {
          isVerified = true;
        });
      });
    }
  }
/** 
  @override
  Widget build(BuildContext context) {
    void navigateToWalletPage() {
      //Get.to(App());
      Get.to(Signingup());
      //Navigator.push(
        //context,
        //MaterialPageRoute(builder: (context) => App()),
        //MaterialPageRoute(builder: (context) => SigningUp()),
      //);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify Mnemonic and Create'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Please verify your mnemonic phrase:',
              style: TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 24.0),
            TextField(
              onChanged: (value) {
                setState(() {
                  verificationText = value;
                });
              },
              decoration: const InputDecoration(
                labelText: 'Enter mnemonic phrase',
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
  onPressed: verifyMnemonic,
  child: const Text('Verify'),
),
//
            //ElevatedButton(
              //onPressed: () {
                //verifyMnemonic();
              //},
              //child: const Text('Verify'),
            //),
            const SizedBox(height: 24.0),
            ElevatedButton(
  onPressed: isVerified ? () async {
    navigateToWalletPage();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final walletController = Get.put(WalletController());
    var privateKey = await walletController.getPrivateKey(widget.mnemonic);

    await prefs.setString('privateKey', privateKey);
    var address = await walletController.getPublicKey(privateKey);
    await prefs.setString('address', address.toString());
    print("111111111111111111111111111111111111111111111111111");
    print(address);
    print("1111111111111111111111111111111111111111111111111111111");

    //Get.put(SignupController());
    //Get.to(Signingup());
  } : null,
  child: const Text('Next'),
),
          ],
        ),
      ),
    );
  }
}
**/
@override
/////////////////////////////////////////////////////
Widget build(BuildContext context) {
  void navigateToWalletPage() {
      //Get.to(App());
      Get.to(Signingup());
      //Navigator.push(
        //context,
        //MaterialPageRoute(builder: (context) => App()),
        //MaterialPageRoute(builder: (context) => SigningUp()),
      //);
    }
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
    onTap: verifyMnemonic,
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
    onTap: () async {
      navigateToWalletPage();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final walletController = Get.put(WalletController());
    var privateKey = await walletController.getPrivateKey(widget.mnemonic);

    await prefs.setString('privateKey', privateKey);
    var address = await walletController.getPublicKey(privateKey);
    await prefs.setString('address', address.toString());
    print("111111111111111111111111111111111111111111111111111");
    print(address);
    },
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
                          '방금 저희가 발급해 드렸어요!\n입력바를 길게 눌러서 붙여넣기 해보세요!',
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
}}