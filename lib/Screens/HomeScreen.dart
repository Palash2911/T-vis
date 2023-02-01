import 'package:flutter/material.dart';
import 'package:tvis/constants.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isInside = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: kSecondaryColor,
          // decoration: BoxDecoration(
          //   image: DecorationImage(
          //       image: AssetImage("assets/images/bg.png"), fit: BoxFit.cover),
          // ),
          child: Column(
            children: [
              SizedBox(
                height: 30.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: 100.0,
                    decoration: kBorder,
                    padding: EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 8.0,
                          backgroundColor: isInside ? Colors.green : Colors.red,
                        ),
                        SizedBox(width: 10.0),
                        Text(isInside ? "Inside" : "Outside"),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 30.0,
                  )
                ],
              ),
              Expanded(
                child: Center(
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    decoration: kBorder,
                    child: Image.asset('assets/images/Qr.png'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
