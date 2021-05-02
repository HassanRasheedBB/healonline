//PasswordChangeScreen
import 'dart:convert';
import 'dart:io';

import 'package:HealOnline/Utils.dart';
import 'package:HealOnline/models/PasswordChangeModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../constants.dart';

class PasswordChangeScreen extends StatefulWidget {
  PasswordChangeScreen({Key key}) : super(key: key);

  @override
  _PasswordChangeScreenState createState() => _PasswordChangeScreenState();
}

class _PasswordChangeScreenState extends State<PasswordChangeScreen> {
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final RoundedLoadingButtonController _btnController =
      new RoundedLoadingButtonController();

  bool _isCurrentShowPwd = true;
  bool _isConfirmShowPwd = true;
  bool _isNewShowPwd = true;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 8,
        backgroundColor: Constants.hexToColor(Constants.whiteColor),
        leading: Padding(
            padding: EdgeInsets.only(left: 14),
            child: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Icon(Icons.arrow_back_ios,
                  color: Constants.hexToColor(Constants.blackColor)),
            )),
        title: Text("Password Change",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: "ProductSans",
                color: Constants.hexToColor(Constants.primaryDarkColor))),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 24,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18),
              child:  TextFormField(textInputAction: TextInputAction.done,
                obscureText: (_isCurrentShowPwd) ? false : true,
                key: Key('Username'),
                controller: currentPasswordController,
                validator: (value) =>
                    (value.isEmpty) ? "Please Enter Current Password" : null,
                decoration: InputDecoration(
                    suffixIcon: InkWell(
                      onTap: () {
                        setState(() {
                          _isCurrentShowPwd = !_isCurrentShowPwd;
                        });
                      },
                      child: _isCurrentShowPwd
                          ? Icon(
                              Icons.visibility,
                              color: Constants.hexToColor(
                                  Constants.primaryDarkColor),
                            )
                          : Icon(Icons.visibility_off,
                              color: Constants.hexToColor(
                                  Constants.primaryDarkColor)),
                    ),
                    prefixIcon: Icon(CupertinoIcons.lock),
                    border: OutlineInputBorder(),
                    hintText: 'Current Password*',
                    hintStyle: TextStyle(fontFamily: "ProductSans")),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18),
              child:  TextFormField(textInputAction: TextInputAction.done,
                obscureText: (_isNewShowPwd) ? false : true,
                key: Key('Username'),
                controller: newPasswordController,
                validator: (value) =>
                    (value.isEmpty) ? "Please Enter New Password" : null,
                decoration: InputDecoration(
                    suffixIcon: InkWell(
                      onTap: () {
                        setState(() {
                          _isNewShowPwd = !_isNewShowPwd;
                        });
                      },
                      child: _isNewShowPwd
                          ? Icon(
                              Icons.visibility,
                              color: Constants.hexToColor(
                                  Constants.primaryDarkColor),
                            )
                          : Icon(Icons.visibility_off,
                              color: Constants.hexToColor(
                                  Constants.primaryDarkColor)),
                    ),
                    prefixIcon: Icon(CupertinoIcons.lock),
                    border: OutlineInputBorder(),
                    hintText: 'New Password*',
                    hintStyle: TextStyle(fontFamily: "ProductSans")),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18),
              child:  TextFormField(textInputAction: TextInputAction.done,
                obscureText: (_isConfirmShowPwd) ? false : true,
                key: Key('Username'),
                controller: confirmPasswordController,
                validator: (value) =>
                    (value.isEmpty) ? "Please Enter Confirm Password" : null,
                decoration: InputDecoration(
                    suffixIcon: InkWell(
                      onTap: () {
                        setState(() {
                          _isConfirmShowPwd = !_isConfirmShowPwd;
                        });
                      },
                      child: _isConfirmShowPwd
                          ? Icon(
                              Icons.visibility,
                              color: Constants.hexToColor(
                                  Constants.primaryDarkColor),
                            )
                          : Icon(Icons.visibility_off,
                              color: Constants.hexToColor(
                                  Constants.primaryDarkColor)),
                    ),
                    prefixIcon: Icon(CupertinoIcons.lock),
                    border: OutlineInputBorder(),
                    hintText: 'Confirm Password*',
                    hintStyle: TextStyle(fontFamily: "ProductSans")),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(bottom: 8),
        child: RoundedLoadingButton(
          width: MediaQuery.of(context).size.width - 32,
          animateOnTap: true,
          color: Constants.hexToColor(Constants.primaryDarkColor),
          elevation: 4,
          borderRadius: 10,
          child: Text('UPDATE PASSWORD',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: "ProductSans")),
          controller: _btnController,
          onPressed: () {
            updatePassword();
          },
        ),
      ),
    );
  }

  Future<void> updatePassword() async {
    if (_formKey.currentState.validate()) {
      String current_password = currentPasswordController.text;
      String new_password = newPasswordController.text;
      String confirm_password = confirmPasswordController.text;

      if (new_password != confirm_password) {
        _btnController.reset();
        showAlertDialog("Error",
            "Confirm and New Password don't match, please try again", context);
        return ;
      }

      PasswordChangeModel passwordChangeModel = new PasswordChangeModel(
          current_password: current_password,
          new_password: new_password,
          confirm_password: confirm_password,
          email: Utils.user.profile_obj.umeta_obj.user_email
      );

      String url = Utils.baseURL + Utils.PASSWORD_RESET ;
      print(url);

      String jsonUser = jsonEncode(passwordChangeModel);
      Map<String, String> headers = {
        "Content-type": "application/json",
        HttpHeaders.authorizationHeader: "Bearer " + Utils.user.token
      };
      print(jsonUser);
      Response response = await post(Uri.parse(url), headers: headers, body: jsonUser);
      int statusCode = response.statusCode;

      print(statusCode);
      print(response.body);

      if (statusCode == 200) {
        _btnController.reset();
        showAlertDialog("Success", "Password is updated successfully", context);
      } else if (response.body.contains("Token expired")) {
        _btnController.reset();
        showAlertDialog("Error",
            "Your login session is expired, please Re-Login again", context);
      } else {
        _btnController.reset();
        showAlertDialog(
            "Error", "Something went wrong please try again", context);
      }
    }else{
      _btnController.reset();
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
  }
}
