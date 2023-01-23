import 'package:flutter/material.dart';
import 'package:tvis/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: kSecondaryColor,
          child: Stack(
            children: [
              Center(
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  decoration: kBorder,
                  child: Image.asset('images/Qr.png'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
