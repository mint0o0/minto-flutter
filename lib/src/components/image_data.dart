import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
class ImageData extends StatelessWidget {
  final String icon;
  final double? width;
  const ImageData(
    this.icon,{
      Key? key,this.width=55,
      }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return SvgPicture.asset(
      icon,
      width: width! / Get.mediaQuery.devicePixelRatio
      );
  }
}
class IconsPath {
   static String get nftOff => 'assets/images/nft_logo.svg';
   static String get nftOn => 'assets/images/nft_logo_on.svg';
   static String get festOff => 'assets/images/fest_logo.svg';
   static String get festOn => 'assets/images/fest_logo_on.svg';
   static String get profileOff => 'assets/images/profile_logo.svg';
   static String get profileOn => 'assets/images/profile_logo_on.svg';
}