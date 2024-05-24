import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minto/src/presentation/view/pages/admin/admin_dashboard_screen.dart';

class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({super.key});

  @override
  _AdminLoginScreenState createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Container(
          margin: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _header(context),
              _inputField(context),
              _forgotPassword(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header(BuildContext context) {
    return const Column(
      children: [
        Text(
          "관리자 로그인",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        SizedBox(
          height: 30,
        )
      ],
    );
  }

  Widget _inputField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          decoration: InputDecoration(
            hintText: "아이디",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none),
            fillColor: const Color.fromARGB(255, 93, 167, 139).withOpacity(0.1),
            filled: true,
            prefixIcon: const Icon(Icons.person),
          ),
          controller: _idController,
        ),
        const SizedBox(height: 10),
        TextField(
          decoration: InputDecoration(
            hintText: "비밀번호",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
                borderSide: BorderSide.none),
            fillColor: const Color.fromARGB(255, 93, 167, 139).withOpacity(0.1),
            filled: true,
            prefixIcon: const Icon(Icons.password),
          ),
          obscureText: true,
          controller: _passwordController,
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            _login();
          },
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            padding: const EdgeInsets.symmetric(vertical: 16),
            backgroundColor: const Color.fromARGB(255, 93, 167, 139),
          ),
          child: const Text(
            "Login",
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }

  Widget _forgotPassword(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: const Text(
        "비밀번호 찾기",
        style: TextStyle(color: Color.fromARGB(255, 93, 167, 139)),
      ),
    );
  }

  void _login() {
    String id = _idController.text;
    String password = _passwordController.text;

    if (id == 'admin' && password == '1234') {
      // 로그인 성공 시 페이지 이동
      print("로그인 성공");
      Get.to(() => const AdminDashBoard());
    } else {
      // 로그인 실패 시 경고 메시지 표시
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('로그인 실패'),
          content: const Text('아이디 또는 비밀번호가 잘못되었습니다.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('확인'),
            ),
          ],
        ),
      );
    }
  }
}
