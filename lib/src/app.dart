import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:minto/src/components/image_data.dart';
import 'package:minto/src/controller/bottom_nav_controller.dart';
import 'package:minto/src/festival_list_temp.dart';
import 'components/address_info.dart';
import 'controller/wallet/wallet_controller.dart';
import 'nft_screen.dart';

//App()는 bottom navigator를 관리하고 페이지를 index에 맞게끔 변환시켜주는 역할입니다.
class App extends GetView<BottomNavController> {
  final _walletController = Get.put(WalletController());

  App({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: controller.willPopAction,
      child: Obx(
        () => Scaffold(
          // backgroundColor: Colors.pink,는 배경색을 바꾸는 것입니다.
          //appBar: AppBar(),
          body: IndexedStack(
            index: controller.pageIndex.value,
            children: [
              Container(
                child: const Center(
                  child: NftPage(),
                ),
              ),
              Container(
                child: const Center(child: FestivalList()),
              ),
              Container(
                child: AddressInfo(),
              )
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            //type: BottomNavigationBarType.fixed,는 icon이 active되었을때 상단으로 올라가는 현상을 방지하기 위해 고정하는 것입니다.
            type: BottomNavigationBarType.fixed,

            //showSelectedLabels:와 showUnSelectedLabels:는 아이콘 밑의 라벨을 보이게 할지를 결정하는 것입니다.
            // showSelectedLabels: false,
            // showUnselectedLabels: false,
            //backgroundColor: Colors.red,
            //는 bottom navigator의 색깔을 바꾸는 것입니다.

            //currentIndex는 현재 페이지의 index를 표시해줌
            currentIndex: controller.pageIndex.value,

            //elevation은 navigator bar의 그림자부분의 수치
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
                label: 'profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
