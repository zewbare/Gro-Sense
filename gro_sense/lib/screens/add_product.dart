import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gro_sense/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gro_sense/screens/dashboard.dart';
import 'package:intl/intl.dart';
import 'package:gro_sense/screens/screen_login.dart';
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
  var defaultoption = 'reminders off';

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
/*
    //Expiry Date Field
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(), // Required
      lastDate: DateTime(2100),  // Required
    );

    DateTime selectedDate = new DateTime.now();
    _selectDate(BuildContext context) async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1950),
        lastDate: DateTime(2050),
        cancelText: 'Cancel',
        confirmText: 'Ok',
      );
      if (picked != null && picked != selectedDate)
        setState(() {
          selectedDate = picked;
        }
        );
      } */

      //No of Days before Expiry - Reminder
    final numberofDaysReminder= TextFormField
      (
      autofocus: false,
      controller: numberofDaysReminderEditingController,
      keyboardType: TextInputType.text,
      validator: (value) {
        if(value!.isEmpty)
        {
          return ("Please enter a value");
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
        hintText: "Get reminder - No of days before expiry",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    final submitButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.green[400],
     /* child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery
              .of(context)
              .size
              .width,
          onPressed: () {
            submit(ProductNameEditingController.text, DateTime);
          }, */
          child: Text(
            "Submit",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )
    );
   // );

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
                      children: <Widget>[
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
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                                lastDate: DateTime(2101)
                            );

                            if(pickedDate != null ){
                              print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                              String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                              print(formattedDate); //formatted date output using intl package =>  2021-03-16
                              //you can implement different kind of Date Format here according to your requirement

                              setState(() {
                                expirydateEditingController.text = formattedDate; //set output date to TextField value.
                              });
                            }else{
                              print("Date is not selected");
                            }
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
                        SizedBox(height: 15),
                        Text('$defaultoption', style: TextStyle(fontSize: 20),),
                        SizedBox(height: 20),
                        numberofDaysReminder,
                        SizedBox(height: 20),
                        submitButton,
                      ]),
                ),
              ),
            ),
          ),
        ),
      );
    }//Widget Build
/*
  void submit(String productName, DateTime selectedDate) async {
    if (_formKey.currentState!.validate()) {
      try {
        await auth
            .createUserWithEmailAndPassword(email: email, password: password)

            .then((uid) =>
        {
          Fluttertoast.showToast(msg: "signup Successful"),
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => DashBoardScreen()))
        })
            .then((value) => {postDetailsToFirestore()})
            .catchError((e) {
          Fluttertoast.showToast(msg: e!.message);
        });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Your email address appears to be malformed.";
            break;
          case "wrong-password":
            errorMessage = "Your password is wrong.";
            break;
          case "user-not-found":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "user-disabled":
            errorMessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          default:
            errorMessage = "An undefined Error happened.";
        }
        Fluttertoast.showToast(msg: errorMessage!);
        print(error.code);
      }
    }
  }

  postDetailsToFirestore() async {
    // calling our firestore
    // calling our user model
    // sending these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    UserModel userModel = UserModel();

    // writing all the values
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.firstName = firstNameEditingController.text;
    userModel.secondName = secondNameEditingController.text;

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account created successfully :) ");


  }
*/

} // Class _AddProductScreenState}