
import 'package:flutter/material.dart';

class Boarding extends StatelessWidget{
  const Boarding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("Assets/salary.jpg",),
          ),
          color: Colors.white
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children:  [
             ElevatedButton(
                 style: ButtonStyle(
                   foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                 ),
                 onPressed: () { Navigator.pushNamed(context, '/login'); },
               child: const Text("Login",
                style: TextStyle(
                  color: Colors.white
                ),
               ),
             ),
              const Padding(
                padding: EdgeInsets.only(bottom: 55)
              )
            ]),
      ),
    );
  }
  
}