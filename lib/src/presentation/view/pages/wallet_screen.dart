import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web3dart/web3dart.dart';

import '../../../app.dart';
import '../../../controller/wallet/wallet_controller.dart';

// useless page
class WalletPage extends StatefulWidget {
  const WalletPage({Key? key}) : super(key: key);

  @override
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  String walletAddress = '';
  String balance = '';
  String pvKey = '';

  @override
  void initState() {
    super.initState();
    loadWalletData();
  }

  Future<void> loadWalletData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? privateKey = prefs.getString('privateKey');
    if (privateKey != null) {
      final walletController = WalletController();
      await walletController.loadPrivateKey();
      EthereumAddress address = await walletController.getPublicKey(privateKey);

      setState(() {
        walletAddress = address.hex;
        pvKey = privateKey;
      });
      log(pvKey);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: App(),
    );
  }
}
