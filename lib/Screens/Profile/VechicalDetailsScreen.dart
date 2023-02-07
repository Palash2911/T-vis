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
  final TextEditingController _vehTypecontroller = TextEditingController();
  final TextEditingController _vehNocontroller = TextEditingController();
  final TextEditingController _collegecontroller = TextEditingController();
  String get cllg => _collegecontroller.text;
  String get vehType => _vehTypecontroller.text;
  String get vehNo => _vehNocontroller.text;

  @override
  void initState() {
    getDetails();
  }

  Future<void> getDetails() async {
    var temp = await widget.auth.getUserDetails("");
    setState(() {
      _vehTypecontroller.text = temp['vtype'].toString();
      _vehNocontroller.text = temp['vno'].toString();
      _collegecontroller.text = temp['cllg'].toString();
    });
  }

  Future<bool> updateDetails() async {
    var update = await widget.auth.updateVehicle(vehType, vehNo, cllg);
    return update;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Vehicle Details"),
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
                                    text: 'Vehicle Type',
                                    style: kprofileDescriptionText,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            DropdownButtonFormField(
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.directions_car),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              value: vehType.isEmpty ? null : vehType,
                              items: ['2 Wheeler', '4 Wheeler'].map((vt) {
                                return DropdownMenuItem(
                                  value: vt,
                                  child: Text(vt),
                                  onTap: () {
                                    setState(() {
                                      _vehTypecontroller.text = vt;
                                    });
                                  },
                                );
                              }).toList(),
                              onChanged: (value) {},
                            ),
                            const SizedBox(height: 8.0),
                            RichText(
                              text: TextSpan(
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'Vehicle Number: ',
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
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'College',
                                    style: kprofileDescriptionText,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            DropdownButtonFormField(
                              decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.directions_car),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              value: cllg.isEmpty ? null : cllg,
                              items: ['DYPCOE', 'DYPIMR', 'DYPARC'].map((clg) {
                                return DropdownMenuItem(
                                  value: clg,
                                  child: Text(clg),
                                  onTap: () {
                                    setState(() {
                                      _collegecontroller.text = clg;
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
