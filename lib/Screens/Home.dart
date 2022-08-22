

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fyp/Screens/Employees.dart';
import 'package:fyp/Screens/Profile.dart';
import '../Widgets/Reusable-Widget.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);


  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  late String name;
  late String NTN;
  late String type;
  var employeeData;
  late var reversed;
  var highestRated;
  final firebaseUser = FirebaseAuth.instance.currentUser!;

  @override
  initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('userData').doc(firebaseUser.uid).collection('employeeData').orderBy('last_evaluation')
        .get();
    // Get data from docs and convert map to List
    var data = querySnapshot.docs.map((doc) => doc.data()).toList();

    employeeData = data;
    if (employeeData !=null) {
      print(1);
    }
    reversed = data.reversed.toList();
    highestRated = reversed.sublist(0,3);
    highestRated.forEach((element) => print(element["name"]));
  }
   getUser() async {
     await FirebaseFirestore.instance
    .collection('userData')
    .doc(firebaseUser.uid)
    .get()
    .then((ds) {
    name = ds.data()!['companyName'];
    type = ds.data()!['companyType'];
    NTN = ds.data()!['NTNNumber'];
    }).catchError((e) {
    if (kDebugMode) {
    print(e);
    }
    });
   }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('Assets/Logo.png', height: 35),
        backgroundColor: Colors.green,
          actions: <Widget>[
      Padding(
      padding: const EdgeInsets.only(right: 20.0),
        child:   IconButton(
          icon: const Icon(Icons.person_outline),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Profile(name: name, type: type, NTN: NTN),
                  ));
              }
        ),
    ),
        ],
        actionsIconTheme: const IconThemeData(
            size: 30.0,
            color: Colors.white,
            opacity: 10.0
        ),
      ),
      body: FutureBuilder(
        future: getUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done || highestRated == null) {
            return loader(context);
          }
      return homeScreen(context, name, highestRated);
        },
      ),
    );

  }
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('highestRated', highestRated));
  }
}

Widget homeScreen(BuildContext context, String name, highestRated) {
  return SingleChildScrollView(
  child:
    Container(
    padding: const EdgeInsets.fromLTRB(15,15,0,0),
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height,
    decoration: const BoxDecoration(
  image: DecorationImage(
  image: AssetImage("Assets/background.png"),
  fit: BoxFit.cover,
  )),
    child:   Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[   const SizedBox(
        height: 25,
      ), Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),  // radius of 10
              color: Colors.lightGreen  // green as background color
          ),
          height: 80,
          width: 300,
          alignment: Alignment.center,
          padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
          child:
          const Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 20, 20),
              child:  Text("Top performers of our company", style:TextStyle(fontSize: 18, color: Colors.white), textAlign: TextAlign.center,
              ))
        ,

      ), const SizedBox(
        height: 25,
      ),
        ListView.builder(
            physics: ScrollPhysics(),
            shrinkWrap: true,
            itemCount:highestRated.length,
            itemBuilder: (context,index){
              return Center(
                child: Column(
                  children: <Widget>[
                    const SizedBox(
                      height: 35,
                    ),
                    Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),  // radius of 10
                            color: Colors.lightBlue  // green as background color
                        ),
                        height: 75,
                        width: 200,
                        alignment: Alignment.center,
                        child:  Text("${highestRated[index]['name']}", style:const TextStyle(fontSize: 14, color: Colors.white), textAlign: TextAlign.center,
                        )
                    ),
                  ],
                ),
              );
              }),
        const SizedBox(
          height: 20,
        ),
        firebaseUIInAppButton(context, "Employees", () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => Employees()));
        })
    ],
    ),
    )
  );
}

Widget loader(BuildContext context) {
  return  Center(child:Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
      child: const Text('Waiting for data...',
          style: TextStyle(fontSize: 22)
      )
  )
  );
}





