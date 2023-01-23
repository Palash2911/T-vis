import 'package:flutter/material.dart';
import 'package:tvis/constants.dart';

class OptionCard extends StatelessWidget {
  OptionCard(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.onTap});

  final String title;
  final String subtitle;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.0,
      child: ListTile(
        leading: Icon(
          Icons.account_circle,
          size: 50.0,
          color: kPrimaryColor,
        ),
        title: Text(
          title,
          style: ktitleTextStyle,
        ),
        subtitle: Text(subtitle),
        trailing: Icon(Icons.arrow_forward_ios_rounded),
        onTap: onTap(),
      ),
    );
  }
}
