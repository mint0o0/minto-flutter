import 'package:firebase_auth/firebase_auth.dart';
import 'package:minto/src/data/model/user/user_signup_model.dart';
import 'package:minto/src/data/datasource/user/user_signup_datasource.dart';

class UserSignupRepository {
  final UserSignupDataSource _userSignupDataSource = UserSignupDataSource();

  Future<User?> signUpWithEmailAndPassword(
      UserSignupModel userSignupModel) async {
    return await _userSignupDataSource
        .signUpWithEmailAndPassword(userSignupModel);
  }
}