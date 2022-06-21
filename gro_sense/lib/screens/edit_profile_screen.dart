import 'package:flutter/material.dart';
import 'package:gro_sense/screens/dashboard.dart';
import 'package:gro_sense/screens/screen_login.dart';

class EditProfileScreen extends StatelessWidget {
  @override
Widget build(BuildContext context){
  return Scaffold(
    appBar: AppBar(
      title: Text('Settings'),
    ),
    body: Container(
    child: Drawer(
      child: ListView(
        children: [
          ListTile(title:
          Text('Edit my Profile'),
          onTap: (){
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => DashBoardScreen()));
          },),
        ListTile(title:
          Text('Notification'),
            onTap: (){

          },),
        ListTile(title:
         Text('Credits'),
           onTap: (){

         },),
      ListTile(title:
         Text('Logout'),
         onTap: (){
               Navigator.of(context).pushReplacement(
                   MaterialPageRoute(builder: (context) => LoginScreen()));
         },),
        ],
      )
    ),
    )
  );
}
}