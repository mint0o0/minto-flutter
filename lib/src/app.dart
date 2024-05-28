import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minto/src/components/image_data.dart';
import 'package:minto/src/controller/bottom_nav_controller.dart';
import 'package:minto/src/festival_list.dart';

import 'nft_screen3.dart';
import 'mypage.dart';

class App extends GetView<BottomNavController> {
  App({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: controller.willPopAction,

      child: Scaffold(
        body: Obx(
          () {
            Widget currentPage;
            
            switch (controller.pageIndex.value) {
              case 0:
                currentPage = NftPage3();
                 // NFT 페이지
                break;
              case 1:
                currentPage = FestivalList();
                 // 페스티벌 페이지
                break;
              case 2:
                currentPage = MyPage();
                // 마이 페이지
                break;
              default:
                currentPage = Container();
                // 기본값은 빈 컨테이너
            }
            return currentPage;
          },


        ),
        bottomNavigationBar: Obx(() => BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: controller.pageIndex.value,
          elevation: 4,
          onTap: controller.changeBottomNav,
          items: [
            BottomNavigationBarItem(
              icon: ImageData(IconsPath.nftOff),
              activeIcon: ImageData(IconsPath.nftOn),
              label: 'nft',
            ),
            BottomNavigationBarItem(
              icon: ImageData(IconsPath.festOff),
              activeIcon: ImageData(IconsPath.festOn),
              label: 'festival',
            ),
            BottomNavigationBarItem(
              icon: ImageData(IconsPath.profileOff),
              activeIcon: ImageData(IconsPath.profileOn),
              label: 'mypage',
            ),
          ],
          unselectedLabelStyle: TextStyle(fontFamily: 'GmarketSans', fontSize: 12.0),
          selectedLabelStyle: TextStyle(
            fontFamily: 'GmarketSans',
            fontSize: 12.0,
            fontWeight: FontWeight.bold
          ),
        )),
      ),
    );
  }
}
