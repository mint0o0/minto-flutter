import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:minto/src/utils/func.dart';
import 'package:web3modal_flutter/web3modal_flutter.dart';

import 'controller/contract/contract_controller.dart';
import 'controller/wallet/wallet_controller.dart';

class NftPage extends StatefulWidget {
  const NftPage({super.key});

  @override
  State<NftPage> createState() => _NftPageState();
}

class _NftPageState extends State<NftPage> with Func {
  String walletAddress = '';
  String pvKey = '';

  final NftController _nftController = Get.put(NftController());
  final WalletController _walletController = Get.put(WalletController());
  var nftStructList = [];
  final ImagePicker picker = ImagePicker(); //ImagePicker 초기화

  @override
  void initState() {
    super.initState();
    loadWalletData();
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

  Map<String, dynamic> createTokenUri() {
    Map<String, dynamic> map = {
      "description":
          "Friendly OpenSea Creature that enjoys long swims in the ocean.",
      "external_url": "https://openseacreatures.io/3",
      "image":
          "https://storage.googleapis.com/opensea-prod.appspot.com/puffs/3.png",
      "name": "Dave Starbelly",
    };
    return map;
  }

  // //이미지를 가져오는 함수
  // Future getImage(ImageSource imageSource) async {
  //   //pickedFile에 ImagePicker로 가져온 이미지가 담긴다.
  //   final XFile? pickedFile = await picker.pickImage(
  //     source: imageSource,
  //     imageQuality: 30,
  //   );
  //   if (pickedFile != null) {
  //     setState(() {
  //       _image = XFile(
  //         pickedFile.path,
  //       ); //가져온 이미지를 _image에 저장
  //     });
  //   }
  // }

  // Widget _buildPhotoArea() {
  //   return _image != null
  //       ? Container(
  //           width: 300,
  //           height: 300,
  //           child: Image.file(File(_image!.path)), //가져온 이미지를 화면에 띄워주는 코드
  //         )
  //       : Container(
  //           width: 300,
  //           height: 300,
  //           color: Colors.grey,
  //         );
  // }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(
          height: 40,
        ),

        // ElevatedButton(onPressed: _onPersonalSign, child: child)
        ElevatedButton(
          onPressed: () {
            _nftController.getMyNfts(walletAddress);
            print(_nftController.nftStructList);

            setState(() {
              nftStructList = _nftController.nftStructList;
            });
          },
          child: Text("nft get test"),
        ),
        for (Map m in nftStructList) Image.network(m['image']),

        ElevatedButton(
            onPressed: () async {
              print("Create Nft");
              // final count = await _nftController.getNfsCount();
              // print("count: ${count}");
              // await _nftController.createNft("create token URI", "title",
              //     "description", "https://picsum.photos/200");
              await _nftController.createAndSendNft("create token URI", "title",
                  'description', "https://picsum.photos/200");
            },
            child: Text("create nft test"))
      ],
    );
  }
}
