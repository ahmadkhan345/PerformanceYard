import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fyp/Constants/Colors.dart';

import '../Widgets/Reusable-Widget.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController _emailTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        title: const Text(
          "Reset Password",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                hexStringToColor("42ded1"),
                hexStringToColor("21bfae"),
                hexStringToColor("07635e")
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 120, 20, 0),
                child: Column(
                  children: <Widget>[
                    const SizedBox(
                      height: 20,
                    ),
                    reusableTextField("Enter Email", Icons.person_outline, false,
                        _emailTextController),
                    const SizedBox(
                      height: 20,
                    ),
                    firebaseUIButton(context, "Reset Password", () async {
                      try {
                        await FirebaseAuth.instance
                            .sendPasswordResetEmail(
                            email: _emailTextController.text.trim())
                            .then((value) => Navigator.of(context).pop());
                      } catch(e) {
                        print((e));
                        showAlertDialog(context, e.toString());
                      }
                    })
                  ],
                ),
              ))),
    );
  }
}

showAlertDialog(BuildContext context, String message) {
  var test = message.replaceAll(RegExp('\\[.*?\\]'), '');

  // Create button
  Widget okButton = ElevatedButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
    },
    style: ButtonStyle (
        backgroundColor: MaterialStateProperty.all(Colors.green)
    ),
  );

  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    title: Center(child :Text("Performance Yard")),
    content: Row(
      children : <Widget>[
        Image.asset('Assets/Logo.png', height: 45, width :45,),
        Expanded(
          child: Text(
            "${test}",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.red,
            ),
          ),
        )
      ],
    ),    actions: [
    okButton,
  ],
    actionsPadding: const EdgeInsets.only(right: 100),
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  );

  // show the dialog
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return alert;
    },
  );
}