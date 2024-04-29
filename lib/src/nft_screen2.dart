import 'dart:convert' show json;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:web3modal_flutter/web3modal_flutter.dart';
import 'controller/contract/contract_controller.dart';
import 'controller/wallet/wallet_controller.dart';
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
  String contractAddress = ''; // 추가: contract 주소를 저장할 변수

  final NftController _nftController = Get.put(NftController());
  final WalletController _walletController = Get.put(WalletController());
  var nftStructList = [];
  XFile? _image;
  final ImagePicker picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    loadWalletData();
    print("gdgd");
    loadContractAddress(); 
    print("oooo");// 추가: contract 주소를 로드
  }

  Future<void> loadWalletData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? privateKey = prefs.getString('privateKey');
    print(privateKey);
    if (privateKey != null) {
      await _walletController.loadPrivateKey();
      EthereumAddress address =
          await _walletController.getPublicKey(privateKey);
      print(address.hex.toString());

      setState(() {
        walletAddress = address.hex;
        pvKey = privateKey;
      });
      print(pvKey);
    }
  }

  Future<void> loadContractAddress() async {
    String jsonContent = await rootBundle.loadString('assets/json/MyNFT.json');
    print("09090909090");
    Map<String, dynamic> jsonData = json.decode(jsonContent);
    print("19191919191919");
    String address = jsonData['networks']['11155111']['address'];
    print("adrerss확인");
    print(address);
    print("adrerss확인");
    setState(() {
      contractAddress = address; // contract 주소 저장
    });
  }

Map<String, dynamic> createTokenUri(Map<String, dynamic> imageInfo, String tokenId) {
  Map<String, dynamic> map = {
    "description":
        "Friendly OpenSea Creature that enjoys long swims in the ocean.",
    "external_url": "https://testnets.opensea.io/assets/sepolia/$contractAddress/$tokenId",
    "image":
        "https://storage.googleapis.com/opensea-prod.appspot.com/puffs/3.png",
    "name": "Dave Starbelly",
  };
  return map;
}

  Future getImage(ImageSource imageSource) async {
    final XFile? pickedFile = await picker.pickImage(
      source: imageSource,
      imageQuality: 30,
    );
    if (pickedFile != null) {
      setState(() {
        _image = XFile(
          pickedFile.path,
        );
      });
    }
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
            GestureDetector( // 주소를 누를 때의 제스처 추가
              onTap: () {
                _launchInBrowser(createTokenUri(imageInfo, imageInfo['tokenId'])['external_url']);
              },
              child: Text( // 주소를 보여줄 텍스트 위젯
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
// Future<void> _launchInBrowser(Uri url) async {
//     if (!await launchUrl(
//       url,
//       mode: LaunchMode.externalApplication,
//     )) {
//       throw Exception('Could not launch $url');
//     }
//   }
// URL을 열기 위한 메서드
// void _launchURL(String url) async {
//   if (await canLaunch(url)) {
//     await launch(url);
//   } else {
//     throw 'Could not launch $url';
//   }
// }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("NFT Page"),
        automaticallyImplyLeading: false, // 뒤로가기 버튼 없애기
        actions: [
          IconButton(
            onPressed: () async {
              _nftController.getMyNfts(walletAddress);
              print(_nftController.nftStructList);

              setState(() {
                nftStructList = _nftController.nftStructList;
              });
            },
            icon: Icon(Icons.refresh),
          ),
          IconButton(
            onPressed: () async {
              print("Create Nft");
              await _nftController.createAndSendNft(
                  "create token URI", "title", 'description', "https://picsum.photos/200");
            },
            icon: Icon(Icons.star),
          ),
        ],
      ),
      body: GridView.count(
        crossAxisCount: 3,
        childAspectRatio: 1.0,
        padding: EdgeInsets.all(4.0),
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
        children: List.generate(nftStructList.length, (index) {
          return GestureDetector(
            onTap: () {
              _showImageInfoDialog(nftStructList[index]);
            },
            child: Column(
              children: [
                Expanded(
                  child: Image.network(nftStructList[index]['image']),
                ),
                Text(
                  nftStructList[index]['title'],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  nftStructList[index]['description'],
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
