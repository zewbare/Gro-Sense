import 'package:flutter/material.dart';
import 'package:gro_sense/screens/screen_login.dart';
import 'package:gro_sense/screens/registration_screen.dart';

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.green[400],
      child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => LoginScreen()));
          },
          child: Text(
            "Login",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );
    final signUpButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.green[400],
      child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => RegistrationScreen()));
          },
          child: Text(
            "SignUp",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );

    return Scaffold(
        body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/logo.png"),
                colorFilter: new ColorFilter.mode(
                    Colors.black.withOpacity(0.3), BlendMode.dstATop),
                fit: BoxFit.cover,
              ),
            ),
            child: SingleChildScrollView(
              child: Container(
                color: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.all(36.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: 100),
                        Text(
                          "GRO-SENSE",
                          style: TextStyle(
                              color: Colors.green[400],
                              fontWeight: FontWeight.bold,
                              fontSize: 50),
                        ),
                        SizedBox(height: 100),
                        SizedBox(height: 35),
                        loginButton,
                        SizedBox(height: 25),
                        Text("OR"),
                        SizedBox(height: 25),
                        signUpButton,
                        SizedBox(height: 15),
                      ]),
                ),
              ),
            )
        )
    );
  }
}
