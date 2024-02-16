import 'package:firebase_auth/firebase_auth.dart';
import 'package:minto/src/data/model/user/user_signup_model.dart';

class UserSignupDataSource {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> get user => _auth.authStateChanges();

  Future<User?> signUpWithEmailAndPassword(
      UserSignupModel userSignupModel) async {
    try {
      final UserCredential userCredential =
      await _auth.createUserWithEmailAndPassword(
        email: userSignupModel.email,
        password: userSignupModel.password,
      );

      User? user = userCredential.user;
      return user;
    } catch (e) {
      print("Sign Up With Email Error: $e");
      return null;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
