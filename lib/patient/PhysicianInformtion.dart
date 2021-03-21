import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants.dart';

class PhysicianInformtion extends StatefulWidget {
  PhysicianInformtion({Key key}) : super(key: key);

  @override
  _PhysicianInformtionState createState() => _PhysicianInformtionState();
}

class _PhysicianInformtionState extends State<PhysicianInformtion> {
  final double circleRadius = 70.0;

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
        title: Text("Physician Detail",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: "ProductSans",
                color: Constants.hexToColor(Constants.primaryDarkColor))),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 50),
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
                elevation: 8,
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
                          padding: EdgeInsets.only(left: 16, top: 8, bottom: 8),
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
                          padding: EdgeInsets.only(left: 16, top: 8, bottom: 8),
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
                          padding: EdgeInsets.only(left: 16, top: 8, bottom: 8),
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
                          padding: EdgeInsets.only(left: 16, top: 8, bottom: 8),
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
            SizedBox(height: 24),
            Align(
              alignment: AlignmentDirectional.topStart,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  "Most Recent Reviews",
                  style: TextStyle(
                    fontFamily: "ProductSans",
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Constants.hexToColor(Constants.primaryDarkColor),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              height: 170,
              width: MediaQuery.of(context).size.width,
              child: Material(
                elevation: 8,
                shape: new RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0)),
                child: Stack(
                  alignment: Alignment.topLeft,
                  children: [
                    Container(
                      margin: EdgeInsets.all(16),
                      height: 50,
                      width: 50,
                      child: SvgPicture.asset(
                        "assets/images/user_avatar.svg",
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 84, top: 30),
                      child: Text(
                        "Anonymous",
                        style: TextStyle(
                          fontFamily: "ProductSans",
                          fontSize: 20,
                            color: Constants.hexToColor(Constants.primaryDarkColor),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 12, top: 12, left: 8, ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            CupertinoIcons.star_fill,
                            size: 18,
                            color: Constants.hexToColor(
                                Constants.primaryDarkColor),
                          ),
                          Icon(CupertinoIcons.star_fill,
                            size: 18,
                            color: Constants.hexToColor(
                                Constants.primaryDarkColor),),
                          Icon(CupertinoIcons.star_fill,
                            size: 18,
                            color: Constants.hexToColor(
                                Constants.primaryDarkColor),),
                          Icon(CupertinoIcons.star_fill,
                            size: 18,
                            color: Constants.hexToColor(
                                Constants.primaryDarkColor),),
                        ],
                      ),
                    ),


                    Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width - 32,
                      margin: EdgeInsets.only(left: 16, top: 80, right: 8),
                      child: Text(
                        "Very Knowledgeable, Asks the right questions. Thanks you for you service",
                        style: TextStyle(
                          fontFamily: "ProductSans",
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(right: 16, bottom: 16),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          "05 days Ago",
                          style: TextStyle(
                            fontFamily: "ProductSans",
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    )


                  ],
                ),
              ),
            ),
            SizedBox(height: 32),
          ],
        )),
      ),
    );
  }
}
