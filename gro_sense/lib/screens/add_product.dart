import 'dart:ffi';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gro_sense/Model/product_details.dart';
import 'package:gro_sense/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gro_sense/screens/dashboard.dart';
import 'package:intl/intl.dart';
import 'package:gro_sense/screens/screen_login.dart';
import 'package:gro_sense/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'edit_profile_screen.dart';

class AddaProductScreen extends StatefulWidget {
  const AddaProductScreen({Key? key}) : super(key: key);

  @override
  _AddaProductScreenState createState() => _AddaProductScreenState();

}

class _AddaProductScreenState extends State<AddaProductScreen>
{
  final _formKey = GlobalKey<FormState>();
  final auth = FirebaseAuth.instance;
  final productNameEditingController = new TextEditingController();
  final expirydateEditingController = new TextEditingController();
  final numberofDaysReminderEditingController = new TextEditingController();
  bool onoroff = false;
  var defaultoption = 'Reminders Off';
  DateTime? pickedDate;
  int? numberofdaysreminder;
  DateTime? reminderdate;

  void toggleSwitch(bool value)
  {

    if(onoroff == false)
    {
      setState(() {
        onoroff = true;
        defaultoption = 'Reminders On';
      });
      print('Reminders On');
    }
    else
    {
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
  Widget build(BuildContext context)
  {
    //Product Name Field
    final productNameField= TextFormField
      (
        autofocus: false,
        controller: productNameEditingController,
        keyboardType: TextInputType.text,
        validator: (value) {
          if(value!.isEmpty)
            {
             return ("Please enter a product name");
            }
          return null;
        },
        onSaved: (value) {
          productNameEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.account_circle_sharp),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Product Name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );


      //No of Days before Expiry - Reminder
    final numberofDaysReminder= TextFormField
      (
      autofocus: false,
      controller: numberofDaysReminderEditingController,
      keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
      textInputAction: TextInputAction.next,// Only numbers can be entered
        onSaved: (value) {
          numberofDaysReminderEditingController.text = value!;},
      validator: (value) {
        if(value!.isEmpty)
        {
          return ("Please enter a value");
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


    final submitButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(500),
      color: Colors.green[400],
      child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery
              .of(context)
              .size
              .width,
          onPressed: () {
              addDataUp();
          },
          child: Text(
            "Submit",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold, decorationThickness: 40),
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
                  MaterialPageRoute(builder: (context) => DashBoardScreen()));
            },
          ),
        ),
        body: Container
          (
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/logo.png"),
              colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.dstATop),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: Container(
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.all(36.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children:<Widget>[
                        SizedBox(height: 20,),
                        productNameField,
                        SizedBox(height: 20),
                        TextField(
                          controller: expirydateEditingController, //editing controller of this TextField
                          decoration: InputDecoration(
                              icon: Icon(Icons.calendar_today), //icon of text field
                              labelText: "Enter Date" //label text of field
                          ),
                          readOnly: true,  //set it true, so that user will not able to edit text
                          onTap: () async {
                          pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.now(), //DateTime.now() - not to allow to choose before today.
                                lastDate: DateTime(2101),
                            );
                            if(pickedDate != null ){
                              print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000

                         //    numberofdaysreminder = int.tryParse(numberofDaysReminderEditingController.text);

                              //you can implement different kind of Date Format here according to your requirement
                        //    reminderdate = pickedDate?.subtract(Duration(days:- numberofdaysreminder!));
                            }else{
                              print("Date is not selected");
                            }
                          setState(() {
                          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate!);
                          print(formattedDate); //formatted date output using intl package =>  2021-03-16
                            expirydateEditingController.text = formattedDate; //set output date to TextField value.
                          });
                          },
              ),
                        Transform.scale(scale: 2),
                        Switch
                          (
                          value: onoroff,
                          onChanged: toggleSwitch,
                          activeColor: Colors.green,
                          activeTrackColor: Colors.lightGreenAccent[100],
                          inactiveThumbColor: Colors.grey[800],
                          inactiveTrackColor: Colors.grey[500],
                          ),
                        SizedBox(height: 1),
                        Text('$defaultoption',
                          style: TextStyle(fontSize: 20),),
                        SizedBox(height: 20),
                        if (onoroff == true)...
                          [
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
    }//Widget Build

  void addDataUp() async {
          Fluttertoast.showToast(msg: "Adding Products Successful");
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => DashBoardScreen()))
         .then((value) => {saveResultToFirebase()});
  }

  saveResultToFirebase() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    addprod addPro;

    addPro = addprod(productNameEditingController.text, pickedDate);
   // print(pickedDate);
    await FirebaseFirestore.instance
        .collection("users")
        .doc(currentUser!.uid)
        .update({
      "Add Product": FieldValue.arrayUnion([addPro.toMap()])

    });
  }

} //MAIN CLASS END