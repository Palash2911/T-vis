import 'package:flutter/material.dart';
import 'package:tvis/Screens/SpalshScreen.dart';

void main() => runApp(const Tvis());

class Tvis extends StatelessWidget {
  const Tvis({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
