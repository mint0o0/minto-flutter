import 'package:get/get.dart';
import 'package:minto/src/data/model/user/user_signup_model.dart';
import 'package:minto/src/data/repository/user/user_signup_repository.dart';

class UserSignupViewModel extends GetxController {
  final UserSignupRepository _userSignupRepository = UserSignupRepository();
  final Rx<UserSignupModel> userSignupModel =
      UserSignupModel(email: "", password: "", userName: "").obs;

  Future<void> signUpWithEmailAndPassword(
      UserSignupModel userSignupModel) async {
    var user =
        await _userSignupRepository.signUpWithEmailAndPassword(userSignupModel);

    if (user != null) {
      print("Sign Up Success");
      Get.toNamed('/');
    } else {
      Get.snackbar('Sign Up Failed', 'Please check your email and password');
    }
  }
}
