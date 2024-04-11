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