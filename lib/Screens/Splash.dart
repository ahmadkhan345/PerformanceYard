import 'dart:async';
import 'package:flutter/material.dart';
import '../Constants/Colors.dart';


class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}
class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3),
            ()=>Navigator.pushReplacementNamed(context, '/signin')

        );
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration:  BoxDecoration(
            gradient: LinearGradient(colors: [
              hexStringToColor("42ded1"),
              hexStringToColor("21bfae"),
              hexStringToColor("07635e")
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children:  [
               Image.asset('Assets/Logo.png',
                 height: 250,
                 width: 200,)
            ]
        ),
      ),
    );
  }
}
