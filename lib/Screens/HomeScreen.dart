import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:tvis/constants.dart';

import '../Services/firebaseAuth.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

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
  static final key = encrypt.Key.fromLength(32);
  static final iv = encrypt.IV.fromLength(16);
  static final encrypter = encrypt.Encrypter(encrypt.AES(key));
  var encrypts;
  // final encrypter = encrypt.Encrypter(AES(key));

  @override
  void initState() {
    super.initState();
    _getDetails();
  }

  Future<void> _getDetails() async {
    details = await widget.auth.getUserDetails();
    Future.delayed(const Duration(milliseconds: 450), () {
      setState(() {
        isInside = details['status'] as bool;
        var encodedJson = jsonEncode(details);
        encrypts = encrypter.encrypt(encodedJson, iv: iv).base16;
        // var decrypted = encrypter.decrypt(encrypts, iv: iv);
        print(encrypts);
        dataLoaded = true;
        uid = details['uid'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return !dataLoaded
        ? Container(
            alignment: Alignment.center,
            height: double.infinity,
            width: double.infinity,
            child: Container(
              height: 500.0,
              child: Lottie.asset('assets/animations/loading.json'),
            ),
          )
        : Scaffold(
            body: SafeArea(
              child: Container(
                color: kSecondaryColor,
                // decoration: BoxDecoration(
                //   image: DecorationImage(
                //     image: AssetImage("assets/images/bg2.png"),
                //     fit: BoxFit.cover,
                //   ),
                // ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 30.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          width: 110.0,
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
                              Text(isInside ? "Inside" : "Outside"),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 30.0,
                        )
                      ],
                    ),
                    Expanded(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10.0),
                              decoration: kBorder,
                              child: QrImage(
                                data: encrypts,
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
                            SizedBox(
                              height: 20.0,
                            ),
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
