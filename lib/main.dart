/*
* Todo: 컨벤션에 맞게 순서 정리
*/
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:minto/src/app.dart';
import 'package:minto/src/binding/init_bindings.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:minto/firebase_options.dart';
import 'package:minto/src/data/model/wallet/wallet_controller.dart';
import 'package:minto/src/presentation/view/pages/login_screen.dart';
// import 'package:minto/src/presentation/view/pages/login_screen.dart';
// import 'package:minto/src/presentation/view/pages/signup_screen.dart';
// import 'package:minto/src/presentation/view/pages/festival_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
      // initialRoute: '/login',
      //App()는 bottom navigator를 관리하고 페이지를 index에 맞게끔 변환시켜주는 역할입니다.
      // home: const App(),
      home: LoginScreen(),
      // home: SignupScreen(),
      // home: FestivalScreen(),
    );
  }
}
