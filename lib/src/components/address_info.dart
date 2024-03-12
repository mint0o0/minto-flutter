import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web3dart/credentials.dart';

import '../controller/wallet/wallet_controller.dart';
import '../presentation/view/pages/create_or_import_screen.dart';

class AddressInfo extends StatefulWidget {
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

  Future<void> loadWalletData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? privateKey = prefs.getString('privateKey');
    print(privateKey);
    if (privateKey != null) {
      final WalletController _walletController = Get.put(WalletController());

      await _walletController.loadPrivateKey();
      EthereumAddress address =
          await _walletController.getPublicKey(privateKey);
      print(address.hex.toString());

      setState(() {
        walletAddress = address.hex;
        pvKey = privateKey;
      });
      print(pvKey);
      // String response = await getBalances(address.hex, 'sepolia');
      // dynamic data = json.decode(response);
      // String newBalance = data['balance'] ?? '0';

      // Transform balance from wei to ether
      // EtherAmount latestBalance = EtherAmount.fromBigInt(EtherUnit.wei, BigInt.parse(newBalance));
      // String latestBalanceInEther = latestBalance.getValueInUnit(EtherUnit.ether).toString();

      // setState(() {
      //   balance = latestBalanceInEther;
      // });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: ListTile(
          leading: const Icon(Icons.logout),
          title: Text('지갑 주소: ${walletAddress}'),
          onTap: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.remove('privateKey');
            // ignore: use_build_context_synchronously
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const CreateOrImportPage(),
              ),
              (route) => false,
            );
          },
        ),
      ),
    );
  }
}
