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
    apiKey: 'AIzaSyBJYe-aY-Oiv3DLZiz63ZOtLnY5o4KnjQo',
    appId: '1:863158316918:web:edd6d4e23b71e6b91dd457',
    messagingSenderId: '863158316918',
    projectId: 'chat-app-bacf8',
    authDomain: 'chat-app-bacf8.firebaseapp.com',
    storageBucket: 'chat-app-bacf8.appspot.com',
    measurementId: 'G-V1B1ZLWF2V',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDggu2WTI74QLTUzhEiKb3IT5V_iPs0DGc',
    appId: '1:863158316918:android:90df4e0e9e5bee161dd457',
    messagingSenderId: '863158316918',
    projectId: 'chat-app-bacf8',
    storageBucket: 'chat-app-bacf8.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB1D05yHwRTFlYWL1AOUz167-iVz0DVyY4',
    appId: '1:863158316918:ios:c06363f7b67f79b61dd457',
    messagingSenderId: '863158316918',
    projectId: 'chat-app-bacf8',
    storageBucket: 'chat-app-bacf8.appspot.com',
    iosClientId: '863158316918-o5f4621lvnk1ddtjegoubc4cn52knc7f.apps.googleusercontent.com',
    iosBundleId: 'com.example.chatApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB1D05yHwRTFlYWL1AOUz167-iVz0DVyY4',
    appId: '1:863158316918:ios:c06363f7b67f79b61dd457',
    messagingSenderId: '863158316918',
    projectId: 'chat-app-bacf8',
    storageBucket: 'chat-app-bacf8.appspot.com',
    iosClientId: '863158316918-o5f4621lvnk1ddtjegoubc4cn52knc7f.apps.googleusercontent.com',
    iosBundleId: 'com.example.chatApp',
  );
}
