/*
* Todo: 컨벤션에 맞게 순서 정리
*/
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:minto/src/binding/init_bindings.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:minto/firebase_options.dart';
import 'package:minto/src/presentation/view/pages/admin/admin_festival_detail_screen.dart';
import 'package:minto/src/presentation/view/pages/admin/admin_nft_manage_screen.dart';
import 'package:minto/src/presentation/view/pages/admin/admin_statistics_screen.dart';
import 'package:minto/src/presentation/view/pages/create_or_import_screen.dart';
import 'package:minto/src/presentation/view/pages/generate_mnemonic_screen.dart';
import 'package:minto/src/presentation/view/pages/import_wallet_screen.dart';
import 'package:minto/src/presentation/view/pages/login_screen.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  //세로모드로 고정
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Minto',
      theme: ThemeData(
        primarySwatch: Colors.green,
        //primarySwatch: Colors.deepPurple,
        fontFamily: 'GmarketSans',
      ),
      getPages: [
        GetPage(
          name: '/',
          page: () => LoginScreen(),
        ),
        GetPage(
          name: '/importWallet',
          page: () => const ImportWallet(),
        ),
        GetPage(
          name: '/generateMnemonic',
          page: () => const GenerateMnemonicPage(),
        ),
        GetPage(
          name: '/createOrImportWallet',
          page: () => CreateOrImportPage(),
        ),
        GetPage(
            name: '/admin/festival',
            page: () => AdminFestivalDetail(),
            title: "축제 관리"),
        GetPage(
          name: '/admin/nft',
          page: () => AdminNftManage(),
          title: "NFT 기념품 관리",
        ),
        GetPage(
          name: '/admin/statistics',
          page: () => AdminStatistics(),
          title: "통계",
        )
      ],
      initialBinding: InitBinding(),
    );
  }
}
