import 'main.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget{

  @override
  Widget build(BuildContext context){

    
    final NetIDField =  TextField(
      style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0),
      decoration: InputDecoration(
        fillColor: Colors.white, filled: true,
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "NetID",
        border:
            OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final PasswordField = TextField(
      style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0),
      decoration: InputDecoration(
        fillColor: Colors.white, filled: true,
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Password",
        border:
            OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
          
    );


    final loginButton = Material(
          elevation: 5.0,
          borderRadius: BorderRadius.circular(30.0),
          color: Colors.red[900],
          child: MaterialButton(
            minWidth: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage()));
            },
            child: Text("Login",
                textAlign: TextAlign.center,
                style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0).copyWith(
                    color: Colors.white, fontWeight: FontWeight.bold)),
          ),
    );
      
    return Scaffold(
      body: Center(
        child: Container(
          color: Colors.white,
          child: Padding(

            padding: const EdgeInsets.all(36.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                
                SizedBox(
                  height: 200.0,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 30),
                    
                  child: Image.asset(
                    'assets/Sbu_logo.png',
                    fit: BoxFit.cover,
                  ),
                  ),
                  
                ),

                Text("SBU Bikeshare", style:TextStyle(fontFamily: 'Montserrat', fontSize: 40.0) ),

                SizedBox(height: 25.0),

                NetIDField,

                SizedBox(height: 25.0,),

                PasswordField,

                SizedBox(height: 35.0),

                loginButton,

              ],
            ),
          ),


        ),
      
      
      ),

    );
  }
}