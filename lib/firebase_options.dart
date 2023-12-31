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
    apiKey: 'AIzaSyDXnm4FgZlGl9mfo7IQPoqrmlncjueRhbg',
    appId: '1:513782079872:web:da1804456139d6674c2165',
    messagingSenderId: '513782079872',
    projectId: 'whatsappclone-6538f',
    authDomain: 'whatsappclone-6538f.firebaseapp.com',
    storageBucket: 'whatsappclone-6538f.appspot.com',
    measurementId: 'G-7GX6LSDL9G',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDb0xlpblsYyppw8daD2rf89NvH9fAqazg',
    appId: '1:513782079872:android:41a68a1f866616fc4c2165',
    messagingSenderId: '513782079872',
    projectId: 'whatsappclone-6538f',
    storageBucket: 'whatsappclone-6538f.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBhTlnOr8wZQAn-wfN-X8PdPY7pXeNw3UY',
    appId: '1:513782079872:ios:70410c44bd48237d4c2165',
    messagingSenderId: '513782079872',
    projectId: 'whatsappclone-6538f',
    storageBucket: 'whatsappclone-6538f.appspot.com',
    iosClientId: '513782079872-1tpt8empcc7765csgahdso5cb3nj6c8f.apps.googleusercontent.com',
    iosBundleId: 'com.example.whatsappClone',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBhTlnOr8wZQAn-wfN-X8PdPY7pXeNw3UY',
    appId: '1:513782079872:ios:8a58b7e55ad41aa34c2165',
    messagingSenderId: '513782079872',
    projectId: 'whatsappclone-6538f',
    storageBucket: 'whatsappclone-6538f.appspot.com',
    iosClientId: '513782079872-379nkug85ujklnd3k0i5e51r1uq1vd27.apps.googleusercontent.com',
    iosBundleId: 'com.example.whatsappClone.RunnerTests',
  );
}
