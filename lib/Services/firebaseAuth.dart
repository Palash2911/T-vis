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
      verificationCompleted: (PhoneAuthCredential credential){
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
    return cred.user!=null ? true : false;
  }

  @override
  Future<void> signOut() async {
    await _auth.signOut();
  }

  @override
  Future<bool> checkUser() async{
    var user = true;
    final auth = FirebaseAuth.instance.currentUser;
    CollectionReference users = FirebaseFirestore.instance.collection('Users');
    await users.doc(auth?.uid).get().then((datasnapshot) => {
      if(!datasnapshot.exists)
        {
            user = false
        }
    });
    return user;
  }
}
