import 'package:minto/src/data/model/user/user_login_model.dart';
import 'package:minto/src/data/datasource/user/user_login_datasource.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserLoginRepository {
  final UserLoginDataSource _userLoginDataSource = UserLoginDataSource();

  Future<User?> signInWithEmailAndPassword(
      UserLoginModel userLoginModel) async {
    return await _userLoginDataSource
        .signInWithEmailAndPassword(userLoginModel);
  }
}
