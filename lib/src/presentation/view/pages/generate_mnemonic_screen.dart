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
                     '저희가 방금 전자지갑을 생성해 드렸어요!',
                    style: TextStyle(
                      fontSize: 30.0,
                      color: Colors.white,
                      fontFamily: 'GmarketSans',
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(height: 16.0),
                Column(
  crossAxisAlignment: CrossAxisAlignment.stretch,
  mainAxisAlignment: MainAxisAlignment.center,
  children: List.generate(
    (mnemonicWords.length / 2).ceil(), // 한 가로에 두 개씩 표시하도록 수정
    (index) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            '${mnemonicWords[index * 2]}',
            style: const TextStyle(fontSize: 16.0),
            textAlign: TextAlign.center,
          ),
          if (index * 2 + 1 < mnemonicWords.length) // 리스트 범위를 초과하지 않도록 조건 추가
            Text(
              '${mnemonicWords[index * 2 + 1]}',
              style: const TextStyle(fontSize: 16.0),
              textAlign: TextAlign.center,
            ),
        ],
      ),
    ),
  ),
),

                SizedBox(height: 16.0),
              Container(
  padding: const EdgeInsets.all(16.0), // 버튼에 패딩 추가
  width: double.infinity,
  child: ElevatedButton.icon(
    onPressed: () {
      copyToClipboard();
    },
    icon: const Icon(Icons.copy),
    label: const Text('클립보드에 복사'),
    style: ElevatedButton.styleFrom(
      padding: EdgeInsets.zero, // 버튼 내부의 패딩을 0으로 설정
      textStyle: const TextStyle(fontSize: 20.0),
      elevation: 4,
      shadowColor: Colors.black.withOpacity(0.4),
    ),
  ),
),
            //     ElevatedButton.icon(
            //   onPressed: () {
            //     copyToClipboard();
            //   },
            //   icon: const Icon(Icons.copy),
            //   label: const Text('클립보드에 복사'),
            //   style: ElevatedButton.styleFrom(
            //     padding: const EdgeInsets.symmetric(horizontal: 16.0),
            //     textStyle: const TextStyle(fontSize: 20.0),
            //     elevation: 4,
            //     shadowColor: Colors.black.withOpacity(0.4),
                
            //   ), 
            // ),
                SizedBox(height:16.0),
              
            

                // SizedBox(height: 24.0),
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








/////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////




















  // @override
  // Widget build(BuildContext context) {
  //   final walletController = Get.put(WalletController());
  //   final mnemonic = walletController.generateMnemonic();
  //   final mnemonicWords = mnemonic.split(' ');

  //   void copyToClipboard() {
  //     Clipboard.setData(ClipboardData(text: mnemonic));
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         content: Text('Mnemonic Copied to Clipboard'),
  //       ),
  //     );
  //     Get.to(
  //       () => VerifyMnemonicPage(mnemonic: mnemonic),
  //     );
  //   }

  //   return Scaffold(
  //     appBar: AppBar(
  //       title: const Text(
  //         '니모닉 키 생성',
  //         style: TextStyle(fontWeight: FontWeight.bold),
  //       ),
  //     ),
  //     body: Padding(
  //       padding: const EdgeInsets.all(16.0),
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           const Text(
  //             '저희가 방금 전자지갑을 생성해 드렸어요!\n니모닉 키는 안전하게 보관하세요',
  //             style: TextStyle(
  //               fontSize: 18.0,
  //               fontWeight: FontWeight.bold,
  //             ),
  //           ),
  //           const SizedBox(height: 16.0),
  //           Column(
  //             crossAxisAlignment: CrossAxisAlignment.stretch,
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: List.generate(
  //               mnemonicWords.length,
  //               (index) => Padding(
  //                 padding: const EdgeInsets.symmetric(vertical: 4.0),
  //                 child: Text(
  //                   '${mnemonicWords[index]}',
  //                   style: const TextStyle(fontSize: 16.0),
  //                   textAlign: TextAlign.center,
  //                 ),
  //               ),
  //             ),
  //           ),
  //           const SizedBox(height: 16.0),
  //           ElevatedButton.icon(
  //             onPressed: () {
  //               copyToClipboard();
  //             },
  //             icon: const Icon(Icons.copy),
  //             label: const Text('클립보드에 복사'),
  //             style: ElevatedButton.styleFrom(
  //               padding: const EdgeInsets.symmetric(vertical: 24.0),
  //               textStyle: const TextStyle(fontSize: 20.0),
  //               elevation: 4,
  //               shadowColor: Colors.black.withOpacity(0.4),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
