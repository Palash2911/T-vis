import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tvis/Screens/Admin/AdminProfileScreen.dart';
import 'package:tvis/Screens/Admin/QRScanScren.dart';
import 'package:tvis/Screens/Admin/SucessScreen.dart';
import '../../Services/firebaseAuth.dart';
import '../../constants.dart';

class AdminHomeScreen extends StatefulWidget {
  final Auth auth;
  const AdminHomeScreen({super.key, required this.auth});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  final TextEditingController _qrIdController = TextEditingController();
  String get qrId => _qrIdController.text;
  var vehCnt = 0;

  @override
  void initState() {
    super.initState();
    _getVeh();
  }

  Future<void> _getVeh() async {
    var temp = await widget.auth.noOfVehicles();
    setState(() {
      vehCnt = temp;
    });
  }

  Future<void> _getDetails() async {
    CollectionReference users = FirebaseFirestore.instance.collection('Users');
    try {
      users.where("UserID", isEqualTo: qrId).snapshots().listen(
            (event) => event.docs.forEach(
              (doc) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (ctx) => SuccessScreen(
                      auth: Auth(),
                      uid: doc.id,
                    ),
                  ),
                );
              },
            ),
          );
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset(
          "assets/images/logo.png",
          height: 50,
          width: 50,
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              child: Image.asset(
                "assets/images/logo.png",
              ),
            ),
            ListTile(
                title: const Text("Profile"),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AdminProfile(),
                    ),
                  );
                }),
            ListTile(
              title: const Text("Log Out"),
              onTap: () {},
            ),
            const Divider(),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SafeArea(
        child: Container(
          color: kSecondaryColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 32.0,
                  vertical: 30.0,
                ),
                decoration: kBorder,
                child: ListTile(
                  leading: Icon(
                    Icons.receipt_long_rounded,
                    size: 50.0,
                    color: kPrimaryColor,
                  ),
                  title: Text(
                    'Vehicles in campus',
                    style: ktitleTextStyle,
                  ),
                  subtitle: const Text('Today'),
                  trailing: Text(
                    '$vehCnt',
                    style: ktitleTextStyle,
                  ),
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
                      color: Colors.transparent,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'QR ID ',
                                    style: kprofileDescriptionText,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 9.0),
                            TextField(
                              controller: _qrIdController,
                              decoration: InputDecoration(
                                counterText: '',
                                prefixIcon: const Icon(Icons.numbers_outlined),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              // keyboardType: TextInputType.phone,
                              maxLength: 7,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ElevatedButton(
                        onPressed: _getDetails,
                        child: Padding(
                          padding: const EdgeInsets.all(9.0),
                          child: Text(
                            "Enter ",
                            style:
                                kprofileDescriptionText.merge(const TextStyle(
                              color: Colors.white,
                            )),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 180,
                width: 180,
                child: FittedBox(
                  child: FloatingActionButton.extended(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const QrScan(),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.qr_code_scanner_rounded,
                      size: 30,
                    ),
                    label: Text(
                      "Scan QR",
                      style: ktitleTextStyle,
                    ),
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
