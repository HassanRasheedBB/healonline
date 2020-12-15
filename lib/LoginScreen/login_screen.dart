import 'package:custom_radio_grouped_button/CustomButtons/ButtonTextStyle.dart';
import 'package:custom_radio_grouped_button/CustomButtons/CustomCheckBoxGroup.dart';
import 'package:custom_radio_grouped_button/CustomButtons/CustomRadioButton.dart';
import 'package:flutter/material.dart';
import 'package:healonline/SignUpScreen/SignupScreen.dart';
import 'package:healonline/doctor/HomePage.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

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

  bool _isShowPwd = false;

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
                CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage("assets/images/kiwi.png"),
                ),
                SizedBox(
                  height: 50,
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
                      color: Constants.hexToColor(Constants.primaryDarkColor),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Constants.hexToColor(Constants.primaryDarkColor),
                  ),
                  child: FlatButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(),
                        ),
                      );
                    },
                    child: Center(
                      child: Text('LOGIN',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: "ProductSans")),
                    ),
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
                          Navigator.pushReplacement(
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
                              color: Constants.hexToColor(
                                  Constants.primaryDarkColor)),
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
}
