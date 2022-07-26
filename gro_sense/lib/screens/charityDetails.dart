import "package:flutter/material.dart";
import 'package:gro_sense/screens/dashboard.dart';
import 'package:gro_sense/navigation.dart';

class LocationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Local Food Banks"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            // passing this to our root
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => MyBottomNavigation()));
          },
        ),
      ),
      body: Scrollbar(
        child: ListView(children: const <Widget>[
          Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              margin: EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0),
              child: ListTile(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 14.0,
                    vertical: 1.0,
                  ),
                  title: Text(
                    "Downtown Mission of Windsor",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    "664 Victoria Avenue,Windsor,ON",
                    style: TextStyle(height: 2.0),
                  ),
                  leading: Icon(Icons.location_pin))),
          Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            margin: EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0),
            child: ListTile(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 14.0,
                  vertical: 1.0,
                ),
                title: Text(
                  "Windsor Essex Food Bank Association",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  "6955 Cantelon Dr,Windsor,ON",
                  style: TextStyle(height: 2.0),
                ),
                leading: Icon(Icons.location_pin)),
          ),
          Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            margin: EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0),
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(
                horizontal: 14.0,
                vertical: 1.0,
              ),
              title: Text(
                "Divine Mercy",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                "1074 Wyandotte St,Windsor,ON",
                style: TextStyle(height: 2.0),
              ),
              leading: Icon(Icons.location_pin),
            ),
          ),
          Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            margin: EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0),
            child: ListTile(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 14.0,
                  vertical: 1.0,
                ),
                title: Text(
                  "Food Banks Canada",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  "343 Wyandotte St,Windsor,ON",
                  style: TextStyle(height: 2.0),
                ),
                leading: Icon(Icons.location_pin)),
          ),
          Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            margin: EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0),
            child: ListTile(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 14.0,
                  vertical: 1.0,
                ),
                title: Text(
                  "Feeding Windsor",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  "999 Drouillard Rd,Windsor,ON",
                  style: TextStyle(height: 2.0),
                ),
                leading: Icon(Icons.location_pin)),
          ),
          Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            margin: EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0),
            child: ListTile(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 14.0,
                  vertical: 1.0,
                ),
                title: Text(
                  "Street Help",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  "964 wyandotte St ,Windsor,ON",
                  style: TextStyle(height: 2.0),
                ),
                leading: Icon(Icons.location_pin)),
          ),
          Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            margin: EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0),
            child: ListTile(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 14.0,
                  vertical: 1.0,
                ),
                title: Text(
                  "Salvation Army",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  "355 Church St ,Windsor,ON",
                  style: TextStyle(height: 2.0),
                ),
                leading: Icon(Icons.location_pin)),
          ),
          Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            margin: EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0),
            child: ListTile(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 14.0,
                  vertical: 1.0,
                ),
                title: Text(
                  "Windsor Lifeline Outreach",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  "4490 7th Concession Rd,Windsor,ON",
                  style: TextStyle(height: 2.0),
                ),
                leading: Icon(Icons.location_pin)),
          ),
          Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            margin: EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0),
            child: ListTile(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 14.0,
                  vertical: 1.0,
                ),
                title: Text(
                  "Ambassador Baptist Church",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  "3285 Manchester Rd,Windsor,ON",
                  style: TextStyle(height: 2.0),
                ),
                leading: Icon(Icons.location_pin)),
          ),
          Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0))),
              margin: EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 10.0, bottom: 20.0),
              child: ListTile(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 14.0,
                    vertical: 1.0,
                  ),
                  title: Text(
                    "Windsor Homes Coalition",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    "900 Howard Av,Windsor,ON",
                    style: TextStyle(height: 2.0),
                  ),
                  leading: Icon(Icons.location_pin))),
        ]),
      ),
    );
  }
}
