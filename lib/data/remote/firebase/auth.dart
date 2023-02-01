import 'package:firebase_auth/firebase_auth.dart';
import 'package:map_exam/data/model/user_auth.dart';

class Auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<UserAuth?> get userAuth {
    return _auth.authStateChanges().map(_userFromFirebase);
  }

  UserAuth? _userFromFirebase(User? user) {
    return UserAuth(uid: user!.uid, email: user.email!);
  }

  Future loginWithEmailAndPassword(String email, String password) async {
    UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    return credential.user;
  }

  Future<dynamic> logout() async {
    return await _auth.signOut();
  }
}
