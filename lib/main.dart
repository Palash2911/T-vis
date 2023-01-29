import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tvis/Screens/LoginScreen.dart';
import 'Services/firebaseAuth.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Tvis());
}

class Tvis extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(
        auth: Auth(),
      ),
      // home: RegisterScreen(),
      // home: LoginScreen(),
    );
  }
}
