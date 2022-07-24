import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gro_sense/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ResetPasswordScreen extends StatefulWidget{
  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final auth = FirebaseAuth.instance;
  // editing controller
  String? errorMessage;
  final TextEditingController emailController = new TextEditingController();
  @override
  Widget build(BuildContext context) {

    final emailField = TextFormField(
        autofocus: false,
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Please Enter Your Email");
          }
          // reg expression for email validation
          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
              .hasMatch(value)) {
            return ("Please Enter a valid email");
          }
          // final list = FirebaseAuth.instance.fetchSignInMethodsForEmail(value);
          if( !FirebaseAuth.instance.fetchSignInMethodsForEmail(value).toString().isEmpty)
          {
            print("error");
            Fluttertoast.showToast(msg: "User don't exist");
            return ("User don't exist");
          }
          return null;
        },

        onSaved: (value) {
          emailController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.mail),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Email",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    final submitButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.green[400],
      child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery
              .of(context)
              .size
              .width,
          onPressed: () async {
            try{
              await  auth.sendPasswordResetEmail(email: emailController.text).then((uid) =>
              {
                Fluttertoast.showToast(
                    msg: "Reset password has been sent to your email"),
                Navigator.of(context).pop(),
              });
            } on FirebaseAuthException catch(error){
              switch (error.code) {
                case "user-not-found":
                  errorMessage = "User with this email doesn't exist.";
                  break;
                default:
                  errorMessage = "An undefined Error happened.";
              }
              Fluttertoast.showToast(msg: errorMessage!);
              print(error.code);
            }
          },
          child: Text(
            "Submit",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );


    return Scaffold(
      appBar: AppBar(
        title: Text('Reset Password'),
      ),
      body: Container(
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
                      SizedBox(height: 50),
                      Text('Enter your email Address below to reset password',
                        textAlign : TextAlign.center,
                        style: TextStyle(
                            color: Colors.green[400],
                            fontWeight: FontWeight.bold,
                            fontSize: 20),),
                      SizedBox(height: 70),
                      emailField,
                      SizedBox(height: 15,),
                      submitButton,
                      SizedBox(height: 15,),
                      GestureDetector(
                        child: Text(
                            "need to login?",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.green[400],
                              fontSize:15,
                            )
                        ),
                        onTap: (){
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context) => LoginScreen()));
                        },
                      ),
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}