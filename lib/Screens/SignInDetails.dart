import 'dart:async';
import 'package:flutter/material.dart';


class SignInDetails extends StatefulWidget {
  const SignInDetails({Key? key}) : super(key: key);

  @override
  _SignInDetailsState createState() => _SignInDetailsState();
}
class _SignInDetailsState extends State<SignInDetails> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3),
            ()=>Navigator.pushNamed(context, '/bottom')

    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children:  [
               Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                child: TextFormField(
                  decoration: const  InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter company name',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                child: TextFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter your username',
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}
