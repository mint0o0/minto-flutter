import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:minto/src/components/message_popup.dart';
enum PageName{nft,fest,profile}
class BottomNavController extends GetxController{
  RxInt pageIndex=1.obs;
  List<int> bottomHistory =[1];

  void changeBottomNav(int value,{bool hasGesture = true}){
    var page=PageName.values[value];
    switch(page){
      //Get.to(()=>이동하는페이지함수())도 가능함...
      case PageName.nft:
        _changePage(value,hasGesture:hasGesture);
        break;
      case PageName.fest:
        _changePage(value,hasGesture:hasGesture);
        break;
      case PageName.profile:
        // 여기서 함수 실행
        
        _changePage(value,hasGesture:hasGesture);
        break;
    }
  }
  void _changePage(int value,{bool hasGesture = true}){
    pageIndex(value);
    if (!hasGesture) return;
    if(bottomHistory.contains(value)){    
      bottomHistory.remove(value);
      }
      bottomHistory.add(value);
      //print(bottomHistory);
  }
  Future<bool> willPopAction() async{
    if (bottomHistory.length == 1){
      showDialog(context: Get.context!,builder:(context)=>MessagePopup(
        message:'종료하시겠습니까?',
        okCallback:() {
          exit(0);},
        cancelCallback: Get.back,
        title:'시스템',
        ));
      return Future<bool>.value(true);
    }
    else{
      bottomHistory.removeLast();
      var index=bottomHistory.last;
      changeBottomNav(index,hasGesture: false);
      //print(bottomHistory);
      return false;
    }
  }
}