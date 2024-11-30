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
    apiKey: 'AIzaSyB6X9-qDzgTSyeEfVH8chKli9dk2okS18U',
    appId: '1:29552161066:web:c5acdfdfbc6b3892d8ee53',
    messagingSenderId: '29552161066',
    projectId: 'login-a7310',
    authDomain: 'login-a7310.firebaseapp.com',
    storageBucket: 'login-a7310.firebasestorage.app',
    measurementId: 'G-MSQ7ZH8W19',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCRhJeYawDv50XS4qDmTl1bh4Z3xMciw5w',
    appId: '1:29552161066:android:8e814d8297f3cdb4d8ee53',
    messagingSenderId: '29552161066',
    projectId: 'login-a7310',
    storageBucket: 'login-a7310.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAoeq7iqJTqM5WLMga3FAPB9HkRJDwgF5M',
    appId: '1:29552161066:ios:c3f206cf2818aa25d8ee53',
    messagingSenderId: '29552161066',
    projectId: 'login-a7310',
    storageBucket: 'login-a7310.firebasestorage.app',
    iosBundleId: 'com.example.login',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAoeq7iqJTqM5WLMga3FAPB9HkRJDwgF5M',
    appId: '1:29552161066:ios:c3f206cf2818aa25d8ee53',
    messagingSenderId: '29552161066',
    projectId: 'login-a7310',
    storageBucket: 'login-a7310.firebasestorage.app',
    iosBundleId: 'com.example.login',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyB6X9-qDzgTSyeEfVH8chKli9dk2okS18U',
    appId: '1:29552161066:web:db69f2cdf7063f06d8ee53',
    messagingSenderId: '29552161066',
    projectId: 'login-a7310',
    authDomain: 'login-a7310.firebaseapp.com',
    storageBucket: 'login-a7310.firebasestorage.app',
    measurementId: 'G-8QZF6VL7F8',
  );
}