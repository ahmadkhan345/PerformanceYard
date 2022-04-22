
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:fyp/Screens/HomePage.dart';

class SignUpIn extends StatelessWidget {
  const SignUpIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => StreamBuilder<User?>(
    stream: FirebaseAuth.instance.authStateChanges(),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        return const HomePage();
      }
      else {
        return const SignInScreen(
          providerConfigs: [
            EmailProviderConfiguration(),
          ],
        );
          }
    }
  );
}