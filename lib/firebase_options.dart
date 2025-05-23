// lib/firebase_options.dart

import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) return web;
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      default:
        throw UnsupportedError('Bu platform desteklenmiyor');
    }
  }

  // Web için (Console'dan aldığın Web config'i buraya yapıştır)
  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'YOUR_WEB_API_KEY',
    authDomain: 'clarxcore-app.firebaseapp.com',
    projectId: 'clarxcore-app',
    storageBucket: 'clarxcore-app.appspot.com',
    messagingSenderId: '831653477651',
    appId: 'YOUR_WEB_APP_ID',
  );

  // Android için (GoogleService-Info.json içinden kopyala)
  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'YOUR_ANDROID_API_KEY',
    appId: 'YOUR_ANDROID_APP_ID',
    messagingSenderId: '831653477651',
    projectId: 'clarxcore-app',
    storageBucket: 'clarxcore-app.appspot.com',
  );

  // iOS için (GoogleService-Info.plist içinden kopyala)
  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'YOUR_IOS_API_KEY',
    appId: 'YOUR_IOS_APP_ID',
    messagingSenderId: '831653477651',
    projectId: 'clarxcore-app',
    storageBucket: 'clarxcore-app.appspot.com',
    iosClientId: 'YOUR_IOS_CLIENT_ID',
    iosBundleId: 'com.clarxc.clarxcore_app',
  );
}
