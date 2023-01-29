import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
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
                Container(
                  height: 270.0,
                  child: Lottie.asset('assets/animations/login.json'),
                ),
                Text(
                  'Login',
                  style: kh1TextStyle,
                ),
                const SizedBox(height: 20),
                TextField(
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
                    onPressed: () {
                      widget.auth.signInPhone("+91 9619142911");
                    },
                    child: const Text('Generate OTP'),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterScreen()),
                    );
                  },
                  child: const Text("Dont have an account ? Create one "),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
