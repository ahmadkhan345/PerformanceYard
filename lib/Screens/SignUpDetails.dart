import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Constants/Colors.dart';
import '../Widgets/Reusable-Widget.dart';
import 'package:fyp/Models/userModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:localstorage/localstorage.dart';

class SignUpDetails extends StatefulWidget {
  const SignUpDetails({Key? key}) : super(key: key);

  @override
  _SignUpDetailsState createState() => _SignUpDetailsState();
}

class _SignUpDetailsState extends State<SignUpDetails> {
  final LocalStorage store =  LocalStorage('localstorage_app');


  late User user;
  Future<void>getUserData() async {
    User userData = FirebaseAuth.instance.currentUser!;
    setState(() {
      user= userData;
      store.setItem('uid', user.uid);
      final userID = json.encode({'uid': user.uid});
      store.setItem('userID', userID);
    });
  }


  UserModel usermodel = UserModel("","","");
  TextEditingController _companyNameController = TextEditingController();
  TextEditingController _companyTypeController = TextEditingController();
  TextEditingController _companyNTNController = TextEditingController();

  @override
  void initState(){
    super.initState();
    getUserData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery
            .of(context)
            .size
            .width,
        height: MediaQuery
            .of(context)
            .size
            .height,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              hexStringToColor("42ded1"),
              hexStringToColor("21bfae"),
              hexStringToColor("07635e")
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                30, MediaQuery
                .of(context)
                .size
                .height * 0.2, 30, 0),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 30,
                ),
                reusableTextField("Company Name", Icons.person_outline, false,
                    _companyNameController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("Company Type", Icons.add_business_outlined, false,
                    _companyTypeController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField("NTN Number", Icons.numbers_rounded, false,
                    _companyNTNController),
                const SizedBox(
                  height: 5,
                ),
                firebaseUIButton(context, "Update", () async {
                  usermodel.companyName = _companyNameController.text;
                  usermodel.companyType = _companyTypeController.text;
                  usermodel.ntnNumber =  _companyNTNController.text;
                  final uid = user.uid;
                   await FirebaseFirestore.instance.collection('userData').doc(uid).set(usermodel.toJson());
                  Navigator.pushNamed(context, '/reset');
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// showAlertDialog(BuildContext context, String message) {
//   var test = message.replaceAll(RegExp('\\[.*?\\]'), '');
//
//   // Create button
//   Widget okButton = ElevatedButton(
//     child: Text("OK"),
//     onPressed: () {
//       Navigator.of(context).pop();
//     },
//     style: ButtonStyle (
//         backgroundColor: MaterialStateProperty.all(Colors.green)
//     ),
//   );
//
//   // Create AlertDialog
//   AlertDialog alert = AlertDialog(
//     title: Center(child :Text("Performance Yard")),
//     content: Row(
//       children : <Widget>[
//         Image.asset('Assets/Logo.png', height: 45, width :45,),
//         Expanded(
//           child: Text(
//             "${test}",
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               color: Colors.red,
//             ),
//           ),
//         )
//       ],
//     ),    actions: [
//     okButton,
//   ],
//     actionsPadding: const EdgeInsets.only(right: 100),
//     backgroundColor: Colors.white,
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.circular(10),
//     ),
//
//   );
//
//   // show the dialog
//   showDialog(
//     context: context,
//     barrierDismissible: false,
//     builder: (BuildContext context) {
//       return alert;
//     },
//   );
// }