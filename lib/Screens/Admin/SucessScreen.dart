import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tvis/constants.dart';

import '../../Services/firebaseAuth.dart';

class SuccessScreen extends StatefulWidget {
  final String uid;
  final Auth auth;
  SuccessScreen({required this.uid, required this.auth});
  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {

  String name = "";
  String qrID = "";
  var st = true;

  @override
  void initState() {
    getDetails();
    super.initState();
  }

  Future<void> getDetails() async {
    var temp = await widget.auth.getUserDetails(widget.uid);
    setState(() {
      name = temp['name'].toString();
      qrID = temp['uid'].toString();
      st = temp['status'] as bool;
    });
  }

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
          const SizedBox(height: 20.0),
          Text(
            "Name: $name",
            style: ktitleTextStyle,
          ),
          const SizedBox(height: 10.0),
          Text("QR ID: $qrID", style: ktitleTextStyle),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Do something when the button is pressed
                },
                child: const Text("Decline"),
              ),
              ElevatedButton(
                onPressed: () {
                  // Do something when the button is pressed
                },
                child: const Text("Accept"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
