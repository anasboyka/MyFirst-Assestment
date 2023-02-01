import 'package:flutter/material.dart';
import 'package:map_exam/constant/constant_widget.dart';
import 'package:map_exam/logic/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static Route route() =>
      MaterialPageRoute(builder: (_) => const LoginScreen());
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final loginCon = Provider.of<LoginProvider>(context, listen: false);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Please sign in', style: TextStyle(fontSize: 35.0)),
              const SizedBox(height: 20),
              TextField(
                controller: _usernameController,
                decoration:
                    const InputDecoration(hintText: 'Type your email here'),
                onTap: () {},
                onChanged: (value) {
                  loginCon.setEmail(value);
                },
              ),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: 'Type your password',
                ),
                onTap: () {},
                onChanged: (value) {
                  loginCon.setPassword(value);
                },
              ),
              const SizedBox(height: 10.0),
              ElevatedButton(
                child: const Text('Sign in'),
                onPressed: () async {
                  await loginCon.loginWithEmailAndPassword();
                },
              ),
              const SizedBox(
                height: 20,
              ),
              //loadingWidget
              Provider.of<LoginProvider>(context).loading
                  ? loadingWidget
                  : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}
