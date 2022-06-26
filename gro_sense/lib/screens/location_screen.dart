import "package:flutter/material.dart";
import 'package:gro_sense/screens/dashboard.dart';
class LocationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Local Food Banks"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
        // passing this to our root
          Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => DashBoardScreen()));
          },
      ),
      ),
      body: Scrollbar(
      child:
      ListView(
      children: const <Widget>[
    Card(child:
    ListTile( title: Text("Downtown Mission of Windsor",style:TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
        subtitle: Text("664 Victoria Avenue,Windsor,ON"),
        leading: Icon(Icons.location_pin)
      )
    ),
    Card(child:
    ListTile( title: Text("Windsor Essex Food Bank Association",style:TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
    subtitle: Text("6955 Cantelon Dr,Windsor,ON"),
    leading: Icon(Icons.location_pin)
    ),
    ),
    Card(child: ListTile( title: Text("Divine Mercy",style:TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),subtitle: Text("1074 Wyandotte St,Windsor,ON"), leading: Icon(Icons.location_pin)),),
    Card(child:ListTile( title: Text("Food Banks Canada",style:TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),subtitle: Text("343 Wyandotte St,Windsor,ON"), leading: Icon(Icons.location_pin)),),
    Card(child:ListTile( title: Text("Feeding Windsor",style:TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),subtitle: Text("999 Drouillard Rd,Windsor,ON"), leading: Icon(Icons.location_pin)),),
    Card(child:ListTile( title: Text("Street Help",style:TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),subtitle: Text("964 wyandotte St ,Windsor,ON"), leading: Icon(Icons.location_pin)),),
    Card(child: ListTile( title: Text("Salvation Army",style:TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),subtitle: Text("355 Church St ,Windsor,ON"), leading: Icon(Icons.location_pin)),),
    Card(child: ListTile( title: Text("Windsor Lifeline Outreach",style:TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),subtitle: Text("4490 7th Concession Rd,Windsor,ON"), leading: Icon(Icons.location_pin)),),
    Card(child:ListTile( title: Text("Ambassador Baptist Church",style:TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),subtitle: Text("3285 Manchester Rd,Windsor,ON"), leading: Icon(Icons.location_pin)),),
    Card(child: ListTile( title: Text("Windsor Homes Coalition",style:TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),subtitle: Text("900 Howard Av,Windsor,ON"), leading: Icon(Icons.location_pin))),
      ]),
    ),
    );
  }
}