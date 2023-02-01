import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
  Future<bool> registerUser(
      String name, String vehicleNo, String vehicleName, String college);
  Future<Map<String, String>> getUserDetails();
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
      verificationCompleted: (PhoneAuthCredential credential) {
        // await _auth.signInWithCredential(credential).then((value) async {
        //     print("verficationCompleted  :  Logged in");
        //    });
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
  Future<bool> registerUser(
      String name, String vehicleNo, String vehicleName, String college) async {
    try {
      final auth = FirebaseAuth.instance.currentUser;
      CollectionReference users =
          FirebaseFirestore.instance.collection('Users');
      print(auth?.uid.toString());
      users.doc(auth?.uid).set({
        'Name': name,
        'VehicleNo': vehicleNo,
        'VehicleName': vehicleName,
        'College': college,
        'UserID': auth?.uid,
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  @override
  Future<Map<String, String>> getUserDetails() async{
    CollectionReference users = FirebaseFirestore.instance.collection('Users');
    String name = "";
    String? num = "";
    String cllg = "";
    num = _auth.currentUser?.phoneNumber;
    await users.doc(_auth.currentUser?.uid).get().then((DocumentSnapshot query) {
      Map<String, dynamic> data = query.data() as Map<String, dynamic>;
      name = data["Name"].toString();
      cllg = data["College"].toString();
    });
    return {
      'name': name,
      'num' : num.toString(),
      'cllg': cllg,
    };
  }
}
