import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:tvis/Screens/OtpScreen.dart';
import 'package:tvis/constants.dart';

import '../Services/firebaseAuth.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({required this.auth});
  final AuthClass auth;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();
  String get phoneNo => "+91${_phoneController.text}";

  @override
  void initState() {
    _phoneController.text = "";
    super.initState();
  }

  void sendOtp(BuildContext ctx) {
    if (phoneNo.length == 13) {
      widget.auth.signInPhone(phoneNo);
      Navigator.pushReplacement(
        ctx,
        MaterialPageRoute(
          builder: (context) => OtpScreen(
            auth: widget.auth,
          ),
        ),
      );
    } else {
      const SnackBar(content: Text("Invalid Number"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            alignment: Alignment.bottomCenter,
            padding:
                const EdgeInsets.symmetric(horizontal: 35.0, vertical: 45.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                SizedBox(
                  height: 280.0,
                  child: Lottie.asset('assets/animations/login.json'),
                ),
                Text(
                  'Login / Sign Up',
                  style: kh1TextStyle.merge(TextStyle(
                    fontSize: 22,
                  )),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.phone),
                    labelText: 'Enter your mobile number',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 18),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)
                      ),
                  ),
                    onPressed: () => sendOtp(context),
                    child: Text(
                      "Generate OTP",
                      style: kButtonTextStyle,
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
