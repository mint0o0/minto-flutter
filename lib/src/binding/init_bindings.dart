import 'package:get/get.dart';
import 'package:minto/src/controller/bottom_nav_controller.dart';
//앱이 실행되는 동시에 getx 컨트롤러들을 필요에 따라 instance로 올려주기 위한 클래스입니다.
class InitBinding extends Bindings{
  @override
  void dependencies(){
    Get.put(BottomNavController(), permanent: true);
    //permanent를 true로 해서 앱이 종료될때까지 instance로 존재하게함
  }
}