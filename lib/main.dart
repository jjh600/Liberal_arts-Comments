import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eck_app/screens/home.dart';
import 'package:eck_app/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.black26,
      statusBarBrightness: Brightness.light
    )
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Splash(),
      theme: ThemeData(
          fontFamily: 'NanumSquare',
          scaffoldBackgroundColor: Color(0xfff2f6fd)),
      routes: {
        "/home": (_) => new Home(),
      },
    );
  }
}

// ignore: must_be_immutable
class Splash extends StatelessWidget {
  QuerySnapshot user;
  @override
  Widget build(BuildContext context) {
    // ignore: todo
    // TODO: implement build
    return StreamBuilder<User>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return AuthPage();
          } else {
            return StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .where('userId', isEqualTo: snapshot.data.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return AuthPage();
                } else {
                  return Home();
                }
              },
            );
          }
        });
  }
}
