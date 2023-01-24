import 'package:flutter/material.dart';
import 'package:tvis/Screens/HomeScreen.dart';
import 'package:tvis/Screens/LoginScreen.dart';
import 'package:tvis/Screens/RegisterScreen.dart';
import 'package:tvis/Widgets/bottomNavBar.dart';

void main() {
  runApp(const Tvis());
}

class Tvis extends StatelessWidget {
  const Tvis({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: bottomNavBar(),
      // home: RegisterScreen(),
      // home: LoginScreen(),
    );
  }
}
