import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minto/src/app.dart';
import 'package:minto/src/binding/init_bindings.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Minto',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      initialBinding: InitBinding(),
      //App()는 bottom navigator를 관리하고 페이지를 index에 맞게끔 변환시켜주는 역할입니다.
      home: const App(),
    );
  }
}