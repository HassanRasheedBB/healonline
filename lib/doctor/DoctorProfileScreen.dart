import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class DoctorProfile extends StatefulWidget {
  DoctorProfile({Key key}) : super(key: key);

  @override
  _DoctorProfileState createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfile> {
  final double circleRadius = 100.0;

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
                          height: 228.0,
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
                                  SizedBox(
                                    height: circleRadius / 2,
                                  ),
                                  Text(
                                    "Maria Elliot",
                                    style: TextStyle(
                                      fontFamily: "ProductSans",
                                      fontSize: 24,
                                      fontWeight: FontWeight.w400,
                                      color: Constants.hexToColor(
                                          Constants.blackColor),
                                    ),
                                  ),
                                  Text(
                                    "Ontario Canada",
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
                                            "Appointments",
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
                                            "174",
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
                                            "Patients",
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
                                            "161",
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
                  height: 316,
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
                                "Email Address",
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
                                  "mariaelliot@gmail.com",
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
                          padding:
                          EdgeInsets.only(left: 16, top: 8, bottom: 8),
                          child: Stack(
                            alignment: Alignment.centerLeft,
                            children: [
                              Text(
                                "Phone Number",
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
                                  "+1 (905) 554-0200",
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
                          padding:
                          EdgeInsets.only(left: 16, top: 8, bottom: 8),
                          child: Stack(
                            alignment: Alignment.centerLeft,
                            children: [
                              Text(
                                "PMDC No.",
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
                                  "D-A112369",
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
                          padding:
                          EdgeInsets.only(left: 16, top: 8, bottom: 8),
                          child: Stack(
                            alignment: Alignment.centerLeft,
                            children: [
                              Text(
                                "Experience",
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
                                  "4 yrs & 2 months",
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
                          padding:
                          EdgeInsets.only(left: 16, top: 8, bottom: 8),
                          child: Stack(
                            alignment: Alignment.centerLeft,
                            children: [
                              Text(
                                "Address",
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
                                  "Ontario Canada",
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
                          padding:
                          EdgeInsets.only(left: 16, top: 8, bottom: 8),
                          child: Stack(
                            alignment: Alignment.centerLeft,
                            children: [
                              Text(
                                "Average Rating",
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
                                  "4.0 / 5",
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

            Container(
                margin: EdgeInsets.only(right: 16.0, left:16, bottom : 28),
                height: 54,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Constants.hexToColor(
                        Constants.primaryDarkColor,
                      ),
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(8))
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Edit Profile",
                    style: TextStyle(
                      fontFamily: "ProductSans",
                      fontSize: 18,
                      color: Constants.hexToColor(
                        Constants.primaryDarkColor,
                      ),
                    ),
                  ),
                )
            )

          ],
        )),
      ),
    );
  }
}
