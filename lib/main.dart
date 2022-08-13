import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fyp/Screens/BottomNavigation.dart';
import 'package:fyp/Screens/ResetPassword.dart';
import 'package:fyp/Screens/SignIn.dart';
import 'package:fyp/Screens/SignUp.dart';
import 'package:fyp/Screens/SignUpDetails.dart';
import 'package:fyp/Screens/Splash.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.grey));
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    // home: const GettingStarted(),
    theme: ThemeData(
      primaryColor: const Color(0xFF293b72),
    ),
    initialRoute: '/',
    routes: {
      // When navigating to the "/" route, build the HomeScreen widget.
      '/': (context) => const Splash(),
      '/signin': (context) => const SignIn(),
      '/signup': (context) => const SignUpScreen(),
      '/home': (context) => const BottomBarWidget(),
      '/reset': (context) => const ResetPassword(),
      '/details': (context) => const SignUpDetails(),

      // '/signUpDetails': (context) => const SignUpDetails(),
    },
  ));
}

