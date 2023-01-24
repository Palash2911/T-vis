import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:tvis/Screens/HomeScreen.dart';
import 'package:tvis/Screens/HistoryScreen.dart';
import 'package:tvis/constants.dart';

import '../Screens/Profile/ProfileScreen.dart';

class bottomNavBar extends StatefulWidget {
  const bottomNavBar({super.key});

  @override
  State<bottomNavBar> createState() => _bottomNavBarState();
}

class _bottomNavBarState extends State<bottomNavBar> {
  final screens = [
    HomePage(),
    HistoryPage(),
    ProfilePage(),
  ];
  int _page = 1;
  @override
  Widget build(BuildContext context) {
    final _icons = <Widget>[
      Icon(
        Icons.home_rounded,
        size: 30,
        color: kSecondaryColor,
      ),
      Icon(
        Icons.manage_history_rounded,
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
        items: _icons,
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
      ),
    );
  }
}