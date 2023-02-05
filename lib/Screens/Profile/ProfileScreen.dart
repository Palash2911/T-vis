import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:tvis/Screens/LoginScreen.dart';
import 'package:tvis/Screens/Profile/ProfileDetailsScreen.dart';
import 'package:tvis/Screens/Profile/VechicalDetailsScreen.dart';
import 'package:tvis/constants.dart';
import 'package:tvis/Widgets/profileCard.dart';
import '../../Services/firebaseAuth.dart';
import '../Admin/AdminHomeScreen.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({required this.auth});
  final Auth auth;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var dataLoaded = false;

  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 550), () {
      setState(() {
        dataLoaded = true;
      });
    });
    super.initState();
  }

  void signOut(BuildContext ctx) async {
    await widget.auth.signOut();
    Fluttertoast.showToast(
      msg: "Signed Out Successfully",
      toastLength: Toast.LENGTH_SHORT,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16.0,
    );
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
    return !dataLoaded
        ? Container(
            alignment: Alignment.center,
            height: double.infinity,
            width: double.infinity,
            child: SizedBox(
              height: 500.0,
              child: Lottie.asset('assets/animations/loading.json'),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 2.0, 0.0, 0.0),
                child: Text(
                  'Profile',
                  style: kNameTextStyle,
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    ProfileCard(
                      auth: Auth(),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 32.0,
                        vertical: 10.0,
                      ),
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
                              subtitle: const Text('Manage Profile'),
                              trailing:
                                  const Icon(Icons.arrow_forward_ios_rounded),
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
                          Card(
                            elevation: 0.0,
                            child: ListTile(
                              leading: Icon(
                                Icons.no_crash_rounded,
                                size: 50.0,
                                color: kPrimaryColor,
                              ),
                              title: Text(
                                'Vehicle Information',
                                style: ktitleTextStyle,
                              ),
                              subtitle: const Text('Manage Vehicle'),
                              trailing:
                                  const Icon(Icons.arrow_forward_ios_rounded),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => vehicleDetailsPage(
                                      auth: Auth(),
                                    ),
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
                              subtitle: const Text('Done'),
                              trailing:
                                  const Icon(Icons.arrow_forward_ios_rounded),
                              onTap: () => signOut(context),
                            ),
                          ),
                          Card(
                            elevation: 0.0,
                            child: ListTile(
                              leading: Icon(
                                Icons.logout_rounded,
                                size: 50.0,
                                color: kPrimaryColor,
                              ),
                              title: Text(
                                'Switch to Admin',
                                style: ktitleTextStyle,
                              ),
                              subtitle: const Text('use admin app'),
                              trailing:
                                  const Icon(Icons.arrow_forward_ios_rounded),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AdminHomeScreen(
                                      auth: Auth(),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
