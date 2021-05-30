import 'dart:convert';
import 'dart:io';

import 'package:HealOnline/Utils.dart';
import 'package:HealOnline/doctor/DoctorProfileSettingsScreen.dart';
import 'package:HealOnline/localization/language/languages.dart';
import 'package:HealOnline/models/RegisterDoctor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../constants.dart';

class DoctorProfile extends StatefulWidget {
  DoctorProfile({Key key}) : super(key: key);

  @override
  _DoctorProfileState createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfile> {
  final double circleRadius = 100.0;
  RegisterUser user;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    user = new RegisterUser(
        3,
        "-",
        "-",
        "-",
        "-",
        "-",
        "-",
        "-",
        "-",
        "-",
        "-",
        Constants.fcm_token
        );
    getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
            child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 38),
              child: Stack(children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: <Widget>[

                      Padding(
                        padding: EdgeInsets.only(
                          top: circleRadius / 2.0,
                        ),

                        ///here we create space for the circle avatar to get ut of the box
                        child: Container(
                          height: 240.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 8.0,
                                offset: Offset(0.0, 5.0),
                              ),
                            ],
                          ),
                          width: double.infinity,
                          child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 15.0, bottom: 15.0),
                              child: Column(
                                children: <Widget>[

                                  GestureDetector(
                                    onTap: (){
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => DoctorProfileSettingScreen(),
                                        ),
                                      );
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.only(right:16),
                                      child: Align(
                                        alignment: Alignment.topRight,
                                        child: Icon(Icons.edit, color: Constants.hexToColor(Constants.primaryDarkColor), size: 24,),
                                      ),
                                    ),
                                  ),

                                  SizedBox(
                                    height: circleRadius / 2 - 16,
                                  ),
                                  Text(
                                    user.fname + " " + user.lName,
                                    style: TextStyle(
                                      fontFamily: "ProductSans",
                                      fontSize: 24,
                                      fontWeight: FontWeight.w400,
                                      color: Constants.hexToColor(
                                          Constants.blackColor),
                                    ),
                                  ),
                                  Text(
                                     user.location != null ? user.location : "",
                                    style: TextStyle(
                                      fontFamily: "ProductSans",
                                      fontSize: 15,
                                      color: Constants.hexToColor(
                                          Constants.primaryDarkColor),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 24.0,
                                  ),
                                  Divider(
                                    color: Constants.hexToColor(
                                        Constants.graySepratorColor),
                                  ),
                                  SizedBox(
                                    height: 12.0,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            Languages.of(context).appointments,
                                            style: TextStyle(
                                                fontFamily: "ProductSans",
                                                fontSize: 16,
                                                color: Constants.hexToColor(
                                                    Constants.blackColor)),
                                          ),
                                          SizedBox(
                                            height: 4.0,
                                          ),
                                          Text(
                                            user.appointments != null ? user.appointments.toString() : "-",
                                            style: TextStyle(
                                                fontFamily: "ProductSans",
                                                fontSize: 16,
                                                color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(right: 8),
                                        child: Container(
                                          width: 1,
                                          height: 36,
                                          color: Constants.hexToColor(
                                              Constants.graySepratorColor),
                                        ),
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            Languages.of(context).patients,
                                            style: TextStyle(
                                                fontFamily: "ProductSans",
                                                fontSize: 16,
                                                color: Constants.hexToColor(
                                                    Constants.blackColor)),
                                          ),
                                          SizedBox(
                                            height: 4.0,
                                          ),
                                          Text(
                                            user.patients != null ? user.patients.toString() : "-",
                                            style: TextStyle(
                                                fontFamily: "ProductSans",
                                                fontSize: 16,
                                                color: Colors.grey),
                                          ),
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              )),
                        ),
                      ),

                      ///Image Avatar
                      Container(
                        width: circleRadius,
                        height: circleRadius,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color:
                              Constants.hexToColor(Constants.primaryDarkColor),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 8.0,
                              offset: Offset(0.0, 5.0),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Center(
                            child: Container(
                              child: Image(
                                  image:
                                      AssetImage("assets/images/doctor.png")),

                              /// replace your image with the Icon
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
            Padding(
              padding: EdgeInsets.only(left: 12, right: 12),
              child: Card(
                elevation: 12,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Container(
                  height: 340,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding:
                              EdgeInsets.only(left: 16, top: 16, bottom: 8),
                          child: Stack(
                            alignment: Alignment.centerLeft,
                            children: [
                              Text(
                                Languages.of(context).email,
                                style: TextStyle(
                                  fontFamily: "ProductSans",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Constants.hexToColor(
                                      Constants.primaryDarkColor),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 130, top: 2),
                                child: Text(
                                  Utils.user.profile_obj.umeta_obj.user_login,
                                  style: TextStyle(
                                    fontFamily: "ProductSans",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Divider(
                        color:
                            Constants.hexToColor(Constants.graySepratorColor),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 16, top: 8, bottom: 8),
                          child: Stack(
                            alignment: Alignment.centerLeft,
                            children: [
                              Text(
                                Languages.of(context).phone_number,
                                style: TextStyle(
                                  fontFamily: "ProductSans",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Constants.hexToColor(
                                      Constants.primaryDarkColor),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 130, top: 2),
                                child: Text(
                                  user.contact_number != null ? user.contact_number : "-",
                                  style: TextStyle(
                                    fontFamily: "ProductSans",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Divider(
                        color:
                            Constants.hexToColor(Constants.graySepratorColor),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 16, top: 8, bottom: 8),
                          child: Stack(
                            alignment: Alignment.centerLeft,
                            children: [
                              Text(
                                "CSN No.",
                                style: TextStyle(
                                  fontFamily: "ProductSans",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Constants.hexToColor(
                                      Constants.primaryDarkColor),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 130, top: 2),
                                child: Text(
                                  user.csnNo != null
                                  ? user.csnNo
                                  : "",
                                  style: TextStyle(
                                    fontFamily: "ProductSans",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Divider(
                        color:
                            Constants.hexToColor(Constants.graySepratorColor),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 16, top: 8, bottom: 8),
                          child: Stack(
                            alignment: Alignment.centerLeft,
                            children: [
                              Text(
                                Languages.of(context).experience,
                                style: TextStyle(
                                  fontFamily: "ProductSans",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Constants.hexToColor(
                                      Constants.primaryDarkColor),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 130, top: 2),
                                child: Text(
                                  "4 yrs",
                                  style: TextStyle(
                                    fontFamily: "ProductSans",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Divider(
                        color:
                            Constants.hexToColor(Constants.graySepratorColor),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 16, top: 8, bottom: 8),
                          child: Stack(
                            alignment: Alignment.centerLeft,
                            children: [
                              Text(
                               Languages.of(context).address,
                                style: TextStyle(
                                  fontFamily: "ProductSans",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Constants.hexToColor(
                                      Constants.primaryDarkColor),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 130, top: 2),
                                child: Text(
                                  user.location != null ? user.location : "",
                                  style: TextStyle(
                                    fontFamily: "ProductSans",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Divider(
                        color:
                            Constants.hexToColor(Constants.graySepratorColor),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 16, top: 8, bottom: 8),
                          child: Stack(
                            alignment: Alignment.centerLeft,
                            children: [
                              Text(
                               Languages.of(context).ave_rating,
                                style: TextStyle(
                                  fontFamily: "ProductSans",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: Constants.hexToColor(
                                      Constants.primaryDarkColor),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 130, top: 2),
                                child: Text(
                                  "4.2" + " / 5",
                                  style: TextStyle(
                                    fontFamily: "ProductSans",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DoctorProfileSettingScreen(),
                  ),
                );
              },
              child: Container(
                  margin: EdgeInsets.only(right: 16.0, left: 16, bottom: 28),
                  height: 54,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Constants.hexToColor(
                          Constants.primaryDarkColor,
                        ),
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      Languages.of(context).edit_profile,
                      style: TextStyle(
                        fontFamily: "ProductSans",
                        fontSize: 18,
                        color: Constants.hexToColor(
                          Constants.primaryDarkColor,
                        ),
                      ),
                    ),
                  )),
            ),
          ],
        )),
      ),
    );
  }

  Future<void> getProfile() async {

    String url = Utils.baseURL +
        Utils.GET_DOCTOR +
        Utils.user.profile_obj.umeta_obj.profile_id.toString();
    print(url);
    Map<String, String> headers = {
      "Content-type": "application/json",
      HttpHeaders.authorizationHeader: "Bearer " + Utils.user.token
    };
    Response response = await get(Uri.parse(url), headers: headers);
    String body = response.body;
    print(response.body);

    final List typeList = (json.decode(response.body))["doctor"];
    setState(() {
      if (typeList.isNotEmpty) {
        setState(() {

          user.fname = typeList[0]["first_name"];
          user.lName = typeList[0]["last_name"];
          user.gender = typeList[0]["gender"];
          user.location = typeList[0]["province"];
          user.contact_number = typeList[0]["mobile"];
          user.csnNo = typeList[0]["cpso"];
          user.appointments = (json.decode(response.body))["appointments"];
          user.patients = (json.decode(response.body))["patients"];

        });
      }
    });

  }
}
