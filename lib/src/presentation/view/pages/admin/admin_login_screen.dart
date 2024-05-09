// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:minto/src/presentation/view/pages/admin/admin_screen.dart';

// class AdminLoginScreen extends StatelessWidget {
//   const AdminLoginScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color.fromARGB(255, 93, 167, 139),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             const Padding(
//               padding: EdgeInsets.symmetric(horizontal: 16.0),
//               child: Text(
//                 '관리자 로그인',
//                 style: TextStyle(
//                   fontSize: 30.0,
//                   color: Colors.white,
//                   // fontFamily: 'GmarketSans',
//                   fontWeight: FontWeight.bold,
//                 ),
//                 textAlign: TextAlign.left,
//               ),
//             ),
//             const SizedBox(height: 24.0),
//             Container(
//               margin: const EdgeInsets.symmetric(horizontal: 16.0),
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               decoration: BoxDecoration(
//                 color: const Color.fromARGB(71, 255, 255, 255),
//                 borderRadius: BorderRadius.circular(10.0),
//               ),
//               child: const TextField(
//                 decoration: InputDecoration(
//                   labelText: '이메일',
//                 ),
//               ),
//             ),
//             const SizedBox(height: 16.0),
//             Container(
//               margin: const EdgeInsets.symmetric(horizontal: 16.0),
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               decoration: BoxDecoration(
//                 color: const Color.fromARGB(71, 255, 255, 255),
//                 borderRadius: BorderRadius.circular(10.0),
//               ),
//               child: const TextField(
//                 decoration: InputDecoration(
//                   labelText: '비밀번호',
//                 ),
//               ),
//             ),
//             const SizedBox(height: 16.0),
//             Container(
//               margin: const EdgeInsets.symmetric(horizontal: 64.0),
//               padding: const EdgeInsets.symmetric(horizontal: 64.0),
//               decoration: BoxDecoration(
//                 color: Colors.blue, // 버튼의 배경색을 파란색으로 설정
//                 borderRadius: BorderRadius.circular(10.0),
//               ),
//               child: InkWell(
//                 onTap: () => {
//                   Get.to(() => AdminScreen()),
//                 },
//                 child: Container(
//                   padding: const EdgeInsets.symmetric(vertical: 12.0),
//                   child: const Center(
//                     child: Text(
//                       "로그인",
//                       style: TextStyle(
//                         fontFamily: 'GmarketSans',
//                         color: Colors.white, // 버튼의 텍스트 색상을 흰색으로 설정
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
