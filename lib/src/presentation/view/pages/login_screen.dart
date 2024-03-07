import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minto/src/data/model/wallet/wallet_controller.dart';
import 'package:minto/src/presentation/view/pages/wallet_screen.dart';
import 'package:minto/src/presentation/view_model/user/user_login_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'create_or_import_screen.dart';

class LoginScreen extends StatelessWidget {
  final UserLoginViewModel _userLoginViewModel = Get.put(UserLoginViewModel());
  final WalletController _walletController = Get.put(WalletController());

  @override
  Widget build(BuildContext context) {
    // if null
    if (_walletController.privateKey == null) {
      // return generate mnemonic key page
      return CreateOrImportPage();
    } else {
      return WalletPage();
    }
    // useless code Below
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              onChanged: (value) => _userLoginViewModel.userLoginModel
                  .update((val) => val!.email = value),
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              onChanged: (value) => _userLoginViewModel.userLoginModel
                  .update((val) => val!.password = value),
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: () {
                _userLoginViewModel.signInWithEmailAndPassword(
                    _userLoginViewModel.userLoginModel.value);
              },
              child: const Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}
