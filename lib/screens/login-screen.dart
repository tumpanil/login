import 'package:flutter/material.dart';
import 'package:login/screens/dashboard-screen.dart';
import 'package:login/screens/otp-screen.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatelessWidget {
  final SharedPreferences prefs;
  final GlobalKey<FormState> _key = GlobalKey();
  final TextEditingController _phoneNoController = TextEditingController();
  final maskFormatter = MaskTextInputFormatter(mask: "#####-#####");

  LoginScreen({@required this.prefs});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text("Login Screen"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.05),
        child: Form(
          key: _key,
          child: Column(
            children: [
              Spacer(),
              TextFormField(
                controller: _phoneNoController,
                //obscureText: true,
                obscuringCharacter: "x",
                keyboardType: TextInputType.number,
                inputFormatters: [maskFormatter],
                decoration: InputDecoration(
                  labelText: "Phone Number",
                  border: new OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                validator: (phoneNo) {
                  if (phoneNo.isEmpty ||
                      maskFormatter.getUnmaskedText().length != 10)
                    return "Please Enter valid phone Number";
                  return null;
                },
              ),
              SizedBox(height: height * 0.02),
              ElevatedButton(
                onPressed: () async {
                  if (_key.currentState.validate()) {
                    await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: OtpScreen(
                            prefs: prefs,
                            phoneNo: maskFormatter.getMaskedText(),
                          ),
                        );
                      },
                    );
                  }
                },
                child: Container(
                  child: Text(
                    "Next",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: width * 0.05,
                    ),
                  ),
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: height * 0.02),
                ),
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
