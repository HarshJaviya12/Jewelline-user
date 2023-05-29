import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:jewellineadmin/homepage.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'loginpage.dart';

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
      title: 'Jewelline Admin',
      theme: ThemeData(
        primaryColor: Colors.indigo,
      ),
      home: AnimatedSplashScreen(
          splash: Image.asset("asset/Admin.png"),
          splashIconSize: 300,
          splashTransition: SplashTransition.slideTransition,
          duration: 3000,
          nextScreen: user == null ? const loginpage(title: 'JEWELLINE') : homepage()),
    );

  }

}
