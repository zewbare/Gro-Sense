import 'package:flutter/material.dart';
import 'package:gro_sense/screens/developerList.dart';

import 'package:gro_sense/screens/first_screen.dart';
import 'package:gro_sense/navigation.dart';
import 'package:ionicons/ionicons.dart';
import 'package:gro_sense/Widget/settings_tile.dart';

import '../Widget/settings_tile.dart';
import '../navigation.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: Colors.green,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            // passing this to our root
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => MyBottomNavigation()));
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 0),
              SettingsTile(
                color: Colors.green,
                icon: Ionicons.moon_outline,
                title: "Developers",
                onTap: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => CreditScreen()));
                },
              ),
              const SizedBox(
                height: 20,
              ),
              SettingsTile(
                color: Colors.green,
                icon: Ionicons.log_out_outline,
                title: "Logout",
                onTap: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => FirstPage()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
