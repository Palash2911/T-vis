import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:tvis/Screens/HomeScreen.dart';
import 'package:tvis/Screens/HistoryScreen.dart';
import 'package:tvis/Services/firebaseAuth.dart';
import 'package:tvis/constants.dart';

import '../Screens/Profile/ProfileScreen.dart';

class bottomNavBar extends StatefulWidget {
  @override
  State<bottomNavBar> createState() => _bottomNavBarState();
}

class _bottomNavBarState extends State<bottomNavBar> {
  final screens = [
    HomePage(
      auth: Auth(),
    ),
    HistoryPage(
      auth: Auth(),
    ),
    ProfilePage(
      auth: Auth(),
    ),
  ];
  int _page = 0;
  @override
  Widget build(BuildContext context) {
    final icons = <Widget>[
      Icon(
        Icons.home_rounded,
        size: 30,
        color: kSecondaryColor,
      ),
      Icon(
        Icons.history_rounded,
        size: 30,
        color: kSecondaryColor,
      ),
      Icon(
        Icons.person,
        size: 30,
        color: kSecondaryColor,
      ),
    ];
    return Scaffold(
      body: screens[_page],
      bottomNavigationBar: CurvedNavigationBar(
        buttonBackgroundColor: kPrimaryColor,
        color: kPrimaryColor,
        backgroundColor: kSecondaryColor,
        items: icons,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 300),
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
      ),
    );
  }
}
