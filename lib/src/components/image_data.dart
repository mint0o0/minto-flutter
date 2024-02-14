import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:minto/src/resources/images/icon_image.dart';

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
   static String get nftOff => IconImage.nftOffIcon;
   static String get nftOn => IconImage.nftOnIcon;
   static String get festOff => IconImage.festOffIcon;
   static String get festOn => IconImage.festOnIcon;
   static String get profileOff => IconImage.profileOffIcon;
   static String get profileOn => IconImage.profileOnIcon;
}