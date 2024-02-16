import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minto/src/presentation/view_model/user/user_signup_view_model.dart';

class SignupScreen extends StatelessWidget {
  final UserSignupViewModel _userSignupViewModel =
      Get.put(UserSignupViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              onChanged: (value) => _userSignupViewModel.userSignupModel
                  .update((val) => val!.email = value),
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              onChanged: (value) => _userSignupViewModel.userSignupModel
                  .update((val) => val!.password = value),
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            TextField(
              onChanged: (value) => _userSignupViewModel.userSignupModel
                  .update((val) => val!.userName = value),
              decoration: const InputDecoration(labelText: 'User Name'),
            ),
            ElevatedButton(
              onPressed: () {
                _userSignupViewModel.signUpWithEmailAndPassword(
                    _userSignupViewModel.userSignupModel.value);
              },
              child: const Text("Sign Up"),
            ),
          ],
        ),
      ),
    );
  }
}
