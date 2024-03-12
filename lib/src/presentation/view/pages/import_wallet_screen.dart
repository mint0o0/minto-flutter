import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:provider/provider.dart';
// import 'package:flutter_nfts/providers/wallet_provider.dart';
// import 'package:flutter_nfts/pages/wallet.dart';
import 'package:minto/src/presentation/view/pages/wallet_screen.dart';

import '../../../controller/wallet/wallet_controller.dart';

class ImportWallet extends StatefulWidget {
  const ImportWallet({Key? key}) : super(key: key);

  @override
  _ImportWalletState createState() => _ImportWalletState();
}

class _ImportWalletState extends State<ImportWallet> {
  bool isVerified = false;
  String verificationText = '';

  void navigateToWalletPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => WalletPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    void verifyMnemonic() async {
      final walletController = Get.put(WalletController());
      // final walletProvider = Provider.of<WalletProvider>(context, listen: false);

      // Call the getPrivateKey function from the WalletProvider
      final privateKey = await walletController.getPrivateKey(verificationText);

      // Navigate to the WalletPage
      navigateToWalletPage();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Import from Seed'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              '지갑의 mnemonic phrase를 입력하세요',
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
                labelText: 'mnemonic phrase를 입력하세요',
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {},
              child: Text("검증"),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: verifyMnemonic,
              child: const Text('입력'),
            ),
            const SizedBox(height: 24.0),
          ],
        ),
      ),
    );
  }
}
