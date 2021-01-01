import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'CovidScreen.dart';

import '../constants.dart';
import 'DurationPicker.dart';

class TimeQuestionScreen extends StatefulWidget {
  TimeQuestionScreen({Key key}) : super(key: key);

  @override
  _TimeQuestionScreenState createState() => _TimeQuestionScreenState();
}

class _TimeQuestionScreenState extends State<TimeQuestionScreen> {
  void _showCustomTimePicker() {
    showModalBottomSheet(
        backgroundColor: Constants.hexToColor(Constants.whiteColor),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
        context: context,
        builder: (context) => DurationPicker(
              onChange: (newTime) => time = newTime,
            )).whenComplete(() {
      setState(() {});
    });
  }

  String time = 'Tap here to select duration !';

  @override
  Widget build(BuildContext context) {
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
        title: Text("Questions",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: "ProductSans",
                color: Constants.hexToColor(Constants.primaryDarkColor))),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 24,),
          Align(
            alignment: Alignment.topCenter,
            child: Text("How long have you felt this way?",
                style: TextStyle(
                  fontFamily: "ProductSans",
                  fontSize: 20,
                  color: Constants.hexToColor(
                    Constants.primaryDarkColor,
                  ),
                )),
          ),
          SizedBox(height: 16,),
          Align(
            alignment: Alignment.topCenter,
            child: InkWell(
              onTap: (){
                _showCustomTimePicker();
              },
              child: Text(
                  '$time',
                  style: TextStyle(
                    fontFamily: "ProductSans",
                    fontSize: 16,
                    color: Constants.hexToColor(
                      Constants.blackColor,
                    ),
                  )
              ),
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

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => CovidScreen(),
              ),
            );
          },
          child: Center(
            child: Text('CONTINUE',
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
