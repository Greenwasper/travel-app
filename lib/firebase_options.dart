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
    apiKey: 'AIzaSyBjPNXlb_i2BsY-01fdJJsO2dG1Ovc7cmU',
    appId: '1:1020457283545:web:d01c22065442cc9febb3c8',
    messagingSenderId: '1020457283545',
    projectId: 'travel-app-7ac15',
    authDomain: 'travel-app-7ac15.firebaseapp.com',
    storageBucket: 'travel-app-7ac15.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAKiML3JpSzgCfMgszfe3eOi4ixDKuJYyY',
    appId: '1:1020457283545:android:e2796217cb633c20ebb3c8',
    messagingSenderId: '1020457283545',
    projectId: 'travel-app-7ac15',
    storageBucket: 'travel-app-7ac15.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAKBbC64HIqNW1fzIBB_gXx2gDBeCoqfzg',
    appId: '1:1020457283545:ios:a3e0f542211abe17ebb3c8',
    messagingSenderId: '1020457283545',
    projectId: 'travel-app-7ac15',
    storageBucket: 'travel-app-7ac15.appspot.com',
    iosBundleId: 'com.example.travel',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAKBbC64HIqNW1fzIBB_gXx2gDBeCoqfzg',
    appId: '1:1020457283545:ios:a3e0f542211abe17ebb3c8',
    messagingSenderId: '1020457283545',
    projectId: 'travel-app-7ac15',
    storageBucket: 'travel-app-7ac15.appspot.com',
    iosBundleId: 'com.example.travel',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBjPNXlb_i2BsY-01fdJJsO2dG1Ovc7cmU',
    appId: '1:1020457283545:web:3e988d758a9c9ce7ebb3c8',
    messagingSenderId: '1020457283545',
    projectId: 'travel-app-7ac15',
    authDomain: 'travel-app-7ac15.firebaseapp.com',
    storageBucket: 'travel-app-7ac15.appspot.com',
  );
}