import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minto/src/presentation/view/pages/admin/admin_screen.dart';

class AdminLoginScreen extends StatelessWidget {
  const AdminLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => {
                Get.to(() => AdminScreen())
              },
              child: const Text('Login'),
            ),
            ElevatedButton(
              onPressed: () => {
                Get.toNamed('/')
              },
              child: const Text('home'),
            ),
          ],
        ),
      ),
    );
  }
}
