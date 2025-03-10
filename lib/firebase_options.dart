// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDaCleDyYcXCBnmMH8AeOULbsLFFaz9-lk',
    appId: '1:552723206130:web:1ed2e100b6c908e242256b',
    messagingSenderId: '552723206130',
    projectId: 'spoco-cc192',
    authDomain: 'spoco-cc192.firebaseapp.com',
    storageBucket: 'spoco-cc192.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAJ7vwT_AJQ8PE3pUhuJyfXIxtzbJXdZm8',
    appId: '1:552723206130:android:4380b69c1a9b61e842256b',
    messagingSenderId: '552723206130',
    projectId: 'spoco-cc192',
    storageBucket: 'spoco-cc192.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBQ1w__YSB3UcGf21DAayUDcyBI12GHHmU',
    appId: '1:552723206130:ios:02939de90606529c42256b',
    messagingSenderId: '552723206130',
    projectId: 'spoco-cc192',
    storageBucket: 'spoco-cc192.appspot.com',
    iosBundleId: 'com.example.spocoApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBQ1w__YSB3UcGf21DAayUDcyBI12GHHmU',
    appId: '1:552723206130:ios:02939de90606529c42256b',
    messagingSenderId: '552723206130',
    projectId: 'spoco-cc192',
    storageBucket: 'spoco-cc192.appspot.com',
    iosBundleId: 'com.example.spocoApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDaCleDyYcXCBnmMH8AeOULbsLFFaz9-lk',
    appId: '1:552723206130:web:1a57fbded3d09d2d42256b',
    messagingSenderId: '552723206130',
    projectId: 'spoco-cc192',
    authDomain: 'spoco-cc192.firebaseapp.com',
    storageBucket: 'spoco-cc192.appspot.com',
  );
}
