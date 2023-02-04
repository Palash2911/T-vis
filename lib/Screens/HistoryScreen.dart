import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tvis/Widgets/statusTile.dart';
import 'package:tvis/models/Trips.dart';
import '../Services/firebaseAuth.dart';
import '../constants.dart';

class HistoryPage extends StatefulWidget {
  final Auth auth;
  HistoryPage({required this.auth});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {

  var noTrips = 0;

  @override
  void initState() {
    _getTrips();
    super.initState();
  }

  Future<void> _getTrips() async{
    var temp = await widget.auth.noOfTrips();
    setState(() {
      noTrips = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(32.0, 32.0, 0.0, 0.0),
                child: Text(
                  'History',
                  style: kNameTextStyle,
                ),
              ),
              Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 32.0,
                      vertical: 15.0,
                    ),
                    decoration: kBorder,
                    child: Card(
                      elevation: 0.0,
                      child: Column(
                        children: [
                          ListTile(
                            leading: Icon(
                              Icons.receipt_long_rounded,
                              size: 50.0,
                              color: kPrimaryColor,
                            ),
                            title: Text(
                              'Total Number of trips',
                              style: ktitleTextStyle,
                            ),
                            subtitle: const Text('Today'),
                            trailing: Text(
                              '$noTrips',
                              style: ktitleTextStyle,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  StreamBuilder<List<Trips>>(
                    stream: widget.auth.listTrips(),
                    builder: (ctx, snapshot) {
                      if (!snapshot.hasData) {
                        return const Text("Loading..");
                      }
                      List<Trips> trips = snapshot.data as List<Trips>;
                      print(snapshot.data);
                      if (trips.isEmpty) {
                        return const Padding(
                          padding: EdgeInsets.fromLTRB(0, 100, 0, 0),
                          child: Text(
                            "No Trips to Show",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        );
                      }
                      return Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 32.0,
                            vertical: 15.0,
                          ),
                        decoration: kBorder,
                        height: 400,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: trips.length,
                          itemBuilder: (ctx, index) {
                            return StatusTile(
                              Status: trips[index].status,
                              DateTime: trips[index].dateTime,
                            );
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
