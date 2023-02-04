import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

import '../models/Trips.dart';

class Users {
  Users({required this.uid});
  final String uid;
}

abstract class AuthClass {
  Future<Users?> currentUser();
  Future<void> signInPhone(String phoneNo);
  Future<void> signOut();
  Future<bool> verifyOtp(String otp);
  Future<bool> checkUser();
  Future<String> registerUser(
      String name, String vehicleNo, String vehicleName, String college);
  Future<bool> updateUser(String name, String phoneNo, String college);
  Future<bool> updateVehicle(String vname, String vNo);
  Future<Map<String, Object>> getUserDetails(String uid);
  Future<bool> updateStatus(String st, String uid);
  List<Trips> tripsFromFirestore(QuerySnapshot snapshot);
  Stream<List<Trips>> listTrips();
  Future<int> noOfTrips();
}

class Auth implements AuthClass {
  final _auth = FirebaseAuth.instance;
  var verificationId = '';

  Users? _userFromFirebase(User user) {
    if (user == null) {
      return null;
    }
    return Users(uid: user.uid);
  }

  @override
  Future<Users?> currentUser() async {
    final user = await _auth.currentUser;
    return _userFromFirebase(user!);
  }

  @override
  Future<void> signInPhone(String phoneNo) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNo,
      verificationCompleted: (PhoneAuthCredential credential) async {
        // await _auth.signInWithCredential(credential).then((value) {});
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          print("Invalid Number");
        } else {
          print(e);
        }
      },
      codeSent: (String verificationId, int? resendToken) {
        this.verificationId = verificationId;
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        this.verificationId = verificationId;
      },
    );
  }

  Future<bool> verifyOtp(String otp) async {
    var cred = await _auth.signInWithCredential(PhoneAuthProvider.credential(
      verificationId: this.verificationId,
      smsCode: otp,
    ));
    return cred.user != null ? true : false;
  }

  @override
  Future<void> signOut() async {
    await _auth.signOut();
  }

  @override
  Future<bool> checkUser() async {
    var user = true;
    final auth = FirebaseAuth.instance.currentUser;
    CollectionReference users = FirebaseFirestore.instance.collection('Users');
    await users.doc(auth?.uid).get().then((datasnapshot) => {
          if (!datasnapshot.exists) {user = false}
        });
    return user;
  }

  @override
  Future<String> registerUser(
      String name, String vehicleNo, String vehicleName, String college) async {
    try {
      final auth = FirebaseAuth.instance.currentUser;
      CollectionReference users =
          FirebaseFirestore.instance.collection('Users');
      var uid = _auth.currentUser?.uid;
      users.doc(auth?.uid.toString()).set({
        'Name': name,
        'VehicleNo': vehicleNo,
        'VehicleName': vehicleName,
        'College': college,
        'PhoneNo': auth?.phoneNumber,
        'UserID': auth?.uid.substring(0, 7),
        'Status': false,
      });
      return uid.toString();
    } catch (e) {
      print(e);
      return "";
    }
  }

  @override
  Future<Map<String, Object>> getUserDetails(String? uuid) async {
    CollectionReference users = FirebaseFirestore.instance.collection('Users');
    String name = "";
    String? num = "";
    String cllg = "";
    String vname = "";
    String vno = "";
    String uid = "";
    String? uuuid = _auth.currentUser?.uid;
    bool status = false;
    if (uuid!.isNotEmpty) {
      uuuid = uuid;
    }
    await users.doc(uuuid.toString()).get().then((DocumentSnapshot query) {
      Map<String, dynamic> data = query.data() as Map<String, dynamic>;
      name = data["Name"].toString();
      cllg = data["College"].toString();
      vname = data["VehicleName"].toString();
      vno = data["VehicleNo"].toString();
      status = data["Status"];
      uid = data["UserID"];
    });

    num = _auth.currentUser?.phoneNumber;
    return {
      'name': name,
      'num': num.toString(),
      'cllg': cllg,
      'vname': vname,
      'vno': vno,
      'status': status,
      'uid': uid,
      'uuid': uuuid!,
    };
  }

  @override
  Future<bool> updateUser(String name, String phoneNo, String college) async {
    try {
      CollectionReference users =
          FirebaseFirestore.instance.collection('Users');
      users.doc(_auth.currentUser?.uid).update({
        "Name": name,
        "PhoneNo": phoneNo,
        "College": college,
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  @override
  Future<bool> updateVehicle(String vname, String vNo) async {
    try {
      CollectionReference users =
          FirebaseFirestore.instance.collection('Users');
      users.doc(_auth.currentUser?.uid).update({
        'VehicleNo': vNo,
        'VehicleName': vname,
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  @override
  Future<bool> updateStatus(String st, String uid) async {
    try {
      CollectionReference users =
          FirebaseFirestore.instance.collection('Users');
      var sts = "";
      if (st == 'allowEntry') {
        sts = "Entered";
        await users.doc(uid).update({'Status': true});
      } else if (st == 'allowExit') {
        sts = "Exited";
        await users.doc(uid).update({'Status': false});
      }
      if (st != "Decline") {
        DateTime now = DateTime.now();
        String formattedDate = DateFormat('dd MMM, h:mm a').format(now);
        await users.doc(uid).collection('trips').doc().set({
          'DateTime': formattedDate,
          'Status': sts,
        });
      }
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  @override
  Stream<List<Trips>> listTrips() {
    CollectionReference users = FirebaseFirestore.instance.collection('Users');
    return users
        .doc(_auth.currentUser?.uid)
        .collection("trips")
        .snapshots()
        .map(tripsFromFirestore);
  }

  @override
  List<Trips> tripsFromFirestore(QuerySnapshot<Object?> snapshot) {
    return snapshot.docs.map(
      (e) {
        return Trips(status: e["Status"], dateTime: e["DateTime"]);
      },
    ).toList();
  }

  @override
  Future<int> noOfTrips() async {
    CollectionReference users = FirebaseFirestore.instance.collection('Users');
    var documentCount;
    await users
        .doc(_auth.currentUser?.uid)
        .collection("trips")
        .get()
        .then((value) => documentCount = value.docs.length);
    return documentCount;
  }
}
