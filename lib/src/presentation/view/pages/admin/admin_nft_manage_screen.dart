import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminNftManage extends StatefulWidget {
  const AdminNftManage({super.key});

  @override
  State<StatefulWidget> createState() {
    return AdminNftMangeState();
  }
}

class AdminNftMangeState extends State<AdminNftManage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.white,
      ),
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        body: SafeArea(
          child: ListView(
            children: [
              Text("123"),
            ],
          ),
        ),
      ),
    );
  }
}
