import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:tvis/constants.dart';

import '../Services/firebaseAuth.dart';

class HomePage extends StatefulWidget {
  HomePage({required this.auth});
  final Auth auth;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isInside = true;
  var details = {};
  var dataLoaded = false;
  String uid = "";
  var encoded = "";

  @override
  void initState() {
    super.initState();
    _getDetails();
  }

  Future<void> _getDetails() async {
    details = await widget.auth.getUserDetails("");
    Future.delayed(const Duration(milliseconds: 450), () {
      setState(() {
        isInside = details['status'] as bool;
        dataLoaded = true;
        uid = details['uid'].toString();
        encoded = (details['uid'] + details['uuid']);
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return !dataLoaded
        ? Container(
            alignment: Alignment.center,
            height: double.infinity,
            width: double.infinity,
            child: SizedBox(
              height: 500.0,
              child: Lottie.asset('assets/animations/loading.json'),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 2.0, 0.0, 0.0),
                child: Text(
                  'Dashboard',
                  style: kNameTextStyle,
                ),
              ),
            ),
            body: SafeArea(
              child: Container(
                color: kSecondaryColor,
                child: Column(
                  children: [
                    const SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          margin: const EdgeInsets.fromLTRB(0.0, 10, 25, 0.0),
                          width: 126.0,
                          decoration: kBorder,
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 8.0,
                                backgroundColor:
                                    isInside ? Colors.green : Colors.red,
                              ),
                              const SizedBox(width: 10.0),
                              Text(
                                isInside ? "Inside" : "Outside",
                                style: ktitleTextStyle,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(7.0),
                              decoration: kBorder,
                              child: QrImage(
                                data: encoded,
                                version: QrVersions.auto,
                                size: 270,
                                gapless: true,
                                errorStateBuilder: (cxt, err) {
                                  return Center(
                                    child: Text(
                                      "Uh oh! Something went wrong...",
                                      textAlign: TextAlign.center,
                                      style: kprofileDescriptionText,
                                    ),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 20.0),
                            Container(
                              decoration: kBorder,
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                "QR ID: $uid",
                                style: ktitleTextStyle,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
