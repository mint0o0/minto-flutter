import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minto/src/utils/func.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'controller/contract/contract_controller.dart';
import 'controller/wallet/wallet_controller.dart';

import 'dart:convert' show json;

import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart' show rootBundle;

class NftPage3 extends StatefulWidget {
  const NftPage3({Key? key});

  @override
  State<NftPage3> createState() => _NftPage3State();
}

class _NftPage3State extends State<NftPage3> with Func {
  String walletAddress = '';
  String pvKey = '';
  String contractAddress = '';
  final NftController _nftController = Get.put(NftController());
  final WalletController _walletController = Get.put(WalletController());
  var nftStructList = [];

  @override
  void initState() {
    super.initState();
    loadSharedPreferences();
    //loadWalletData();
    loadContractAddress();

    _nftController.getMyNfts(walletAddress);
    print(_nftController.nftStructList);

    setState(() {
      nftStructList = _nftController.nftStructList;
    });
    _nftController.getMyNfts(walletAddress);
  }

  Future<void> loadSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      walletAddress = prefs.getString('address') ?? '';
      pvKey = prefs.getString('privateKey') ?? '';
    });
  }

  Future<void> loadContractAddress() async {
    String jsonContent = await rootBundle.loadString('assets/json/MyNFT.json');
    Map<String, dynamic> jsonData = json.decode(jsonContent);
    String address_c = jsonData['networks']['11155111']['address'];
    print("adrerss 확인");
    print("address: $address_c");
    setState(() {
      contractAddress = address_c; // contract 주소 저장
    });
  }

  Map<String, dynamic> createTokenUri(
      Map<String, dynamic> imageInfo, String tokenId) {
    Map<String, dynamic> map = {
      "description":
          "Friendly OpenSea Creature that enjoys long swims in the ocean.",
      "external_url":
          "https://testnets.opensea.io/assets/sepolia/$contractAddress/$tokenId",
      "image":
          "https://storage.googleapis.com/opensea-prod.appspot.com/puffs/3.png",
      "name": "Dave Starbelly",
    };
    return map;
  }

  void _showImageInfoDialog(Map<String, dynamic> imageInfo) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(imageInfo['title']),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(imageInfo['image']),
              SizedBox(height: 8),
              Text(
                'Description: ${imageInfo['description']}',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 8),
              GestureDetector(
                // 주소를 누를 때의 제스처 추가
                onTap: () {
                  _launchInBrowser(createTokenUri(
                      imageInfo, imageInfo['tokenId'])['external_url']);
                },
                child: Text(
                  // 주소를 보여줄 텍스트 위젯
                  'External URL: ${createTokenUri(imageInfo, imageInfo['tokenId'])['external_url']}',
                  style: TextStyle(fontSize: 16, color: Colors.blue),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _launchInBrowser(String url) async {
    if (!await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.0), // 왼쪽 둥근 모서리
            bottomRight: Radius.circular(20.0), // 오른쪽 둥근 모서리
          ),
        ),
        backgroundColor: Color.fromARGB(255, 93, 167, 139),
        title: Text("내 NFT 수집장",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () async {
              //_nftController.getMyNfts(walletAddress);
              print("새로고침아이콘 방금 누름 그리고 바로밑에 _nftController.nftStructList실행함");
              print(_nftController.nftStructList);
              print(
                  "이제 바로밑에 nftStructList = _nftController.nftStructList;실행함 ");
              setState(() {
                nftStructList = _nftController.nftStructList;
              });
              print("이제 바로 밑에 _nftController.getMyNfts(walletAddress);수행함");
              _nftController.getMyNfts(walletAddress);
              print("새로고침 버튼 동작 끝남");
            },
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 0.7, // 이미지 비율을 조정해야 합니다.
        padding: EdgeInsets.all(4.0),
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
        children: List.generate(nftStructList.length, (index) {
          return GestureDetector(
            onTap: () {
              _showImageInfoDialog(nftStructList[index]);
            },
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              color: Colors.white,
              margin: EdgeInsets.zero, // 여백 없애기
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: ClipRRect(
                      // 이미지가 카드를 넘어가는 것을 방지하기 위해 ClipRRect로 감싸줍니다.
                      borderRadius: BorderRadius.vertical(
                          top: Radius.circular(8.0)), // 카드의 윗부분만 둥글게
                      child: Image.network(
                        nftStructList[index]['image'],
                        fit: BoxFit.cover, // 이미지가 카드에 꽉 차게 보이도록 설정
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          nftStructList[index]['title'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          nftStructList[index]['description'],
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
