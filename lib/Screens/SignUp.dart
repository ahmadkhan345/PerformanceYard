import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Constants/Colors.dart';
import '../Widgets/Reusable-Widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
   TextEditingController _passwordTextController = TextEditingController();
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
          "Sign Up",
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
                padding: EdgeInsets.fromLTRB(30, 120, 30, 0),
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
                    reusableTextField("Enter Password", Icons.lock_outlined, true,
                        _passwordTextController),
                    const SizedBox(
                      height: 20,
                    ),
                    firebaseUIButton(context, "Sign Up", () {
                      FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                          email: _emailTextController.text,
                          password: _passwordTextController.text)
                          .then((value) {
                        print("Created New Account");
                        Navigator.pushReplacementNamed(context, '/details');
                      }).onError((error, stackTrace) {
                        showAlertDialog(context, error.toString());
                      });
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