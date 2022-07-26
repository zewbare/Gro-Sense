import 'package:flutter/material.dart';
import 'package:gro_sense/navigation.dart';

class User1 {
  final String name;
  final String email;
  final String location;
  final String photo;
  const User1(
      {required this.name,
      required this.email,
      required this.location,
      required this.photo});
}

class CreditScreen extends StatelessWidget {
  List<User1> Users = [
    User1(
        name: "Abdullah Ahmed",
        photo: "assets/avatar-boy.jpg",
        email: "ahmed5q@uwindsor.ca",
        location: "Canada"),
    User1(
        name: "Hetvi Khirsaria ",
        photo: "assets/avatar-girl.jpg",
        email: "khirsar@uwindsor.ca",
        location: "Canada"),
    User1(
        name: "Nency Patel",
        photo: "assets/avatar-girl.jpg",
        email: "patel3e5@uwindsor.ca",
        location: "Canada"),
    User1(
        name: "Nirali Amrutiya",
        photo: "assets/avatar-girl.jpg",
        email: "amrutiyn@uwindsor.ca",
        location: "Canada"),
    User1(
        name: "Zubair Ahmed",
        photo: "assets/avatar-boy.jpg",
        email: "ahmed8q@uwindsor.ca",
        location: "Canada"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Developers"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              // passing this to our root
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => MyBottomNavigation()));
            },
          ),
          automaticallyImplyLeading: false,
        ),
        backgroundColor: Color(0xFFF6F6F6),
        body: Column(
          children: Users.map((user) {
            return Container(
              margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
              child: ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                leading: CircleAvatar(
                    radius: 30, backgroundImage: AssetImage(user.photo)),
                title: Text(user.name),
                subtitle: Text(user.email),
                trailing: Text(user.location),
              ),
              padding: EdgeInsets.all(5),
              color: Color(0xFFFFFFFF),
            );
          }).toList(),
        ));
  }
}
