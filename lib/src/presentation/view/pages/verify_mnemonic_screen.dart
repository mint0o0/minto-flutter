import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minto/src/presentation/view/pages/wallet_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../controller/wallet/wallet_controller.dart';

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
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => WalletPage()),
      );
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
              onPressed: () {
                verifyMnemonic();
              },
              child: const Text('Verify'),
            ),
            const SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: isVerified
                  ? () async {
                      navigateToWalletPage();
                      final SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      // 'isLoggedIn' 키에 대해 true 값을 저장하여 사용자가 로그인했음을 표시합니다.
                      final walletController = Get.put(WalletController());
                      var privateKey =
                          await walletController.getPrivateKey(widget.mnemonic);

                      await prefs.setString('privateKey', privateKey);
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
              ),
              child: const Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}