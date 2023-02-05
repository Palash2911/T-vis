import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:tvis/Widgets/bottomNavBar.dart';

import '../../Services/firebaseAuth.dart';
import '../../constants.dart';
import './RegisterScreen.dart';

class OtpScreen extends StatefulWidget {
  OtpScreen({required this.auth});
  final AuthClass auth;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController _otpcontroller = TextEditingController();
  String get otp => _otpcontroller.text;

  @override
  void initState() {
    _otpcontroller.text = "";
    //set the initial value of text field
    Fluttertoast.showToast(
      msg: "OTP Sent Successfully",
      toastLength: Toast.LENGTH_SHORT,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0,
    );
    super.initState();
  }

  Future<void> verifyOtp(BuildContext ctx) async {
    if (otp.length == 6) {
      var isVerified = await widget.auth.verifyOtp(otp);
      if (isVerified == true) {
        var isUser = await widget.auth.checkUser();
        if (isUser) {
          if (ctx.mounted) {
            Navigator.pushReplacement(
              ctx,
              MaterialPageRoute(builder: (context) => bottomNavBar()),
            );
          }
        } else {
          if (ctx.mounted) {
            Navigator.pushReplacement(
              ctx,
              MaterialPageRoute(
                builder: (context) => RegisterScreen(
                  auth: Auth(),
                ),
              ),
            );
          }
        }
      } else {
        print("Something went wrong");
      }
    } else {
      const SnackBar(content: Text("Invalid OTP"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 35.0, vertical: 45.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 20),
                SizedBox(
                  height: 280.0,
                  child: Lottie.asset('assets/animations/login.json'),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _otpcontroller,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.lock),
                    labelText: 'Enter OTP',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40.0, vertical: 10.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                    ),
                    onPressed: () => verifyOtp(context),
                    child: Text(
                      'Verify OTP',
                      style: kButtonTextStyle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
