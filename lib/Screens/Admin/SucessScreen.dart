import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tvis/Screens/Admin/AdminHomeScreen.dart';
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

  Future<void> _updateSt(String status) async {
    var temp = await widget.auth
        .updateStatus(status, widget.uid.toString());
    if (temp) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (ctx) => AdminHomeScreen(
            auth: Auth(),
          ),
        ),
      );
    }
  }

  Future<void> getDetails() async {
    var temp =
        await widget.auth.getUserDetails(widget.uid.toString());
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
                  _updateSt("Decline");
                },
                child: st
                    ? const Text("Decline Exit")
                    : const Text("Decline Entry"),
              ),
              ElevatedButton(
                onPressed: () {
                  st ? _updateSt("allowExit") : _updateSt("allowEntry");
                },
                child:
                    st ? const Text("Allow Exit") : const Text("Allow Entry"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
