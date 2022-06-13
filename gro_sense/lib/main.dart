import 'package:flutter/material.dart';
import 'package:gro_sense/screens/dashboard.dart';
import 'package:gro_sense/screens/first_screen.dart';
import 'package:gro_sense/screens/screen_login.dart';
import 'package:firebase_core/firebase_core.dart';
Future<void> main() async  {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Gro-sense',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        debugShowCheckedModeBanner: false,
        home: FirstPage()
    );
  }
}

