import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:minto/src/utils/func.dart';
import 'package:web3modal_flutter/web3modal_flutter.dart';

import 'controller/contract/contract_controller.dart';
import 'controller/wallet/wallet_controller.dart';
void main() {
  runApp(NftShowing());
}

class NftController {
  List<Map<String, dynamic>> nftStructList = [];

  void getMyNfts(String walletAddress) {
    // 여기서는 가짜 데이터를 사용하거나, 원하는 API 호출 등을 수행할 수 있습니다.
    // 예시 데이터를 그대로 사용하도록 합니다.
  }
}

class NftShowing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Refresh Button Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ShowNft(),
    );
  }
}

class ShowNft extends StatefulWidget {
  @override
  _ShowNftState createState() => _ShowNftState();
}

class _ShowNftState extends State<ShowNft> {
  final NftController _nftController = NftController();
  List<Map<String, dynamic>> nftStructList = [];

  @override
  void initState() {
    super.initState();
    _loadWalletAddress();
    _loadNfts();
  }

  Future<void> _loadWalletAddress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String walletAddress = prefs.getString('walletAddress') ?? '';
    _nftController.getMyNfts(walletAddress);
  }

  Future<void> _loadNfts() async {
    setState(() {
      nftStructList = _nftController.nftStructList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My App'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              
              _loadNfts();
            },
          ),
        ],
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // 가로당 3개씩 표시
          crossAxisSpacing: 4.0,
          mainAxisSpacing: 4.0,
        ),
        itemCount: nftStructList.length,
        itemBuilder: (BuildContext context, int index) {
          return Image.network(
            nftStructList[index]['image'],
            fit: BoxFit.cover,
          );
        },
      ),
    );
  }
}
