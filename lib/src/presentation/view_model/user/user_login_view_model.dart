import 'package:get/get.dart';
import 'package:minto/src/data/model/user/user_login_model.dart';
import 'package:minto/src/data/repository/user/user_login_repository.dart';

class UserLoginViewModel extends GetxController {
  final UserLoginRepository _userLoginRepository = UserLoginRepository();
  final Rx<UserLoginModel> userLoginModel =
      UserLoginModel(email: "email", password: "password").obs;

  Future<void> signInWithEmailAndPassword(UserLoginModel userLoginModel) async {
    var user =
        await _userLoginRepository.signInWithEmailAndPassword(userLoginModel);

    if (user != null) {
      print("Login Success");
      Get.toNamed('/');
    } else {
      Get.snackbar('Login Failed', 'Please check your email and password');
    }
  }
}
