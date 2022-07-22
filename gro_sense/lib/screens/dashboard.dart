import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widget.dart';

class FetchData {}

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  // final _auth = FirebaseAuth.instance;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          color: Color(0xFFF6F6F6),
          child: Stack(children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: 5.0,
                  ),
                  margin: EdgeInsets.only(top: 25.0, bottom: 10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome",
                        style: TextStyle(
                          color: Color(0x89000000),
                          fontSize: 16.0,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: 5.0,
                        ),
                        child: Text(
                          "Nirali Amrutiya", // To check
                          style: TextStyle(
                            fontSize: 22.0,
                            height: 1.0,
                            color: Color(0xFF000000),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(top: 2.0, bottom: 10.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image(
                        image: AssetImage("assets/banner1.png"),
                        width: double.infinity,
                      ),
                    )),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    // horizontal: 24.0,
                    vertical: 10.0,
                  ),
                  margin: EdgeInsets.only(bottom: 10.0),
                  decoration: BoxDecoration(
                    // color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Upcoming Expires",
                        style: TextStyle(
                          color: Color(0x9E000000),
                          fontSize: 20.0,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: 5.0,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                    child: ListView(
                  children: [
                    TaskCardWidget(
                      // priority: "High",
                      title: "Cookies",
                      description: "Expires in 2 days",
                    ),
                    TaskCardWidget(
                      // priority: "Low",
                      title: "Bread",
                      description: "Expires in 3 days",
                    ),
                    TaskCardWidget(
                      // priority: "Low",
                      title: "Milk",
                      description: "Expires in 5 days",
                    ),
                    TaskCardWidget(
                      // priority: "Medium",
                      title: "Spinach",
                      description: "Expires in 5 days",
                    ),
                  ],
                ))
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
