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
    apiKey: 'AIzaSyBTweKR0Wv-0l31zPpFyw1hnrxjLzHI6vw',
    appId: '1:353153007048:android:68f5669a5a2134806c54fd',
    messagingSenderId: '353153007048',
    projectId: 'shoppinglist-2af1a',
    databaseURL: 'https://shoppinglist-2af1a-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'shoppinglist-2af1a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC6rkX4tL04EhHb7JcXuihxnl45VEgk1Pc',
    appId: '1:353153007048:ios:8eeeb4fe33a593386c54fd',
    messagingSenderId: '353153007048',
    projectId: 'shoppinglist-2af1a',
    databaseURL: 'https://shoppinglist-2af1a-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'shoppinglist-2af1a.appspot.com',
    iosBundleId: 'com.example.chatApp',
  );

}