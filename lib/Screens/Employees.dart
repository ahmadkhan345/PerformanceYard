import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fyp/Screens/EmployeeData.dart';
import '../Widgets/Reusable-Widget.dart';

class Employees extends StatefulWidget {
  const Employees({Key? key }) : super(key: key);


  @override
  _EmployeesState createState() => _EmployeesState();
}

class _EmployeesState extends State<Employees> {
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
        title: Text("Employees"),
        backgroundColor: Colors.green,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
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
          if (snapshot.connectionState != ConnectionState.done || employeeData == null) {
            return loader(context);
          }
          return homeScreen(context, name, employeeData);
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
    padding: const EdgeInsets.fromLTRB(15,5,0,0),
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
                      height: 5,
                    ),
                    firebaseUIEmployeeButton(context, highestRated[index]['name'] , () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  EmployeesData(employeeInfo : highestRated[index],
                          eval: highestRated[index]['last_evaluation'],proj: highestRated[index]['number_project'],
                          time: highestRated[index]['time_spend_company'],
                          months: highestRated[index]['average_monthly_hours'])));
                    })
                  ],
                ),
              );
            }),
        const SizedBox(
          height: 50,
        ),
      ],
    ),
  ),
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





