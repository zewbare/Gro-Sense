import 'package:flutter/material.dart';
import 'package:gro_sense/screens/dashboard.dart';
import 'package:gro_sense/screens/edit_profile_screen.dart';

class MyBottomNavigation extends StatefulWidget {
  @override
  _MyBottomNavigationState createState() => _MyBottomNavigationState();
}

class _MyBottomNavigationState extends State<MyBottomNavigation> {

  List pages =[
    DashBoardScreen(),
    // tabbarPage(),
    // AddaProductScreen(),
    EditProfileScreen(),
  ];
  int currentIndex = 0;
  void onTap(int index){
    setState((){
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: onTap,
        currentIndex: currentIndex,
        selectedItemColor: Colors.green[400],
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(label: "Home", icon: Icon(Icons.home)),
          BottomNavigationBarItem(label: "List",icon: Icon(Icons.format_list_bulleted_rounded)),
          BottomNavigationBarItem(label: "Add Product",icon: Icon(Icons.add)),
          BottomNavigationBarItem(label: "Charitable Trust",icon: Icon(Icons.share)),
          BottomNavigationBarItem(label: "Settings",icon: Icon(Icons.settings)),
        ],
      ),
    );
  }
}
