import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../constants.dart';
import 'CityPicker.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.only(top: 80),
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Welcome to Heal",
                    style: TextStyle(
                        fontSize: 26,
                        fontFamily: "ProductSans",
                        fontWeight: FontWeight.w600,
                        color:
                            Constants.hexToColor(Constants.primaryDarkColor))),
                Text("Online",
                    style: TextStyle(
                        fontSize: 26,
                        fontFamily: "ProductSans",
                        fontWeight: FontWeight.w600,
                        color: Constants.hexToColor(Constants.primaryColor)))
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text("What are you looking for ?",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    fontFamily: "ProductSans",
                    color: Constants.hexToColor(Constants.primaryDarkColor))),
          ),
          SizedBox(
            height: 8,
          ),
          Padding(
            padding: EdgeInsets.only(top: 8, right: 24, bottom: 10),
            child: Align(
                alignment: Alignment.centerRight,
                child: Text('See All',
                    style: TextStyle(
                      color: Constants.hexToColor(Constants.primaryDarkColor),
                      fontWeight: FontWeight.w500,
                      fontSize: 14.0,
                      fontFamily: "ProductSans",
                    ))),
          ),
          SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              height: MediaQuery.of(context).size.height - 250,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Material(
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: InkWell(
                          onTap: () {
                            showCupertinoModalBottomSheet(
                              elevation: 8,
                              topRadius: Radius.circular(24),
                              context: context,
                              builder: (context) => Container(
                                margin: EdgeInsets.symmetric(horizontal: 20),
                                height: 600,
                                child: CityPicker("Location", false),
                              ),
                            );
                          },
                          child: Container(
                            height: 130,
                            width: MediaQuery.of(context).size.width / 2 - 28,
                            child: Padding(
                              padding: EdgeInsets.only(left: 18),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                      backgroundColor: Constants.hexToColor(
                                        Constants.primaryDarkColor,
                                      ),
                                      radius: 28,
                                      child: Container(
                                        height: 32,
                                        width: 32,
                                        child: SvgPicture.asset(
                                          "assets/images/physician.svg",
                                          color: Colors.white,
                                        ),
                                      )),
                                  SizedBox(
                                    height: 14,
                                  ),
                                  Text("Physician",
                                      style: TextStyle(
                                        fontFamily: "ProductSans",
                                        fontSize: 18,
                                        color: Constants.hexToColor(
                                          Constants.blackColor,
                                        ),
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Material(
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: InkWell(
                          onTap: () {
                            showCupertinoModalBottomSheet(
                              elevation: 8,
                              topRadius: Radius.circular(24),
                              context: context,
                              builder: (context) => Container(
                                margin: EdgeInsets.symmetric(horizontal: 20),
                                height: 600,
                                child: CityPicker("Location", false),
                              ),
                            );
                          },
                          child: Container(
                            height: 130,
                            width: MediaQuery.of(context).size.width / 2 - 28,
                            child: Padding(
                              padding: EdgeInsets.only(left: 18),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                      backgroundColor: Constants.hexToColor(
                                        Constants.primaryDarkColor,
                                      ),
                                      radius: 28,
                                      child: Container(
                                        height: 32,
                                        width: 32,
                                        child: SvgPicture.asset(
                                          "assets/images/dermatology.svg",
                                          color: Colors.white,
                                        ),
                                      )),
                                  SizedBox(
                                    height: 14,
                                  ),
                                  Text("Dermatologist",
                                      style: TextStyle(
                                        fontFamily: "ProductSans",
                                        fontSize: 18,
                                        color: Constants.hexToColor(
                                          Constants.blackColor,
                                        ),
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Material(
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: InkWell(
                            onTap: () {
                              showCupertinoModalBottomSheet(
                                elevation: 8,
                                topRadius: Radius.circular(24),
                                context: context,
                                builder: (context) => Container(
                                  margin: EdgeInsets.symmetric(horizontal: 20),
                                  height: 600,
                                  child: CityPicker("Location", false),
                                ),
                              );
                            },
                          child: Container(
                            height: 130,
                            width: MediaQuery.of(context).size.width / 2 - 28,
                            child: Padding(
                              padding: EdgeInsets.only(left: 18),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                      backgroundColor: Constants.hexToColor(
                                        Constants.primaryDarkColor,
                                      ),
                                      radius: 28,
                                      child: Container(
                                        height: 32,
                                        width: 32,
                                        child: SvgPicture.asset(
                                          "assets/images/therapist.svg",
                                          color: Colors.white,
                                        ),
                                      )),
                                  SizedBox(
                                    height: 14,
                                  ),
                                  Text("Therapist",
                                      style: TextStyle(
                                        fontFamily: "ProductSans",
                                        fontSize: 18,
                                        color: Constants.hexToColor(
                                          Constants.blackColor,
                                        ),
                                      )),
                                ],
                              ),
                            ),
                          )
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Material(
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: InkWell(
                          onTap: () {
                            showCupertinoModalBottomSheet(
                              elevation: 8,
                              topRadius: Radius.circular(24),
                              context: context,
                              builder: (context) => Container(
                                margin: EdgeInsets.symmetric(horizontal: 20),
                                height: 600,
                                child: CityPicker("Location", false),
                              ),
                            );
                          },
                          child: Container(
                            height: 130,
                            width: MediaQuery.of(context).size.width / 2 - 28,
                            child: Padding(
                              padding: EdgeInsets.only(left: 18),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                      backgroundColor: Constants.hexToColor(
                                        Constants.primaryDarkColor,
                                      ),
                                      radius: 28,
                                      child: Container(
                                        height: 32,
                                        width: 32,
                                        child: SvgPicture.asset(
                                          "assets/images/vets.svg",
                                          color: Colors.white,
                                        ),
                                      )),
                                  SizedBox(
                                    height: 14,
                                  ),
                                  Text("Vets",
                                      style: TextStyle(
                                        fontFamily: "ProductSans",
                                        fontSize: 18,
                                        color: Constants.hexToColor(
                                          Constants.blackColor,
                                        ),
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Material(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Container(
                      height: 110,
                      width: MediaQuery.of(context).size.width  - 14,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [


                          Text("Mental Health Councelling",
                              style: TextStyle(
                                fontFamily: "ProductSans",
                                fontSize: 18,
                                color: Constants.hexToColor(
                                  Constants.blackColor,
                                ),
                              )),

                          SizedBox(
                            width: 14,
                          ),
                          CircleAvatar(
                              backgroundColor: Constants.hexToColor(
                                Constants.primaryDarkColor,
                              ),
                              radius: 28,
                              child: Container(
                                height: 32,
                                width: 32,
                                child: SvgPicture.asset(
                                  "assets/images/mentalhealth.svg",
                                  color: Colors.white,
                                ),
                              )),
                        ],
                      ),
                    ),
                  )

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
