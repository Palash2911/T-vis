import 'package:flutter/material.dart';
import 'package:tvis/constants.dart';

class StatusTile extends StatelessWidget {
  const StatusTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        'Entered',
        style: ktitleTextStyle,
      ),
      trailing: Text(
        '22 Oct, 04:02 PM',
        style: ktitleTextStyle.copyWith(fontWeight: FontWeight.normal),
      ),
    );
  }
}
