import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lottie/lottie.dart';

import '../Services/firebaseAuth.dart';
import '../Widgets/bottomNavBar.dart';
import 'LoginScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _loadScreen();
    super.initState();
  }

  void _loadScreen() async {
    await Firebase.initializeApp();
    Future.delayed(
      const Duration(milliseconds: 1100),
      () {
        FirebaseAuth.instance.currentUser?.uid == null
            ? Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginScreen(
                    auth: Auth(),
                  ),
                ),
              )
            : Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => bottomNavBar(),
                ),
              );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: SizedBox(
            height: 300.0,
            child: Lottie.asset('assets/animations/logo.json'),
          ),
        ),
      ),
    );
  }
}
