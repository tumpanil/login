import 'package:flutter/material.dart';
import 'package:login/screens/dashboard-screen.dart';
import 'package:login/screens/login-screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences.getInstance().then((prefs) {
    runApp(LoginApp(prefs: prefs));
  });
}

class LoginApp extends StatelessWidget {
  final SharedPreferences prefs;

  const LoginApp({@required this.prefs});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: prefs.getBool("isLoggedIn") != null && prefs.getBool("isLoggedIn")
          ? DashBoardScreen(prefs: prefs)
          : LoginScreen(prefs: prefs),
    );
  }
}
