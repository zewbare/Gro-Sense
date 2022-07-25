import 'package:flutter/material.dart';
import 'package:gro_sense/screens/developerList.dart';
import 'package:gro_sense/screens/dashboard.dart';
import 'package:gro_sense/screens/landingScreen.dart';
import 'package:gro_sense/utils/navigation.dart';
import 'package:ionicons/ionicons.dart';
import 'package:gro_sense/Widgets/settings_tile.dart';

import '../Widget/settings_tile.dart';
import 'notification.dart';

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
              // const SizedBox(
              //   height: 10,
              // ),
              // SettingsTile(
              //   color: Colors.green,
              //   icon: Ionicons.pencil_outline,
              //   title: "Edit Profile",
              //   onTap: () {},
              // ),
              // const SizedBox(
              //   height: 40,
              // ),
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
                height: 40,
              ),
              // SettingsTile(
              //   color: Colors.green,
              //   icon: Ionicons.pencil_outline,
              //   title: "Notification",
              //   onTap: () {
              //     Navigator.of(context).pushReplacement(
              //         MaterialPageRoute(builder: (context) => NotificationScreen()));
              //   },
              // ),
              const SizedBox(
                height: 40,
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