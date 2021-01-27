import 'dart:async';

import 'package:HealOnline/SignUpScreen/SignupScreen.dart';
import 'package:HealOnline/doctor/HomePage.dart';
import 'package:HealOnline/patient/HomePagePatient.dart';
import 'package:custom_radio_grouped_button/CustomButtons/ButtonTextStyle.dart';
import 'package:custom_radio_grouped_button/CustomButtons/CustomCheckBoxGroup.dart';
import 'package:custom_radio_grouped_button/CustomButtons/CustomRadioButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../constants.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final RoundedLoadingButtonController _btnController =
      new RoundedLoadingButtonController();

  bool _isShowPwd = false;
  String selectedUserAs = "PATIENT";

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Align(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 10, 24, 30),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Image(
                  image: AssetImage("assets/images/logo.png"),
                  width: 180,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Login As',
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        fontFamily: "ProductSans"),
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                CustomRadioButton(
                  defaultSelected: "PATIENT",
                  spacing: 2,
                  elevation: 6,
                  height: 40,
                  width: MediaQuery.of(context).size.width / 2 - 37,
                  customShape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(6.0)),
                  enableShape: true,
                  unSelectedColor: Theme.of(context).canvasColor,
                  buttonLables: [
                    'Patient',
                    'Health Provider',
                  ],
                  buttonValues: [
                    "PATIENT",
                    "HEALTH PROVIDER",
                  ],
                  buttonTextStyle: ButtonTextStyle(
                      selectedColor: Colors.white,
                      unSelectedColor: Colors.black,
                      textStyle:
                          TextStyle(fontSize: 16, fontFamily: "ProductSans")),
                  radioButtonValue: (value) {
                    print(value);
                    selectedUserAs = value;
                  },
                  selectedColor:
                      Constants.hexToColor(Constants.primaryDarkColor),
                ),
                SizedBox(
                  height: 16,
                ),
                TextFormField(
                  key: Key('Username'),
                  controller: _usernameController,
                  validator: (value) =>
                      (value.isEmpty) ? "Please Enter Username" : null,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person_outline),
                      border: OutlineInputBorder(),
                      hintText: 'Username',
                      hintStyle: TextStyle(fontFamily: "ProductSans")),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  key: Key('Password'),
                  controller: _passwordController,
                  validator: (value) =>
                      (value.isEmpty) ? "Please Enter Password" : null,
                  obscureText: (_isShowPwd) ? false : true,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock_outline),
                    border: OutlineInputBorder(),
                    hintText: 'Password',
                    hintStyle: TextStyle(fontFamily: "ProductSans"),
                    suffixIcon: InkWell(
                      onTap: () {
                        setState(() {
                          _isShowPwd = !_isShowPwd;
                        });
                      },
                      child: _isShowPwd
                          ? Icon(
                              Icons.visibility,
                              color: Constants.hexToColor(
                                  Constants.primaryDarkColor),
                            )
                          : Icon(Icons.visibility_off,
                              color: Constants.hexToColor(
                                  Constants.primaryDarkColor)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Forgot Password ?",
                    style: TextStyle(
                      fontFamily: "ProductSans",
                      color: Constants.hexToColor(Constants.primaryColor),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  child: RoundedLoadingButton(
                    width: MediaQuery.of(context).size.width - 32,
                    animateOnTap: true,
                    color: Constants.hexToColor(Constants.primaryDarkColor),
                    elevation: 8,
                    borderRadius: 10,
                    child: Text('LOGIN',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: "ProductSans")),
                    controller: _btnController,
                    onPressed: () {
                      loginUser();
                    },
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: TextStyle(fontFamily: "ProductSans"),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignUpPage(),
                            ),
                          );
                        },
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: "ProductSans",
                              color:
                                  Constants.hexToColor(Constants.primaryColor)),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> loginUser() async {
    if (_formKey.currentState.validate()) {
      try {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: _usernameController.text.toString(),
                password: _passwordController.text.toString())
            .then((value) {

          bool isFound = false;
          if (selectedUserAs == "PATIENT") {
            final databaseReference = FirebaseDatabase.instance.reference();
            databaseReference
                .child("users")
                .child("patient")
                .once()
                .then((DataSnapshot snapshot) {
              Map<dynamic, dynamic> values = snapshot.value;

              values.forEach((key, values) {
                if (values["email"] == _usernameController.text.toString()) {
                  isFound = true;
                }
              });

              if (isFound) {
                _btnController.reset();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePagePatient(),
                  ),
                );
              } else {
                _btnController.reset();
                showAlertDialog(
                    "Server error", 'No user found for that email.', context);
              }
            });
          }
          else {
            final databaseReference = FirebaseDatabase.instance.reference();
            databaseReference
                .child("users")
                .child("health provider")
                .once()
                .then((DataSnapshot snapshot) {
              Map<dynamic, dynamic> values = snapshot.value;

              values.forEach((key, values) {
                if (values["email"] == _usernameController.text.toString()) {
                  isFound = true;
                }
              });

              if (isFound) {
                _btnController.reset();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(),
                  ),
                );
              } else {
                _btnController.reset();
                showAlertDialog("Server error",
                    'No health provider found for that email.', context);
              }
            });
          }
          //_btnController.reset();
        });

      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          _btnController.reset();
          showAlertDialog(
              "Server Error", 'No user found for that email.', context);
        } else if (e.code == 'wrong-password') {
          _btnController.reset();
          showAlertDialog("Server Error",
              'Wrong password provided for that user.', context);
        }else{
          _btnController.reset();
          showAlertDialog(
              "Server Error", 'Invalid email or password.', context);
        }
      }
    } else {
      showAlertDialog("Missing Information", "Please fill all fields", context);
      _btnController.reset();
      return;
    }
  }

  void showAlertDialog(String title, String msg, BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
              title: Text(title,
                  style: TextStyle(
                    fontFamily: "ProductSans",
                  )),
              content: Text(msg,
                  style: TextStyle(
                    fontFamily: "ProductSans",
                  )),
              actions: [
                CupertinoDialogAction(
                  child: Text("OK",
                      style: TextStyle(
                        fontFamily: "ProductSans",
                      )),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ));

    ;
  }

  void goToScreen(BuildContext context) {
    _btnController.reset();
  }

}
