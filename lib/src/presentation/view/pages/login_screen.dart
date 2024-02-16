import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minto/src/presentation/view_model/user/user_login_view_model.dart';

class LoginScreen extends StatelessWidget {
  final UserLoginViewModel _userLoginViewModel = Get.put(UserLoginViewModel());

  @override
  Widget build(BuildContext context) {
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
