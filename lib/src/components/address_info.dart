import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minto/src/controller/contract/contract_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web3dart/credentials.dart';

import '../controller/wallet/wallet_controller.dart';

class AddressInfo extends StatefulWidget {
  const AddressInfo({super.key});

  @override
  _AddressInfoState createState() => _AddressInfoState();
}

class _AddressInfoState extends State<AddressInfo> {
  String walletAddress = '';
  String pvKey = '';

  @override
  void initState() {
    super.initState();
    loadWalletData();
  }

  final WalletController _walletController = Get.put(WalletController());
  final NftController _nftController = Get.put(NftController());

  Future<void> loadWalletData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? privateKey = prefs.getString('privateKey');
    print("-----");
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

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: ListTile(
            leading: const Icon(Icons.logout),
            title: Text('지갑 주소: ${walletAddress}'),
            onTap: () async {
              await _nftController.getMyNfts(walletAddress);
              final nfts = _nftController.nfts;

              print("nfts: " + nfts.toString());
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.remove('privateKey');
              Get.offAndToNamed('/createOrImportWallet');
            },
          ),
        ),
        ElevatedButton(
          onPressed: () async {
            await _nftController.getMyNfts(walletAddress);
            print(_nftController.nftStructList);
          },
          child: Text("nft import text"),
        )
      ],
    );
  }
}
