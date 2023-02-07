import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tvis/constants.dart';

import '../Services/firebaseAuth.dart';
import '../Widgets/bottomNavBar.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({required this.auth});
  final AuthClass auth;

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _namecontroller = TextEditingController();
  final TextEditingController _vehNocontroller = TextEditingController();
  String get vehNo => _vehNocontroller.text;
  String get name => _namecontroller.text;
  String? vehType;
  String? cllg;
  String? gender;

  Future<void> register(BuildContext ctx) async {
    var user =
        await widget.auth.registerUser(name, vehNo, vehType.toString(), cllg.toString(), gender.toString());
    if (user.isNotEmpty) {
        Navigator.pushReplacement(
          ctx,
          MaterialPageRoute(
            builder: (context) => bottomNavBar(),
          ),
        );
    } else {
      print("Something Went Wrong");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 32.0, vertical: 20.0),
            child: Column(
              children: [
                SizedBox(
                  height: 160.0,
                  child: Lottie.asset("assets/animations/register.json"),
                ),
                Text(
                  "Register",
                  style: kh1TextStyle,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _namecontroller,
                        decoration: InputDecoration(
                          labelText: 'Name',
                          prefixIcon: const Icon(Icons.person),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                      const SizedBox(height: 20),
                      DropdownButtonFormField(
                        decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.male),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            labelText: 'Gender'),
                        value: gender,
                        items: ['Male', 'Female'].map((gen) {
                          return DropdownMenuItem(
                            value: gen,
                            child: Text(gen),
                            onTap: () {
                              setState(() {
                                gender = gen;
                              });
                            },
                          );
                        }).toList(),
                        onChanged: (value) {},
                      ),
                      const SizedBox(height: 20),
                      DropdownButtonFormField(
                        decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.directions_car),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            labelText: 'Vehicle Type'),
                        value: vehType,
                        items: ['2 Wheeler', '4 Wheeler'].map((vtype) {
                          return DropdownMenuItem(
                            value: vtype,
                            child: Text(vtype),
                            onTap: () {
                              setState(() {
                                vehType = vtype;
                              });
                            },
                          );
                        }).toList(),
                        onChanged: (value) {},
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                          controller: _vehNocontroller,
                          decoration: InputDecoration(
                            labelText: 'Vehicle Number',
                            prefixIcon: const Icon(Icons.numbers_rounded),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          onChanged: (value) {
                            _vehNocontroller.value = TextEditingValue(
                                text: value.toUpperCase(),
                                selection: _vehNocontroller.selection);
                          }),
                      const SizedBox(height: 20),
                      DropdownButtonFormField(
                        decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.business),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            labelText: 'College Name'),
                        value: cllg,
                        items: ['DYPCOE', 'DYPIMR', 'DYPARC'].map((college) {
                          return DropdownMenuItem(
                            value: college,
                            child: Text(college),
                            onTap: () {
                              setState(() {
                                cllg = college;
                              });
                            },
                          );
                        }).toList(),
                        onChanged: (value) {},
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        height: 60.0,
                        child: ElevatedButton(
                          onPressed: () => register(context),
                          child: const Text('Create Profile'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
