import 'package:firebase_auth/firebase_auth.dart';
import 'package:thing_easy/models/user_model.dart';

class FirebaseAuthServices {
  static FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  static Future<Map> createUser(UserModel userModel) async {
    try {
      final UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(
            email: userModel.email,
            password: userModel.password,
          );

      // Checking User is Exist or Not.
      final User? firebaseUser = userCredential.user;
      if (firebaseUser != null) {
        await firebaseUser.updateDisplayName(userModel.name);
        await firebaseUser.reload();
        return {"status": true, "message": "registeration successful"};
      }
      return {"status": false, "message": "registeration failed"};
    } on FirebaseAuthException catch (e) {
      return {"status": false, "message": e.message};
    }
  }

  static Future<Map> loginUser(UserModel userModel) async {
    try {
      final UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(
            email: userModel.email,
            password: userModel.password,
          );

      final User? firebaseUser = userCredential.user;
      if (firebaseUser != null) {
        return {
          "status": true,
          "message": "login successful",
          "name": firebaseUser.displayName,
        };
      }
      return {"status": false, "message": "login failed"};
    } on FirebaseAuthException catch (e) {
      return {"status": false, "message": e.message};
    }
  }

  static Future<Map> logoutUser() async {
    final User? firebaseUser = firebaseAuth.currentUser;
    if (firebaseUser != null) {
      await FirebaseAuth.instance.signOut();
      return {"status": true, "message": "logout success"};
    }
    return {"status": false, "message": "logout success"};
  }
}
