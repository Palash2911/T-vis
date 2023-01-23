import 'package:flutter/material.dart';
import 'package:tvis/constants.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(32.0),
      padding: EdgeInsets.all(20.0),
      decoration: kBorder,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Your Name',
                style: kNameTextStyle,
              ),
              Text(
                'Your Account No',
                style: KAccountTextStyle,
              ),
            ],
          ),
          CircleAvatar(
            backgroundImage: AssetImage(
              'images/profile.png',
            ),
            radius: 70,
          )
        ],
      ),
    );
  }
}
