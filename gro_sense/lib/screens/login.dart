import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:gro_sense/screens/dashboard.dart';
import 'package:gro_sense/screens/landingScreen.dart';
import 'package:gro_sense/screens/home_screen.dart';
import 'package:gro_sense/screens/signUp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gro_sense/screens/resetPassword.dart';
import 'package:gro_sense/screens/addProduct.dart';
import 'package:gro_sense/utils/navigation.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen> {
  // form key
  final _formKey = GlobalKey<FormState>();

  // editing controller
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final storage = new FlutterSecureStorage();

  // firebase
  final _auth = FirebaseAuth.instance;

  // string for displaying the error Message
  String? errorMessage;

  @override
  Widget build(BuildContext context) {


    //email field
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

    final passwordField = TextFormField(
        autofocus: false,
        controller: passwordController,
        obscureText: true,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{6,}$');
          if (value!.isEmpty) {
            return ("Password is required for login");
          }
          if (!regex.hasMatch(value)) {
            return ("Enter Valid Password(Min. 6 Character)");
          }
        },
        onSaved: (value) {
          passwordController.text = value!;
        },
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    final loginButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.green[400],
      child: MaterialButton(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery
              .of(context)
              .size
              .width,
          onPressed: () {
            signIn(emailController.text, passwordController.text);
          },
          child: Text(
            "Login",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );

    // final googleButton = Material(
    //   elevation: 5,
    //   borderRadius: BorderRadius.circular(30),
    //   color: Colors.green[400],
    //   child: MaterialButton(
    //       padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
    //       minWidth: MediaQuery
    //           .of(context)
    //           .size
    //           .width,
    //       onPressed: () {
    //         Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginWithGoogle()));
    //       },
    //       child: Text(
    //         "Login with Google",
    //         textAlign: TextAlign.center,
    //         style: TextStyle(
    //             fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
    //       )),
    // );

    return Scaffold(


      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,

        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //     image: AssetImage("assets/logo.png"),
        //     colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.dstATop),
        //     fit: BoxFit.cover,
        //   ),
        // ),
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
                    Text("GroSense",style: TextStyle(
                        color: Colors.green[400],
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        fontSize: 50),),
                    SizedBox(height: 70),
                    SizedBox(height: 45),
                    emailField,
                    SizedBox(height: 25),
                    passwordField,
                    GestureDetector(
                      child: Text(
                          "Forgot Password?",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green[400],
                            fontSize:15,
                          )
                      ),
                      onTap: (){
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) => ResetPasswordScreen()));
                      },
                    ),
                    SizedBox(height: 35),
                    loginButton,
                    SizedBox(height: 15),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("Don't have an account? "),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          RegistrationScreen()));
                            },
                            child: Text(
                              "SignUp",
                              style: TextStyle(
                                  color: Colors.green[400],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                            ),
                          )
                        ]),
                    // SizedBox(height: 15,),
                    // Text("OR"),
                    // SizedBox(height: 15,),
                    //googleButton,
                    // ElevatedButton(onPressed: () async {
                    //   await signInWithGoogle();
                    //
                    //   setState(() {});
                    // }, child: Text("Login with google")),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    var userEmail = googleUser.email;
    Fluttertoast.showToast(msg: "Login Successfully !");
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => MyBottomNavigation()));
    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);

  }
  void signIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        UserCredential userCredential = await _auth
            .signInWithEmailAndPassword(email: email, password: password);
        await storage.write(key: "uid", value: userCredential.user?.uid);
        Fluttertoast.showToast(msg: "Login Successful");
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => MyBottomNavigation()));
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
}