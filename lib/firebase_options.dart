// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAPGQjz8FQGPxjT3by1x4Q-hSY2opdh6oo',
    appId: '1:714610393483:android:fefa90450cd0ba3d02ef8e',
    messagingSenderId: '714610393483',
    projectId: 'tvis-d8f5a',
    storageBucket: 'tvis-d8f5a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAAKnbB-Fn45m4SiMIS5hrT3Qlwy980tt8',
    appId: '1:714610393483:ios:fd3c9f1cec0b252702ef8e',
    messagingSenderId: '714610393483',
    projectId: 'tvis-d8f5a',
    storageBucket: 'tvis-d8f5a.appspot.com',
    androidClientId: '714610393483-8k3ribubed84cnjaokoa5cg7l5lq9qo2.apps.googleusercontent.com',
    iosClientId: '714610393483-4ji40ejhv9tvt62t7coi0gcm5hn848a0.apps.googleusercontent.com',
    iosBundleId: 'com.example.tvis',
  );
}