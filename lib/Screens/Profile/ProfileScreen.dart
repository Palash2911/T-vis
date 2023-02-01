import 'package:flutter/material.dart';
import 'package:tvis/Screens/LoginScreen.dart';
import 'package:tvis/Screens/Profile/ProfileDetailsScreen.dart';
import 'package:tvis/Screens/Profile/VechicalDetailsScreen.dart';
import 'package:tvis/constants.dart';
import 'package:tvis/Widgets/profileCard.dart';
import '../../Services/firebaseAuth.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({required this.auth});
  final Auth auth;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  void signOut(BuildContext ctx) async {
    await widget.auth.signOut();
    Navigator.pushReplacement(
      ctx,
      MaterialPageRoute(
        builder: (context) => LoginScreen(
          auth: widget.auth,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(32.0, 32.0, 0.0, 0.0),
              child: Text(
                'Profile',
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
                children: [
                  //Profile option
                  Card(
                    elevation: 0.0,
                    child: ListTile(
                      leading: Icon(
                        Icons.account_circle,
                        size: 50.0,
                        color: kPrimaryColor,
                      ),
                      title: Text(
                        'Profile',
                        style: ktitleTextStyle,
                      ),
                      subtitle: Text('Manage Profile'),
                      trailing: Icon(Icons.arrow_forward_ios_rounded),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfileDetailsPage(
                              auth: Auth(),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  // Vechical Option
                  Card(
                    elevation: 0.0,
                    child: ListTile(
                      leading: Icon(
                        Icons.no_crash_rounded,
                        size: 50.0,
                        color: kPrimaryColor,
                      ),
                      title: Text(
                        'Vehical Information',
                        style: ktitleTextStyle,
                      ),
                      subtitle: Text('Manage Vechical'),
                      trailing: Icon(Icons.arrow_forward_ios_rounded),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VechicalDetailsPage(),
                          ),
                        );
                      },
                    ),
                  ),
                  //Sign Out
                  Card(
                    elevation: 0.0,
                    child: ListTile(
                      leading: Icon(
                        Icons.logout_rounded,
                        size: 50.0,
                        color: kPrimaryColor,
                      ),
                      title: Text(
                        'Sign Out',
                        style: ktitleTextStyle,
                      ),
                      subtitle: Text('Done'),
                      trailing: Icon(Icons.arrow_forward_ios_rounded),
                      onTap: () => signOut(context),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
