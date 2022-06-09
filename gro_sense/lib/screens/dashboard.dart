import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: const Text("Dashboard"),
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
    ),
   bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30), topLeft: Radius.circular(30)),
          boxShadow: [
            BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
          ),
          child: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite), label: ('Favourite')),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite), label: ('Favourite'))
            ],
          ),
        )
      )
    );
  }
}