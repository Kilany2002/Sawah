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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyB77lntvgRFKQEAsRZJZ49zwr3OORW-xfI',
    appId: '1:348456949645:web:b4554c11abd626d8cbcfc4',
    messagingSenderId: '348456949645',
    projectId: 'ghazal-ab4a3',
    authDomain: 'ghazal-ab4a3.firebaseapp.com',
    storageBucket: 'ghazal-ab4a3.appspot.com',
    measurementId: 'G-MV9LNKM7CQ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCr_NgXG492rJZ32-lPs6Zzcd66iIFTJOk',
    appId: '1:348456949645:android:4d6f5e15d496985acbcfc4',
    messagingSenderId: '348456949645',
    projectId: 'ghazal-ab4a3',
    storageBucket: 'ghazal-ab4a3.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCJYB2gPnBCNW5CpAWonCT0975n5dt6zAA',
    appId: '1:348456949645:ios:e4fbc35e224984eecbcfc4',
    messagingSenderId: '348456949645',
    projectId: 'ghazal-ab4a3',
    storageBucket: 'ghazal-ab4a3.appspot.com',
    iosBundleId: 'com.example.kilaniiii',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCJYB2gPnBCNW5CpAWonCT0975n5dt6zAA',
    appId: '1:348456949645:ios:e4fbc35e224984eecbcfc4',
    messagingSenderId: '348456949645',
    projectId: 'ghazal-ab4a3',
    storageBucket: 'ghazal-ab4a3.appspot.com',
    iosBundleId: 'com.example.kilaniiii',
  );
}
