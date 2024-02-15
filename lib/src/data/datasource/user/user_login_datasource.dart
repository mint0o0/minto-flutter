import 'package:firebase_auth/firebase_auth.dart';
import 'package:minto/src/data/model/user/user_login_model.dart';

class UserLoginDataSource {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> get user => _auth.authStateChanges();

  Future<User?> signInWithEmailAndPassword(
      UserLoginModel userLoginModel) async {
    try {
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: userLoginModel.email,
        password: userLoginModel.password,
      );

      User? user = userCredential.user;
      return user;
    } catch (e) {
      print("Login With Email Error: $e");
      return null;
    }
  }
}
