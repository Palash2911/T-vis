import 'package:flutter/material.dart';
import 'package:tvis/constants.dart';
import 'package:tvis/Widgets/profileCard.dart';

import '../../Services/firebaseAuth.dart';

class ProfileDetailsPage extends StatefulWidget {
  ProfileDetailsPage({required this.auth});
  final Auth auth;

  @override
  State<ProfileDetailsPage> createState() => _ProfileDetailsPageState();
}

class _ProfileDetailsPageState extends State<ProfileDetailsPage> {

  String name = "Your Name";
  String num = "000";
  String cllg = "";
  @override
  void initState() {
    getDetails();
  }

  Future<void> getDetails() async{
    var temp = await widget.auth.getUserDetails();
    setState(() {
      name = temp['name'].toString();
      num = temp['num'].toString();
      cllg = temp['cllg'].toString();
    });
  }

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
            // ProfileCard(
            //   auth: Auth(),
            // ),
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
                                  text: 'Name: ',
                                  style: kprofileDescriptionText,
                                ),
                                TextSpan(
                                  text: name,
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
                                  text: 'Number: ',
                                  style: kprofileDescriptionText,
                                ),
                                TextSpan(
                                  text: num,
                                  style: kprofileDescriptionText.merge(
                                    const TextStyle(fontWeight: FontWeight.w100),
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
                                  text: 'College: ',
                                  style: kprofileDescriptionText,
                                ),
                                TextSpan(
                                  text: cllg,
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
                      child: const Text("Save Details"),
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
