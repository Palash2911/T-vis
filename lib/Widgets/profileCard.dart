import 'package:flutter/material.dart';
import 'package:tvis/constants.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(32.0),
      padding: const EdgeInsets.all(20.0),
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
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                'Your Account No',
                style: KAccountTextStyle,
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
            )
          ),
        ],
      ),
    );
  }
}
