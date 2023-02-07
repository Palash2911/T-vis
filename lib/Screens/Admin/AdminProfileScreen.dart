import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tvis/constants.dart';

import '../../Services/firebaseAuth.dart';

class AdminProfile extends StatefulWidget {
  final Auth auth;
  AdminProfile({required this.auth});
  @override
  State<AdminProfile> createState() => _AdminProfileState();
}

class _AdminProfileState extends State<AdminProfile> {
  final TextEditingController _namecontroller = TextEditingController();
  final TextEditingController _gendercontroller = TextEditingController();
  final TextEditingController _phoneNocontroller = TextEditingController();
  String get name => _namecontroller.text;
  String get phoneNo => _phoneNocontroller.text;
  String get gender => _gendercontroller.text;
  @override
  void initState() {
    getDetails();
  }

  Future<void> getDetails() async {
    var temp = await widget.auth.getUserDetails("");
    setState(() {
      _namecontroller.text = temp['name'].toString();
      _phoneNocontroller.text = temp['num'].toString();
      _gendercontroller.text = temp['gender'].toString();
    });
  }

  Future<bool> updateDetails() async{
    var update = await widget.auth.updateUser(name, phoneNo, gender);
    return update;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile Details"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(
                    horizontal: 32.0, vertical: 50.0),
                decoration: kBorder,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Card(
                      elevation: 0.0,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Name',
                                    style: kprofileDescriptionText,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            TextField(
                              controller: _namecontroller,
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.person),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            RichText(
                              text: TextSpan(
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'Number: ',
                                    style: kprofileDescriptionText,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 9.0),
                            TextField(
                              controller: _phoneNocontroller,
                              decoration: InputDecoration(
                                counterText: '',
                                prefixIcon: const Icon(Icons.phone),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              keyboardType: TextInputType.phone,
                              maxLength: 13,
                            ),
                            const SizedBox(height: 8.0),
                            RichText(
                              text: TextSpan(
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'Gender: ',
                                    style: kprofileDescriptionText,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 9.0),
                            DropdownButtonFormField(
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.male),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              value: gender.isEmpty?null:gender,
                              items:
                              ['Male', 'Female'].map((gen) {
                                return DropdownMenuItem(
                                  value: gen,
                                  child: Text(gen),
                                  onTap: () {
                                    setState(() {
                                      _gendercontroller.text = gen;
                                    });
                                  },
                                );
                              }).toList(),
                              onChanged: (value) {},
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ElevatedButton(
                        onPressed: () async{
                          var up = await updateDetails();
                          if(up)
                          {
                            Fluttertoast.showToast(
                              msg: "Updated Successfully",
                              toastLength: Toast.LENGTH_SHORT,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.black,
                              textColor: Colors.white,
                              fontSize: 16.0,
                            );
                          }
                          else
                          {
                            Fluttertoast.showToast(
                              msg: "Some error occured",
                              toastLength: Toast.LENGTH_SHORT,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.black,
                              textColor: Colors.white,
                              fontSize: 16.0,
                            );
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(9.0),
                          child: Text(
                            "Save Details",
                            style: kprofileDescriptionText.merge(const TextStyle(
                              color: Colors.white,
                            )),
                          ),
                        ),
                      ),
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
