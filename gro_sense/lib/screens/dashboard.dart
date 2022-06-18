import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widget.dart';
import 'edit_profile_screen.dart';

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
                  child: Image(
                    image: AssetImage('assets/images/image.png'),
                    height: 50,
                    width: 50,
                  ),
                  margin: EdgeInsets.only(top: 32.0, bottom: 32.0),
                ),
                Expanded(
                    child: ListView(
                      children: [
                        TaskCardWidget(
                          title: "Get Started",
                          description:
                          "Hello User!! Welcome to our TO-DO application, which will track all your task.",
                        ),
                        TaskCardWidget(
                          title: "Task 1",
                          description: "Mark it as done!",
                        ),
                        TaskCardWidget(
                          title: "Task 2",
                          description: "Mark it as done!",
                        ),
                        TaskCardWidget(
                          title: "Task 3",
                          description: "Mark it as done!",
                        ),
                        TaskCardWidget(
                          title: "Task 4",
                          description: "Mark it as done!",
                        ),
                        TaskCardWidget(
                          title: "Task 5",
                          description: "Mark it as done!",
                        ),
                      ],
                    ))
              ],
            ),
          ]),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        elevation: 5.0,
        icon: const Icon(Icons.add),
        label: const Text('Add'),
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        // hasNotch: false,
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {},
            ),
            SizedBox(width: 20),
            IconButton(
              icon: Icon(Icons.card_giftcard_rounded),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => EditProfileScreen()));
              },
            )
          ],
        ),
      ),
    );
  }
}
