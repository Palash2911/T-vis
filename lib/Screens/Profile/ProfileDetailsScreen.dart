import 'package:flutter/material.dart';
import 'package:tvis/constants.dart';
import 'package:tvis/Widgets/profileCard.dart';

import '../../Services/firebaseAuth.dart';

class ProfileDetailsPage extends StatefulWidget {
  const ProfileDetailsPage({super.key});

  @override
  State<ProfileDetailsPage> createState() => _ProfileDetailsPageState();
}

class _ProfileDetailsPageState extends State<ProfileDetailsPage> {
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
                'Profile Details',
                style: kNameTextStyle,
              ),
            ),
            ProfileCard(
              auth: Auth(),
            ),
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
                                  text: 'Name:',
                                  style: kprofileDescriptionText,
                                ),
                                TextSpan(
                                  text: ' Peter Parker',
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
