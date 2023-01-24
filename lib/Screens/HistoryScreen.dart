import 'package:flutter/material.dart';
import 'package:tvis/Widgets/statusTile.dart';
import '../constants.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(32.0, 32.0, 0.0, 0.0),
                child: Text(
                  'History',
                  style: kNameTextStyle,
                ),
              ),
              Column(
                children: [
                  Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 32.0, vertical: 15.0),
                    decoration: kBorder,
                    child: Card(
                      elevation: 0.0,
                      child: Column(
                        children: [
                          ListTile(
                            leading: Icon(
                              Icons.receipt_long_rounded,
                              size: 50.0,
                              color: kPrimaryColor,
                            ),
                            title: Text(
                              'Total Number of trips',
                              style: ktitleTextStyle,
                            ),
                            subtitle: Text('Today'),
                            trailing: Text(
                              '03',
                              style: ktitleTextStyle,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 32.0,
                      vertical: 20.0,
                    ),
                    decoration: kBorder,
                    child: Card(
                      elevation: 0.0,
                      child: Column(
                        children: const [
                          StatusTile(),
                          StatusTile(),
                          StatusTile(),
                          StatusTile(),
                          StatusTile(),
                          StatusTile(),
                          StatusTile(),
                          StatusTile(),
                          StatusTile(),
                          StatusTile(),
                          StatusTile(),
                          StatusTile(),
                          StatusTile(),
                          StatusTile(),
                          StatusTile(),
                          StatusTile(),
                          StatusTile(),
                          StatusTile(),
                          StatusTile(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// TODO Change the Font for In and Out time
// TODO Change the color of date and time greeen and red
