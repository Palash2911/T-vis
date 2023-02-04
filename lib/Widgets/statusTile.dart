import 'package:flutter/material.dart';
import 'package:tvis/constants.dart';

class StatusTile extends StatefulWidget {
  final String Status;
  final String DateTime;

  StatusTile({required this.Status, required this.DateTime});

  @override
  State<StatusTile> createState() => _StatusTileState();
}

class _StatusTileState extends State<StatusTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        widget.Status,
        style: ktitleTextStyle,
      ),
      trailing: Text(
        widget.DateTime,
        style: ktitleTextStyle.copyWith(
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}
