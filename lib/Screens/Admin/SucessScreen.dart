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
    var temp = await widget.auth.updateStatus(status, widget.uid.toString());
    if (temp) {
      Future.delayed(const Duration(milliseconds: 1000), () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (ctx) => AdminHomeScreen(
              auth: Auth(),
            ),
          ),
        );
      });
    }
  }

  Future<void> getDetails() async {
    var temp = await widget.auth.getUserDetails(widget.uid.toString());
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
            height: 200.0,
            child: Lottie.asset('assets/animations/success.json'),
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
                  "QR Scan Successfully",
                  style: kNameTextStyle,
                ),
                Divider(
                  color: Colors.grey,
                ),
                const SizedBox(height: 10.0),
                Text(
                  "Name: $name",
                  style: ktitleTextStyle,
                ),
                const SizedBox(height: 10.0),
                Text("QR ID: $qrID", style: ktitleTextStyle),
                const SizedBox(height: 20.0),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red[400],
                        elevation: 0,
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: Lottie.asset(
                                'assets/animations/reject.json',
                              ),
                            );
                          },
                        );
                        _updateSt("Decline");
                      },
                      child: st
                          ? Text(
                              "Decline Exit",
                              style: kButtonTextStyle,
                            )
                          : Text("Decline Entry", style: kButtonTextStyle),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green[400],
                        elevation: 0,
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: Lottie.asset(
                                'assets/animations/accept.json',
                              ),
                            );
                          },
                        );
                        st ? _updateSt("allowExit") : _updateSt("allowEntry");
                      },
                      child: st
                          ? Text("Allow Exit", style: kButtonTextStyle)
                          : Text("Allow Entry", style: kButtonTextStyle),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
