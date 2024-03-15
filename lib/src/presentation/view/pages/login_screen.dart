import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minto/src/presentation/view_model/user/user_login_view_model.dart';

import '../../../app.dart';
import '../../../controller/wallet/wallet_controller.dart';
import 'create_or_import_screen.dart';

class LoginScreen extends StatelessWidget {
  final UserLoginViewModel _userLoginViewModel = Get.put(UserLoginViewModel());
  final WalletController _walletController = Get.put(WalletController());

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // if null
    if (_walletController.privateKey == null) {
      // return generate mnemonic key page
      return const CreateOrImportPage();
    } else {
      return Scaffold(
        body: App(),
      );
    }
  }
}
