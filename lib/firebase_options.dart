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
    apiKey: 'AIzaSyBDRaXyZR23znbjkKFXFjXEqLcvCkVrvDQ',
    appId: '1:207691334290:web:54719a11f8783eea799c4b',
    messagingSenderId: '207691334290',
    projectId: 'snapcup-abc',
    authDomain: 'snapcup-abc.firebaseapp.com',
    storageBucket: 'snapcup-abc.appspot.com',
    measurementId: 'G-8SFPH4YKD5',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDZILPBsAwywLPcZ_MBFxkZz-SgLWjyk04',
    appId: '1:207691334290:android:51d41e7e7daacf9d799c4b',
    messagingSenderId: '207691334290',
    projectId: 'snapcup-abc',
    storageBucket: 'snapcup-abc.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBn93ntUPFY5oGvhGQ_XBOB2AtuM940Jp0',
    appId: '1:207691334290:ios:e791c6fe1903a23c799c4b',
    messagingSenderId: '207691334290',
    projectId: 'snapcup-abc',
    storageBucket: 'snapcup-abc.appspot.com',
    iosClientId: '207691334290-28aeeeie0qti4gkc7p7trji6nn5rmuv1.apps.googleusercontent.com',
    iosBundleId: 'com.example.snapcup',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBn93ntUPFY5oGvhGQ_XBOB2AtuM940Jp0',
    appId: '1:207691334290:ios:e791c6fe1903a23c799c4b',
    messagingSenderId: '207691334290',
    projectId: 'snapcup-abc',
    storageBucket: 'snapcup-abc.appspot.com',
    iosClientId: '207691334290-28aeeeie0qti4gkc7p7trji6nn5rmuv1.apps.googleusercontent.com',
    iosBundleId: 'com.example.snapcup',
  );
}