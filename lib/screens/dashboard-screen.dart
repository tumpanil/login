import 'package:flutter/material.dart';
import 'package:login/screens/login-screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashBoardScreen extends StatelessWidget {
  final SharedPreferences prefs;

  const DashBoardScreen({@required this.prefs});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("DashBoard Screen"),
        actions: [
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                prefs.setBool("isLoggedIn", false);
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => (LoginScreen(prefs: prefs)),
                  ),
                );
              })
        ],
      ),
      body: Center(
        child: Text(
          "Welcome xxxxx-xx${prefs.getString("phoneNo").substring(7)}",
          style: TextStyle(
            fontSize: width * 0.05,
            color: Colors.blue,
          ),
        ),
      ),
    );
  }
}
