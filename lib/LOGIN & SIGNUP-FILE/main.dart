import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:jewellin_user/homepage.dart';
import 'package:jewellin_user/LOGIN%20&%20SIGNUP-FILE/loginpage.dart';

import '../bottamnavigate.dart';

final user = FirebaseAuth.instance.currentUser;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Main Page for signup',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: AnimatedSplashScreen(
          splash: Image.asset("asset/SplashScreen.png"),
          splashIconSize: 100,
          splashTransition: SplashTransition.slideTransition,
          duration: 3000,
          nextScreen: user == null
              ? const loginpage(title: 'JEWELLINE')
              : Bottamnavigate(
                  selectedindex: 0,
                )),
    );
  }
}
