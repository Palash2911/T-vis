import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tvis/Screens/Profile/OtpScreen.dart';
import 'package:tvis/Screens/RegisterScreen.dart';
import 'package:tvis/constants.dart';

import '../Services/firebaseAuth.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({required this.auth});
  final AuthClass auth;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController _phonecontroller = TextEditingController();
  String get phoneNo => "+91${_phonecontroller.text}";

  @override
  void initState() {
    _phonecontroller.text = "";
    //set the initial value of text field
    super.initState();
  }

  void sendOtp(BuildContext ctx){
    print(phoneNo.length);
    if (phoneNo.length == 13) {
      widget.auth.signInPhone(phoneNo);
      Navigator.push(
        ctx,
        MaterialPageRoute(builder: (context) => OtpScreen(auth: widget.auth,)),
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
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 32.0, vertical: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 20),
                SizedBox(
                  height: 270.0,
                  child: Lottie.asset('assets/animations/login.json'),
                ),
                Text(
                  'Login',
                  style: kh1TextStyle,
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _phonecontroller,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.phone),
                    labelText: 'Enter your mobile number',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 60.0,
                  child: ElevatedButton(
                    onPressed: () => sendOtp(context),
                    child: const Text('Generate OTP'),
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
