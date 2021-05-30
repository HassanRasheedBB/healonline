import 'package:HealOnline/localization/locale_constant.dart';
import 'package:HealOnline/patient/HomePagePatient.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'CovidScreen.dart';

import '../constants.dart';
import 'DurationPicker.dart';
import 'RemainingQuestionsScreen.dart';

class TimeQuestionScreen extends StatefulWidget {
  TimeQuestionScreen({Key key}) : super(key: key);

  @override
  _TimeQuestionScreenState createState() => _TimeQuestionScreenState();
}

class _TimeQuestionScreenState extends State<TimeQuestionScreen> {

  @override
  void initState() {
    super.initState();
    getLocale();

  }

  String savedCode;
  getLocale() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String languageCode = _prefs.getString(prefSelectedLanguageCode);

    if (languageCode != null) {
      savedCode = languageCode;
      changeLanguage(context, "en", false);

      if (savedCode == "ar") {
        doMakeLangChanges();
      }
    }

  }

  String time = 'Tap here to select duration !';
  var Questions = "Questions";
  var How_Long = "How long have you felt this way?";
  var CONTINUE = "CONTINUE";

  void doMakeLangChanges(){

    setState(() {
      time = "اضغط هنا لتحديد المدة!";
      Questions = "أسئلة";
      How_Long = "منذ متى وأنت تشعر بهذه الطريقة؟";
      CONTINUE = "استمر";

    });
  }


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
        title: Text(Questions,
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
            child: Text(How_Long,
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
                builder: (context) => RemainingQuestionScreen(),
              ),
            );
          },
          child: Center(
            child: Text(CONTINUE,
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
