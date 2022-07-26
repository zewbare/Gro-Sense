import 'package:flutter/material.dart';
import 'package:gro_sense/screens/dashboard.dart';
import 'package:gro_sense/screens/screen_login.dart';
import 'package:gro_sense/screens/dashboard.dart';

class EditProfileScreen extends StatelessWidget {
  @override
Widget build(BuildContext context){
  return Scaffold(
    appBar: AppBar(
      title: Text('Settings'),
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () {
          // passing this to our root
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => DashBoardScreen()));
        },
      ),
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