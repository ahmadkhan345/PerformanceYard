import 'package:flutter/material.dart';
import '../Widgets/Reusable-Widget.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key,this.name,this.type,this.NTN}) : super(key: key);

   final name;
   final type;
   final NTN;
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.green,
      ),
      body:
      Container (
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("Assets/background.png"),
                fit: BoxFit.cover,
              )),
          child: Center(
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 150,
            ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),  // radius of 10
                      color: Colors.lightGreen  // green as background color
                  ),
                    height: 40,
                  width: 200,
                    alignment: Alignment.center,
                    child:  Text("${widget.name}", style:const TextStyle(fontSize: 18, color: Colors.white), textAlign: TextAlign.center,
                    )
                ),
            const SizedBox(
              height: 30,
            ),
            Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),  // radius of 10
                    color: Colors.lightGreen  // green as background color
                ),
                  height: 40,
                  width: 200,
                alignment: Alignment.center,
                child:  Text("${widget.type}", style:const TextStyle(fontSize: 18, color: Colors.white), textAlign: TextAlign.center,
                )
              ),
            const SizedBox(
              height: 30,
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),  // radius of 10
                  color: Colors.lightGreen  // green as background color
              ),
                 height: 40,
                 width: 200,
                alignment: Alignment.center,
                child:  Text("${widget.NTN}", style:const TextStyle(fontSize: 18, color: Colors.white), textAlign: TextAlign.center,
                )
              ),
            const SizedBox(
              height: 100,
            ),
            firebaseUIInAppButton(context, "Logout", () {
              FirebaseAuth.instance.signOut();
              Navigator.pushNamedAndRemoveUntil(context, '/signin', (_) => false);
            })
          ],
        ),
      )
    )
    );
  }
}