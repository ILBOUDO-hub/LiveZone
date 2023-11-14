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
    apiKey: 'AIzaSyBCLEAIjFVaMxuy7HGwU-9qvIfdW5rxcBs',
    appId: '1:1094287475458:web:230ed3d774b8fa92b5381b',
    messagingSenderId: '1094287475458',
    projectId: 'fourevent-ea1dc',
    authDomain: 'fourevent-ea1dc.firebaseapp.com',
    databaseURL: 'https://fourevent-ea1dc-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'fourevent-ea1dc.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC-plaWa7Vpya6Jwxron4wqL8f5XVXkNtg',
    appId: '1:1094287475458:android:5027b1675fc54406b5381b',
    messagingSenderId: '1094287475458',
    projectId: 'fourevent-ea1dc',
    databaseURL: 'https://fourevent-ea1dc-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'fourevent-ea1dc.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDdVmeL2662QJwSFTHspyVIjqKrYA3Klb4',
    appId: '1:1094287475458:ios:6a52fcd2abb3ce96b5381b',
    messagingSenderId: '1094287475458',
    projectId: 'fourevent-ea1dc',
    databaseURL: 'https://fourevent-ea1dc-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'fourevent-ea1dc.appspot.com',
    androidClientId: '1094287475458-upgi8momu5r0btvkk7u11tbgucd1cnit.apps.googleusercontent.com',
    iosClientId: '1094287475458-tr0ct2uoch5e1kh3hatbn5smva3059vj.apps.googleusercontent.com',
    iosBundleId: 'com.easyPass.client',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDdVmeL2662QJwSFTHspyVIjqKrYA3Klb4',
    appId: '1:1094287475458:ios.:47450e2af5cacfd8b5381b',
    messagingSenderId: '1094287475458',
    projectId: 'fourevent-ea1dc',
    databaseURL: 'https://fourevent-ea1dc-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'fourevent-ea1dc.appspot.com',
    androidClientId: '1094287475458-upgi8momu5r0btvkk7u11tbgucd1cnit.apps.googleusercontent.com',
    iosClientId: '1094287475458-5ov4lionofiipc58jkmfp4csdgflu40b.apps.googleusercontent.com',
    iosBundleId: '-h.eventproFlutter',
  );
}
