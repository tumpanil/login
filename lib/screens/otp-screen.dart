import 'package:flutter/material.dart';
import 'package:login/screens/dashboard-screen.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OtpScreen extends StatelessWidget {
  final GlobalKey<FormState> _key = GlobalKey();
  final TextEditingController _otpController = TextEditingController();
  final SharedPreferences prefs;
  final String phoneNo;
  final maskFormatter = MaskTextInputFormatter(mask: "#-#-#-#-#-#");

  OtpScreen({@required this.prefs, @required this.phoneNo});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.05),
      child: Form(
        key: _key,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: height * 0.03),
            Text(
              "Please enter the one time password received at your phone number ending ${phoneNo.substring(7)}",
              style: TextStyle(
                color: Colors.blue,
              ),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: height * 0.03),
            TextFormField(
              controller: _otpController,
              //obscureText: true,
              //obscuringCharacter: "x",
              keyboardType: TextInputType.number,
              inputFormatters: [maskFormatter],
              decoration: InputDecoration(
                labelText: "OTP",
                border: new OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              validator: (otp) {
                if (otp.isEmpty || maskFormatter.getUnmaskedText().length != 6)
                  return "Please Enter valid OTP";
                return null;
              },
            ),
            SizedBox(height: height * 0.02),
            ElevatedButton(
              onPressed: () {
                if (_key.currentState.validate()) {
                  prefs.setString("phoneNo", phoneNo);
                  prefs.setBool("isLoggedIn", true);
                  Navigator.of(context).pop();
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => (DashBoardScreen(prefs: prefs)),
                    ),
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
            SizedBox(height: height * 0.10),
          ],
        ),
      ),
    );
  }
}
