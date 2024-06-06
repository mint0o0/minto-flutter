import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
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

class _NftPage3State extends State<NftPage3> {
  String walletAddress = '';
  String pvKey = '';
  String contractAddress = '';
  final NftController _nftController = Get.put(NftController());
  var nftStructList = [];
  bool isLoading = true; // 추가: 로딩 상태

  @override
  void initState() {
    super.initState();
    loadSharedPreferences();
    loadContractAddress();
    loadData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    loadData();
  }

  Future<void> loadData() async {
    setState(() {
      isLoading = true; // 추가: 로딩 시작
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      walletAddress = prefs.getString('address') ?? '';
      pvKey = prefs.getString('privateKey') ?? '';
    });

    String jsonContent = await rootBundle.loadString('assets/json/MyNFT.json');
    Map<String, dynamic> jsonData = json.decode(jsonContent);
    String address_c = jsonData['networks']['11155111']['address'];
    print("address: $address_c");
    setState(() {
      contractAddress = address_c; // contract 주소 저장
    });

    await _nftController.getMyNfts(walletAddress);
    setState(() {
      nftStructList = _nftController.nftStructList;
      isLoading = false; // 추가: 로딩 완료
    });
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
        elevation: 4,
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
          ),
        ),
        backgroundColor: Color.fromARGB(255, 93, 167, 139),
        title: Text(
          "🖼️ 내 NFT 수집장",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () async {
              setState(() {
                isLoading = true;
              });

              await _nftController.getMyNfts(walletAddress);
              setState(() {
                nftStructList = _nftController.nftStructList;
                isLoading = false;
              });
            },
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : nftStructList.isEmpty // Check if the user doesn't have any NFTs
              ? Center(
                  child: Image.asset(
                    'assets/images/tung.png',
                    width: 200, // Adjust width as needed
                    height: 200, // Adjust height as needed
                  ),
                )
              : GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: 0.6,
                  padding: EdgeInsets.all(16.0),
                  mainAxisSpacing: 16.0,
                  crossAxisSpacing: 16.0,
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
                        margin: EdgeInsets.zero,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(8.0),
                                  bottom: Radius.circular(8.0),
                                ),
                                child: SizedBox(
                                  height: 200,
                                  child: Image.network(
                                    nftStructList[index]['image'],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    nftStructList[index]['title'],
                                    style: TextStyle(
                                                                fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),),
                                  SizedBox(height: 4),
                                  Text(
                                    nftStructList[index]['description'],
                                    style: TextStyle(
                                      fontSize: 10,
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
