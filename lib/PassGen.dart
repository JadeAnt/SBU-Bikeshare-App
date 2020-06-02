import 'package:flutter/material.dart';
import 'dart:math';

class PassGen extends StatefulWidget{
  get changePassCode => null;

  @override
  PassGenState createState() => new PassGenState();
}

class PassGenState extends State<PassGen>{

  String _password = "";
 // Code to generate the code for the bikestations //
  // FOR DEMONSTRATIONS ONLY//
  String passcodeGenerator(){
    var rng = new Random();
    var pass = "";
    for (var i = 0; i < 5; i++) {
      pass += rng.nextInt(4).toString();
    }

    return pass;
  }

  @override
  void changePassCode(){
    setState(() {
      _password = passcodeGenerator();
    });
  }

  @override
  Widget build(BuildContext context){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Padding(
          padding: const EdgeInsets.all(12.0),
          child: Center(
            child: Text('0 bikes are available',
              style: TextStyle(
                fontFamily:  'Montserrat',
                fontWeight: FontWeight.bold,
                fontSize: 15.0
              ),
            ),
          ),
        ),
        
        new Padding(padding: const EdgeInsets.all(15.0), 
          child: Text("$_password",
            style: TextStyle(
              fontFamily:  'Montserrat',
              fontWeight: FontWeight.bold,
              fontSize: 30.0
            ),
          ),
        ),
         
        new Padding(
          padding: const EdgeInsets.all(15.0),
          child: Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(30.0),
            color: Colors.red[900],
            child: MaterialButton(
              minWidth: MediaQuery.of(context).size.width,
              padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              onPressed: changePassCode,
              child: Text("Generate Passcode",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0).copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ),
        ),
         
      ],
    );
  }
}
