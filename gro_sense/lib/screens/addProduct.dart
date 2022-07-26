import 'dart:ffi';
import 'dart:io';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gro_sense/navigation.dart';
import 'package:intl/intl.dart';

import '../Model/product_details.dart';
import 'package:gro_sense/screens/dashboard.dart';

//imports for notification
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

import '../navigation.dart';

class AddaProductScreen extends StatefulWidget {
  const AddaProductScreen({Key? key}) : super(key: key);

  @override
  _AddaProductScreenState createState() => _AddaProductScreenState();
}

class _AddaProductScreenState extends State<AddaProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final auth = FirebaseAuth.instance;
  final productNameEditingController = new TextEditingController();
  final expirydateEditingController = new TextEditingController();
  final numberofDaysReminderEditingController = new TextEditingController();
  bool onoroff = false;
  var defaultoption = 'Reminders Off';

  late DateTime pickedDate;
  late String formattedDate;
  var reminderdate;
  late int numberofdaysreminder;
  bool isLoading = false;

  int getDate(String s) {
    int num = 0;
    int n = s.length;
    for (int i = 0; i < n; i++) {
      num = num * 10 + (int.parse(s[i]) - 48);
    }
    return num;
  }

  void toggleSwitch(bool value) {
    if (onoroff == false) {
      setState(() {
        onoroff = true;
        defaultoption = 'Reminders On';
      });
      print('Reminders On');
    } else {
      setState(() {
        onoroff = false;
        defaultoption = 'Reminders Off';
      });
      print('Reminders Off');
    }
  }

  @override
  void initState() {
    expirydateEditingController.text = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //Product Name Field
    final productNameField = TextFormField(
      autofocus: false,
      controller: productNameEditingController,
      keyboardType: TextInputType.name,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please enter a product name");
        }
        return null;
      },
      onSaved: (value) {
        productNameEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.add_shopping_cart_outlined),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Product Name",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    //No of Days before Expiry - Reminder
    final numberofDaysReminder = TextFormField(
      autofocus: false,
      controller: numberofDaysReminderEditingController,
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ],
      textInputAction: TextInputAction.next,

      // Only numbers can be entered
      onChanged: (value) async {
        numberofdaysreminder =
            int.parse(numberofDaysReminderEditingController.text);
        print(pickedDate);
        reminderdate = pickedDate.add(Duration(days: -numberofdaysreminder));
      },
      onSaved: (value) {
        numberofDaysReminderEditingController.text = value!;
      },
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please enter reminder days");
        }
        return null;
      },
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.account_circle_sharp),
        contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 20),
        hintText: "No of days for Reminder",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    final ExpiryFormField = TextFormField(
      controller:
          expirydateEditingController, //editing controller of this TextField
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please enter the date");
        }

        return null;
      },
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.calendar_today), //icon of text field
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Enter Date",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      readOnly: true, //set it true, so that user will not able to edit text
      onTap: () async {
        pickedDate = (await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime
              .now(), //DateTime.now() - not to allow to choose before today.
          lastDate: DateTime(2101),
        ))!;
        //pickedDate output format => 2021-03-10 00:00:00.000
        formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
        //formatted date output using intl package =>  2021-03-16
        //you can implement different kind of Date Format here according to your requiremen
        setState(() {
          expirydateEditingController.text =
              formattedDate; //set output date to TextField value.
          pickedDate = this.pickedDate;
        });
        /*print(pickedDate);*/
      },
    );

    final submitButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(500),
      color: Colors.green[400],
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            addDataUp();
          }

          if (reminderdate != null) {
            _showNotification();
          }
        },
        child: Text(
          "Submit",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 25,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              decorationThickness: 40),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Add a Product'),
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
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            // image: DecorationImage(
            //  image: AssetImage("assets/logo.png"),
            //  colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.dstATop),
            //fit: BoxFit.cover,
            // ),
            ),
        child: SingleChildScrollView(
          child: isLoading
              ? Container(
                  height: 300,
                  child: Center(
                    child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Colors.blueAccent),
                    ),
                  ),
                )
              : Container(
                  color: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.all(36.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              height: 20,
                            ),
                            productNameField,
                            SizedBox(height: 20),
                            ExpiryFormField,
                            Transform.scale(scale: 2),
                            Switch(
                              value: onoroff,
                              onChanged: toggleSwitch,
                              activeColor: Colors.green,
                              activeTrackColor: Colors.lightGreenAccent[100],
                              inactiveThumbColor: Colors.grey[800],
                              inactiveTrackColor: Colors.grey[500],
                            ),
                            SizedBox(height: 1),
                            Text(
                              '$defaultoption',
                              style: TextStyle(fontSize: 20),
                            ),
                            SizedBox(height: 20),
                            if (onoroff == true) ...[
                              SizedBox(height: 20),
                              numberofDaysReminder,
                            ],
                            SizedBox(height: 30),
                            submitButton,
                          ]),
                    ),
                  ),
                ),
        ),
      ),
    );
  } //Widget Build

  void addDataUp() async {
    saveResultToFirebase();
  }

  saveResultToFirebase() async {
    setState(() {
      isLoading = true;
    });
    User? currentUser = FirebaseAuth.instance.currentUser;
    addprod addPro;

    addPro =
        addprod(productNameEditingController.text, pickedDate, reminderdate);
    // print(pickedDate);
    await FirebaseFirestore.instance
        .collection("users")
        .doc(currentUser!.uid)
        .update({
      "Add Product": FieldValue.arrayUnion([addPro.toMap()])
    });
    setState(() {
      // isLoading = false;
    });
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => MyBottomNavigation()));
    Fluttertoast.showToast(msg: "Added Product Successfully !");
  }

  //notification
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future notificationSelected(String? payload) async {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => DashBoardScreen()));
  }

  Future<void> initNotification() async {
    //Android initialization
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: notificationSelected);
  }

  Future<void> _showNotification() async {
    var androidDetails = new AndroidNotificationDetails(
        "Channel ID", "Desi programmer",
        channelDescription: "This is my channel",
        importance: Importance.max,
        icon: "@mipmap/ic_launcher");

    var generalNotificationDetails =
        new NotificationDetails(android: androidDetails);

    tz.initializeTimeZones();

    var scheduledTime =
        DateTime.now().add(Duration(seconds: 15)); //reminder date variable here

    var time = tz.TZDateTime.from(scheduledTime, tz.local);

    await flutterLocalNotificationsPlugin.zonedSchedule(
        1,
        productNameEditingController.text,
        "This product is about to expire on $formattedDate",
        time,
        generalNotificationDetails,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.wallClockTime,
        androidAllowWhileIdle: true);
  }
} //MAIN CLASS END
