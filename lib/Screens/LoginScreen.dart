import 'package:flutter/material.dart';
import 'package:tvis/constants.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                height: 290.0,
                child: Image.asset('images/login.png'),
              ),
              Text(
                'Login',
                style: kNameTextStyle,
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Enter your mobile number',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                keyboardType: TextInputType.phone,
              ),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text('Generate OTP'),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text("Dont have an account ? Create one "),
              )
            ],
          ),
        ),
      ),
    );
  }
}
