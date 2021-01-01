//PasswordChangeScreen
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [

          SizedBox(
            height: 24,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18),
            child:  TextFormField(
              key: Key('Username'),
              controller: currentPasswordController,
              validator: (value) =>
              (value.isEmpty) ? "Please Enter Current Password" : null,
              decoration: InputDecoration(
                  suffixIcon: Icon(CupertinoIcons.eye_solid),
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
            child:  TextFormField(
              key: Key('Username'),
              controller: newPasswordController,
              validator: (value) =>
              (value.isEmpty) ? "Please Enter New Password" : null,
              decoration: InputDecoration(
                  suffixIcon: Icon(CupertinoIcons.eye_solid),
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
            child:  TextFormField(
              key: Key('Username'),
              controller: confirmPasswordController,
              validator: (value) =>
              (value.isEmpty) ? "Please Enter Confirm Password" : null,
              decoration: InputDecoration(
                  suffixIcon: Icon(CupertinoIcons.eye_solid),
                  prefixIcon: Icon(CupertinoIcons.lock),
                  border: OutlineInputBorder(),
                  hintText: 'Confirm Password*',
                  hintStyle: TextStyle(fontFamily: "ProductSans")),
            ),
          ),

        ],
      ),

      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(6)),
          color: Constants.hexToColor(Constants.primaryDarkColor),
        ),
        child: FlatButton(
          onPressed: () {


          },
          child: Center(
            child: Text('UPDATE PASSWORD',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: "ProductSans")),
          ),
        ),
      ),

    );
  }

}