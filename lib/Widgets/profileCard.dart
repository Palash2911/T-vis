import 'package:flutter/material.dart';
import 'package:tvis/constants.dart';

import '../Services/firebaseAuth.dart';

class ProfileCard extends StatefulWidget {
  ProfileCard({required this.auth});
  final Auth auth;

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  String name = "Your Name";
  @override
  void initState() {
    getDetails();
  }

  Future<void> getDetails() async {
    var temp = await widget.auth.getUserDetails();
    setState(() {
      name = temp['name'].toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 15.0),
      padding: const EdgeInsets.all(20.0),
      decoration: kBorder,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 130,
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    name,
                    style: kNameTextStyle,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              Text(
                'QR ID: 4987984',
                style: kAccountTextStyle,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          Container(
              margin: const EdgeInsets.fromLTRB(11, 0, 0, 0),
              height: 100,
              width: 100,
              child: const CircleAvatar(
                backgroundImage: AssetImage(
                  'assets/images/profile.png',
                ),
                radius: 70,
              )),
        ],
      ),
    );
  }
}
