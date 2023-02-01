import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tvis/constants.dart';

import '../../Services/firebaseAuth.dart';

class vehicleDetailsPage extends StatefulWidget {
  vehicleDetailsPage({required this.auth});
  final Auth auth;

  @override
  State<vehicleDetailsPage> createState() => _vehicleDetailsPageState();
}

class _vehicleDetailsPageState extends State<vehicleDetailsPage> {
  final TextEditingController _vehNamecontroller = TextEditingController();
  final TextEditingController _vehNocontroller = TextEditingController();
  String get vehName => _vehNamecontroller.text;
  String get vehNo => _vehNocontroller.text;

  @override
  void initState() {
    getDetails();
  }

  Future<void> getDetails() async {
    var temp = await widget.auth.getUserDetails();
    setState(() {
      _vehNamecontroller.text = temp['vname'].toString();
      _vehNocontroller.text = temp['vno'].toString();
    });
  }

  Future<bool> updateDetails() async {
    var update = await widget.auth.updateVehicle(vehName, vehNo);
    return update;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded),
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
              Padding(
                padding: const EdgeInsets.fromLTRB(32.0, 32.0, 0.0, 0.0),
                child: Text(
                  'Vehicle Details',
                  style: kNameTextStyle,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                    horizontal: 32.0, vertical: 10.0),
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
                                    text: 'Vehicle Name',
                                    style: kprofileDescriptionText,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            TextField(
                              controller: _vehNamecontroller,
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.directions_car),
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
                              controller: _vehNocontroller,
                              decoration: InputDecoration(
                                counterText: '',
                                prefixIcon: const Icon(Icons.numbers_outlined),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              keyboardType: TextInputType.phone,
                              maxLength: 13,
                            ),
                            const SizedBox(height: 8.0),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ElevatedButton(
                        onPressed: () async {
                          var up = await updateDetails();
                          if (up) {
                            Fluttertoast.showToast(
                              msg: "Updated Successfully",
                              toastLength: Toast.LENGTH_SHORT,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.black,
                              textColor: Colors.white,
                              fontSize: 16.0,
                            );
                          } else {
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
                            style:
                                kprofileDescriptionText.merge(const TextStyle(
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
// TODO : Change weight of Other text to normal from bold
