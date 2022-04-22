import 'dart:async';
import 'package:flutter/material.dart';


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
            ()=>Navigator.pushNamed(context, '/boarding')

        );
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomRight,
            colors: [
              Color(0xF037cdff),
              Color(0x0000e1ff)
            ]
          )
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
       Text(
         "The Performance Yard",
         style: TextStyle(
           color: Colors.white,
           fontWeight: FontWeight.bold,
           fontSize: 30,
           fontFamily: 'Hind'
         ),
       )
        ]),
      ),
    );
  }
}
