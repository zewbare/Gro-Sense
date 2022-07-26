import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:gro_sense/screens/dashboard.dart';
import 'package:gro_sense/screens/first_screen.dart';
import 'package:gro_sense/screens/screen_login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gro_sense/navigation.dart';
Future<void> main() async  {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {

  final storage = new FlutterSecureStorage();

  Future<bool> checkLoginStatus() async {
    String? value = await storage.read(key: "uid");
    if(value == null){
      return false;
    }
    return true;
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Gro-sense',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        debugShowCheckedModeBanner: false,
        home: FutureBuilder(
            future: checkLoginStatus(),
            builder: (
                BuildContext context, AsyncSnapshot<bool>
                snapshot){
              if(snapshot.data == false){
                return FirstPage();
              }
              return MyBottomNavigation();
            })
    );
  }
}

