import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lottie/lottie.dart';
import 'package:tvis/Screens/Admin/AdminHomeScreen.dart';

import '../../constants.dart';

class FailScreen extends StatelessWidget {
  const FailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 200.0,
            child: Lottie.asset('assets/animations/fail.json'),
          ),
          Container(
            margin: EdgeInsets.all(35),
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: kSecondaryColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Text(
                  "Something went wrong",
                  style: kNameTextStyle,
                ),
                Divider(
                  color: Colors.grey,
                ),
                Text(
                  "This is because of following reasons",
                  style: ktitleTextStyle,
                ),
                Text(
                  "Invalid Qr Code",
                  style: ktitleTextStyle,
                ),
                Text(
                  "This User not Registerd",
                  style: ktitleTextStyle,
                ),
                Text(
                  "Qr code not Scanned Properly",
                  style: ktitleTextStyle,
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    child: Text(
                      "Manual Entry",
                      style: kButtonTextStyle,
                    ),
                    onPressed: () {})
              ],
            ),
          )
        ],
      ),
    );
  }
}
