import 'dart:async';
import 'dart:convert';

import 'package:HealOnline/SignUpScreen/SignupScreen.dart';
import 'package:HealOnline/Utils.dart';
import 'package:HealOnline/doctor/HomePage.dart';
import 'package:HealOnline/models/LoginRequest.dart';
import 'package:HealOnline/models/LoginResponse.dart';
import 'package:HealOnline/patient/HomePagePatient.dart';
import 'package:HealOnline/patient/fragments/HomePage.dart';
import 'package:custom_radio_grouped_button/CustomButtons/ButtonTextStyle.dart';
import 'package:custom_radio_grouped_button/CustomButtons/CustomCheckBoxGroup.dart';
import 'package:custom_radio_grouped_button/CustomButtons/CustomRadioButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
                      //loginTemporary();
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

      String url = Utils.baseURL + Utils.USER_LOGIN;
      Map<String, String> headers = Utils.HEADERS;
      LoginRequest user = LoginRequest(_usernameController.text, _passwordController.text);
      String jsonUser = jsonEncode(user);
      Response response = await post(url, headers: headers, body: jsonUser);
      int statusCode = response.statusCode;

      if(statusCode == 200){
        String body = response.body;
        LoginResponse _loginResponse = LoginResponse.fromJson(
            json.decode(body));

        Utils.user = _loginResponse;
        Utils.user.is_loggedIn = "1";

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('loggedIn', "1");
        await prefs.setInt('profile_id', _loginResponse.profile_obj.umeta_obj.profile_id);
        await prefs.setInt('id', _loginResponse.profile_obj.umeta_obj.id);
        await prefs.setString('user_login', _loginResponse.profile_obj.umeta_obj.user_login.toString());
        await prefs.setString('user_pass', _loginResponse.profile_obj.umeta_obj.user_pass.toString());
        await prefs.setString('user_email', _loginResponse.profile_obj.umeta_obj.user_email.toString());
        await prefs.setString('user_type', _loginResponse.profile_obj.pmeta_obj.user_type.toString());
        await prefs.setString('full_name', _loginResponse.profile_obj.pmeta_obj.full_name.toString());
        await prefs.setString('profile_img', _loginResponse.profile_obj.pmeta_obj.profile_img.toString());
        await prefs.setString('token', _loginResponse.token.toString());

        _btnController.reset();

        if(_loginResponse.profile_obj.pmeta_obj.user_type == "patient"){
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomePagePatient(),
            ),
          );
        }
        else{
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ),
          );
        }



      }else{
        showAlertDialog("Invalid Credentials", "Either your username or password is not correct. Please try again.", context);
        _btnController.reset();
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

  void loginTemporary() {
    if(selectedUserAs ==  "PATIENT" && _usernameController.text == 'anya@gmail.com' && _passwordController.text == 'Pakistan@123'){

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePagePatient(),
        ),
      );
    }else if(selectedUserAs !=  "PATIENT" && _usernameController.text == 'David@gmail.com' && _passwordController.text == 'Pakistan@123'){

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
      );
    }else{
      showAlertDialog("Error", "Invalid Credentials", context);
    }
    _btnController.reset();
  }

}
