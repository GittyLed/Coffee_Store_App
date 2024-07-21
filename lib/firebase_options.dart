import 'package:firebase_core/firebase_core.dart';

class DefaultFirebaseOptions{
  static FirebaseOptions get currentPlatform{
    return android;
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: "AIzaSyCZW6Pkhb_uwtPxy4id9F1MZXx63nE4gbo",
    appId: "1:417851364613:android:6923b64aa9778643b7136c",
    projectId: "coffee-app-981dd",
    messagingSenderId: "417851364613",
    storageBucket: "coffee-app-981dd.appspot.com",
  );
}