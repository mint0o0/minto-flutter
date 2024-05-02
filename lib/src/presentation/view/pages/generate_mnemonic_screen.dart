import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:minto/src/presentation/view/pages/verify_mnemonic_screen.dart';

import '../../../controller/wallet/wallet_controller.dart';

class GenerateMnemonicPage extends StatelessWidget {
  const GenerateMnemonicPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final walletController = Get.put(WalletController());
    final mnemonic = walletController.generateMnemonic();
    final mnemonicWords = mnemonic.split(' ');

    void copyToClipboard() {
      Clipboard.setData(ClipboardData(text: mnemonic));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Mnemonic Copied to Clipboard'),
        ),
      );
      Get.to(
        () => VerifyMnemonicPage(mnemonic: mnemonic),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '니모닉 키 생성',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '니모닉 키는 안전하게 보관하세요',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                mnemonicWords.length,
                (index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Text(
                    '${mnemonicWords[index]}',
                    style: const TextStyle(fontSize: 16.0),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24.0),
            ElevatedButton.icon(
              onPressed: () {
                copyToClipboard();
              },
              icon: const Icon(Icons.copy),
              label: const Text('클립보드에 복사'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                textStyle: const TextStyle(fontSize: 20.0),
                elevation: 4,
                shadowColor: Colors.black.withOpacity(0.4),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
