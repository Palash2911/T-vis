import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String? _selectedCollege;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 10.0),
          child: Column(
            children: <Widget>[
              Container(
                height: 160.0,
                child: Image.asset("images/register.png"),
              ),
              Text("Register"),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          labelText: 'Mobile Number'),
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          labelText: 'Name'),
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          labelText: 'Vehicle Number'),
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          labelText: 'Vehicle Name'),
                    ),
                    DropdownButtonFormField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          labelText: 'College Name'),
                      value: _selectedCollege,
                      items: ['DYPCOE', 'DYPIMR', 'DYPARC'].map((college) {
                        return DropdownMenuItem(
                          value: college,
                          child: Text(college),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          // _selectedCollege = value!;
                        });
                      },
                    ),
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text('Generate OTP'),
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text("Already have an account?"),
                    )
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
