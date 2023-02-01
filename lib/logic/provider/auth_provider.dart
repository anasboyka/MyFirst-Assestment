import 'package:flutter/material.dart';
import 'package:map_exam/data/model/user_auth.dart';
import 'package:map_exam/data/remote/firebase/auth.dart';

class LoginProvider with ChangeNotifier {
  String? email;
  String? password;
  bool loading;

  LoginProvider({
    this.email,
    this.password,
    this.loading = false,
  });

  void setEmail(String email) {
    this.email = email;
    notifyListeners();
  }

  void setPassword(String password) {
    this.password = password;
    notifyListeners();
  }

  void loadingStart() {
    loading = true;
    notifyListeners();
  }

  void loadingEnd() {
    loading = false;
    notifyListeners();
  }

  Future loginWithEmailAndPassword() async {
    try {
      loadingStart();
      await Auth().loginWithEmailAndPassword(email!, password!);
    } on Exception catch (e) {
      print(e);
      // TODO
    }
    loadingEnd();
  }
}
