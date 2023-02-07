import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

import '../models/Trips.dart';

class Users {
  Users({required this.uid});
  final String uid;
}

abstract class AuthClass {
  Future<void> signInPhone(String phoneNo);
  Future<void> signOut();
  Future<bool> verifyOtp(String otp);
  Future<bool> checkUser();
  Future<String> registerUser(
      String name, String vehicleNo, String vehicleType, String college, String gender);
  Future<bool> updateUser(String name, String phoneNo, String gender);
  Future<bool> updateVehicle(String vType, String vNo, String college);
  Future<Map<String, Object>> getUserDetails(String uid);
  Future<bool> updateStatus(String st, String uid);
  List<Trips> tripsFromFirestore(QuerySnapshot snapshot);
  Stream<List<Trips>> listTrips();
  Future<int> noOfTrips();
  Future<int> noOfVehicles();
}

class Auth implements AuthClass {
  final _auth = FirebaseAuth.instance;
  var verificationId = '';

  @override
  Future<void> signInPhone(String phoneNo) async {
    try {
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
    } catch (e) {
      print(e);
    }
  }

  Future<bool> verifyOtp(String otp) async {
    try {
      var cred = await _auth.signInWithCredential(PhoneAuthProvider.credential(
        verificationId: this.verificationId,
        smsCode: otp,
      ));
      return cred.user != null ? true : false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  @override
  Future<void> signOut() async {
    await _auth.signOut();
  }

  @override
  Future<bool> checkUser() async {
    try {
      var user = true;
      final auth = FirebaseAuth.instance.currentUser;
      CollectionReference users =
          FirebaseFirestore.instance.collection('Users');
      await users.doc(auth?.uid).get().then(
            (datasnapshot) => {
              if (!datasnapshot.exists) {user = false}
            },
          );
      return user;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<String> registerUser(
      String name, String vehicleNo, String vehicleType, String college, String gender) async {
    try {
      final auth = FirebaseAuth.instance.currentUser;
      CollectionReference users =
          FirebaseFirestore.instance.collection('Users');
      var uid = _auth.currentUser?.uid;
      users.doc(auth?.uid.toString()).set({
        'Name': name,
        'Gender': gender,
        'VehicleNo': vehicleNo,
        'VehicleType': vehicleType,
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
    try {
      CollectionReference users =
          FirebaseFirestore.instance.collection('Users');
      String name = "";
      String? num = "";
      String cllg = "";
      String vtype = "";
      String vno = "";
      String uid = "";
      String gender = "";
      String? uuuid = _auth.currentUser?.uid;
      bool status = false;
      if (uuid!.isNotEmpty) {
        uuuid = uuid;
      }
      await users.doc(uuuid.toString()).get().then((DocumentSnapshot query) {
        Map<String, dynamic> data = query.data() as Map<String, dynamic>;
        name = data["Name"].toString();
        cllg = data["College"].toString();
        vtype = data["VehicleType"].toString();
        vno = data["VehicleNo"].toString();
        status = data["Status"];
        uid = data["UserID"];
        gender = data["Gender"];
      });
      num = _auth.currentUser?.phoneNumber;
      return {
        'name': name,
        'num': num.toString(),
        'cllg': cllg,
        'vtype': vtype,
        'vno': vno,
        'status': status,
        'gender': gender,
        'uid': uid,
        'uuid': uuuid!,
      };
    } catch (e) {
      print(e);
      return {};
    }
  }

  @override
  Future<bool> updateUser(String name, String phoneNo, String gender) async {
    try {
      CollectionReference users =
          FirebaseFirestore.instance.collection('Users');
      users.doc(_auth.currentUser?.uid).update({
        "Name": name,
        "Gender": gender,
        "PhoneNo": phoneNo,
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  @override
  Future<bool> updateVehicle(String vtype, String vNo, String college) async {
    try {
      CollectionReference users =
          FirebaseFirestore.instance.collection('Users');
      users.doc(_auth.currentUser?.uid).update({
        'VehicleNo': vNo,
        'VehicleType': vtype,
        "College": college,
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
    try {
      CollectionReference users =
          FirebaseFirestore.instance.collection('Users');
      var documentCount;
      await users
          .doc(_auth.currentUser?.uid)
          .collection("trips")
          .get()
          .then((value) => documentCount = value.docs.length);
      return documentCount;
    } catch (e) {
      print(e);
      return 0;
    }
  }

  @override
  Future<int> noOfVehicles() async {
    try {
      CollectionReference users =
          FirebaseFirestore.instance.collection('Users');
      var vehCount;
      await users
          .where("Status", isEqualTo: true)
          .get()
          .then((value) => vehCount = value.docs.length);
      return vehCount;
    } catch (e) {
      print(e);
      return 0;
    }
  }
}
