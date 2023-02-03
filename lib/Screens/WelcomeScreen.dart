import 'package:flutter/material.dart';
import 'package:tvis/constants.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              colorFilter:
                  ColorFilter.mode(Colors.white54, BlendMode.softLight),
              opacity: 10.0,
              image: AssetImage("assets/images/bg.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            margin: EdgeInsets.all(40.0),
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Welcome to T-vis",
                  style: kWelcomeStyle,
                ),
                Text(
                  "The Tag Vehicles Identification System for Dr. DY Patil Education Campaus",
                  style: kAccountTextStyle,
                ),
                SizedBox(
                  height: 30.0,
                ),
                Container(
                  height: 180,
                  child: Image(
                    image: AssetImage(
                      "assets/images/logo2.png",
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    "Get Started",
                    style: kButtonTextStyle,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account? ",
                        style: kAccountTextStyle,
                      ),
                      GestureDetector(
                        child: Text(
                          "Login",
                          style: ktitleTextStyle.copyWith(color: kPrimaryColor),
                        ),
                        onTap: () {},
                      ),
                    ],
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
