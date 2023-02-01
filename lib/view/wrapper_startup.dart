import 'package:flutter/material.dart';
import 'package:map_exam/data/model/user_auth.dart';
import 'package:map_exam/logic/provider/auth_provider.dart';
import 'package:map_exam/logic/provider/note_provider.dart';
import 'package:map_exam/view/authenticate/login_screen.dart';
import 'package:map_exam/view/home_page/home_screen.dart';
import 'package:provider/provider.dart';

class WrapperStartup extends StatelessWidget {
  const WrapperStartup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userAuthState = Provider.of<UserAuth?>(context);
    // check is login
    if (userAuthState != null) {
      return ChangeNotifierProvider(
          create: (context) {
            return NoteProvider(userUid: userAuthState.uid, notes: []);
          },
          child: const HomeScreen());
    } else {
      return ChangeNotifierProvider<LoginProvider>.value(
        value: LoginProvider(),
        child: const LoginScreen(),
      );
    }
  }
}
