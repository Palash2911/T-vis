import 'package:flutter/material.dart';
import 'package:tvis/constants.dart';
import 'package:tvis/Widgets/profileCard.dart';

class VechicalDetailsPage extends StatefulWidget {
  const VechicalDetailsPage({super.key});

  @override
  State<VechicalDetailsPage> createState() => _VechicalDetailsPageState();
}

class _VechicalDetailsPageState extends State<VechicalDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(32.0, 32.0, 0.0, 0.0),
              child: Text(
                'Vechical Details',
                style: kNameTextStyle,
              ),
            ),
            ProfileCard(),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 32.0, vertical: 10.0),
              decoration: kBorder,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Card(
                    elevation: 0.0,
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          RichText(
                            text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Vechical Name:',
                                  style: kprofileDescriptionText,
                                ),
                                TextSpan(
                                  text: ' The Batmobile',
                                  style: kprofileDescriptionText.merge(
                                    TextStyle(fontWeight: FontWeight.normal),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 8.0),
                          RichText(
                            text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Number:',
                                  style: kprofileDescriptionText,
                                ),
                                TextSpan(
                                  text: ' 8979798778',
                                  style: kprofileDescriptionText.merge(
                                    TextStyle(fontWeight: FontWeight.normal),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 8.0),
                          RichText(
                            text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Department:',
                                  style: kprofileDescriptionText,
                                ),
                                TextSpan(
                                  text: ' DYPCOE',
                                  style: kprofileDescriptionText.copyWith(
                                      fontWeight: FontWeight.normal),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      child: Text("Change Request"),
                      onPressed: () {
                        // code to handle change request
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// TODO : Change weight of Other text to normal from bold