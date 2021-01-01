import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'file:///C:/Users/Hassa/AndroidStudioProjects/healonline/lib/patient/TimeQuestionScreen.dart';

import '../../constants.dart';

class SelectSypmtomScreen extends StatefulWidget {
  SelectSypmtomScreen({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<SelectSypmtomScreen> {


  Map<String, bool> values = {
    'OCD': false,
    'Panic Attacks': false,
    'Social Anxiety': false,
    'Anxiety': false,
    'Bereavement / Grief': false,
    'Couples Therapy': false,
    'Life Transition': false,
    'LGBTQ Counselling': false,
    'PTSD / Trauma': false,
    'Stress Management': false,
    'Other': false
  };

  var _checked = false;
  String symptoms= "";

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
        title: Text("Select Symptoms",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: "ProductSans",
                color: Constants.hexToColor(Constants.primaryDarkColor))),
      ),
      body: ListView.separated(
        itemCount: values.length,
        itemBuilder: (context, index) {
          return CheckboxListTile(
            title: new Text(
              values.keys.elementAt(index),
              style: TextStyle(
                fontFamily: "ProductSans",
                fontSize: 16,
                color: Constants.hexToColor(
                  Constants.blackColor,
                ),
              ),
            ),
            value: values[values.keys.elementAt(index)],
            onChanged: (bool value) {
              setState(() {
                values[values.keys.elementAt(index)] = value;
                if(value){
                  symptoms+=(values.keys.elementAt(index)+",");
                }else{
                  if(symptoms.contains(values.keys.elementAt(index)+",")) {
                    symptoms = symptoms.replaceAll(values.keys.elementAt(index)+",", "");
                  }
                }
              });
            },
          );
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
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
            Constants.appointment.symptoms = symptoms;
            print(symptoms);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => TimeQuestionScreen(),
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
