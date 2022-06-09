import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gro_sense/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome"),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,

        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/logo.png"),
            colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.dstATop),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 150,
              ),
              Text(
                "Welcome Back",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text("${loggedInUser.firstName} ${loggedInUser.secondName}",
                  style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                  )),
              Text("${loggedInUser.email}",
                  style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                  )),
              SizedBox(
                height: 15,
              ),
              Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.green[400],
                  child: MaterialButton(
                      padding: EdgeInsets.fromLTRB(20, 5, 10, 15),
                      minWidth: MediaQuery
                          .of(context)
                          .size
                          .width,
                      onPressed: () {
                        logout(context);                      },
                      child: Text(
                        "Logout",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                      )),
              ),
          ]),
        ),
      ),
    );
  }

  // the logout function
  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()));
  }
}