import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:map_exam/data/remote/firebase/auth.dart';
import 'package:map_exam/route_generator.dart';
import 'package:map_exam/view/wrapper_startup.dart';
import 'package:provider/provider.dart';

// import 'login_screen.dart';
// import 'edit_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider.value(
          catchError: (_, __) => null,
          value: Auth().userAuth,
          initialData: null,
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'myFirst',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // home: const LoginScreen(),
        initialRoute: '/',
        onGenerateRoute: RouteGenerator.generateRoute,
        // home: const EditScreen(),
      ),
    );
  }
}
