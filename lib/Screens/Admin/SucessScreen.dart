import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tvis/constants.dart';

class SuccessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 250.0,
            child: Lottie.asset('assets/animations/success.json'),
          ),
          Text(
            "QR Scan Successfully",
            style: kNameTextStyle,
          ),
          SizedBox(height: 20.0),
          Text(
            "Name: Hello World",
            style: ktitleTextStyle,
          ),
          SizedBox(height: 10.0),
          Text("QR ID: 847549", style: ktitleTextStyle),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Do something when the button is pressed
                },
                child: Text("Decline"),
              ),
              ElevatedButton(
                onPressed: () {
                  // Do something when the button is pressed
                },
                child: Text("Accept"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
