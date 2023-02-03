import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tvis/Screens/LoginScreen.dart';
import 'package:tvis/Screens/WelcomeScreen.dart';
import 'package:tvis/Widgets/bottomNavBar.dart';
import 'Services/firebaseAuth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Tvis());
}

class Tvis extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: FirebaseAuth.instance.currentUser?.uid == null
            ? LoginScreen(
                auth: Auth(),
              )
            : bottomNavBar()
        // home: RegisterScreen(),
        // home: LoginScreen(),
        // home: WelcomeScreen(),
        );
  }
}
