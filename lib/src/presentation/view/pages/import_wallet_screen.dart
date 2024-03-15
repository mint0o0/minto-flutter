import 'dart:developer';

import 'package:crypto/crypto.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
// import 'package:provider/provider.dart';
// import 'package:flutter_nfts/providers/wallet_provider.dart';
// import 'package:flutter_nfts/pages/wallet.dart';

import '../../../app.dart';
import '../../../controller/wallet/wallet_controller.dart';

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
      map[csvTable[0][i]] = i;
    }
    return map;
  }

  Future<bool> validateMnemonic(String mnemonic) async {
    final bip39EnglishWordList = await readCSV('assets/bip39/english.csv');
    List<String> wordList = mnemonic.split(' '); // 니모닉을 단어 리스트로 분할

    if (wordList.length % 3 != 0) {
      // 니모닉 길이 확인
      return false;
    }
    log(bip39EnglishWordList.toString());
    // 첫 번째 해시 체크섬 비트 수 계산
    int checksumBits = (wordList.length ~/ 3) ~/ 4;
    List<int> binary = [];
    for (String word in wordList) {
      int? index = bip39EnglishWordList[word];

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
    // final walletProvider = Provider.of<WalletProvider>(context, listen: false);

    // Call the getPrivateKey function from the WalletProvider
    final privateKey = await walletController.getPrivateKey(verificationText);
    Get.to(() => App());
  }

  @override
  Widget build(BuildContext context) {
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
                  print(verificationText);
                });
              },
              decoration: const InputDecoration(
                labelText: 'mnemonic phrase를 입력하세요',
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              // Todo 검증 로직 생성
              onPressed: () async {
                // var check = await validateMnemonic(verificationText);
                setState(() {
                  isVerified = true;
                });
              },
              child: Text("검증"),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: isVerified ? () => getToWalletPage() : null,
              child: const Text('입력'),
            ),
            const SizedBox(height: 24.0),
          ],
        ),
      ),
    );
  }
}
