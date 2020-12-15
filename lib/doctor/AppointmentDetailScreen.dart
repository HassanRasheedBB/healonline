import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants.dart';

class AppointmentDetail extends StatefulWidget {
  AppointmentDetail({Key key}) : super(key: key);

  @override
  _AppointmentDetailState createState() => _AppointmentDetailState();
}

class _AppointmentDetailState extends State<AppointmentDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 8,
        backgroundColor: Constants.hexToColor(Constants.whiteColor),
        leading: Padding(
          padding: EdgeInsets.all(19),
          child: SvgPicture.asset(
            "assets/images/menu.svg",
          ),
        ),
        title: Text("Appointment Details",
            style: TextStyle(
                fontSize: 20,
                fontFamily: "ProductSans",
                color: Constants.hexToColor(Constants.blackColor))),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 36),
            Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundColor: Constants.hexToColor(
                      Constants.primaryDarkColor,
                    ),
                    radius: 40,
                    child: CircleAvatar(
                      radius: 38,
                      child: Image(
                        image: AssetImage(
                          "assets/images/user_avatar.png",
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    "John Davis",
                    style: TextStyle(
                      fontFamily: "ProductSans",
                      fontSize: 16,
                      color: Constants.hexToColor(
                        Constants.primaryDarkColor,
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Male",
                        style: TextStyle(
                          fontFamily: "ProductSans",
                          fontSize: 15,
                          color: Constants.hexToColor(
                            Constants.blackColor,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Container(width: 1, height: 14, color: Colors.black26),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        "32.0 Y",
                        style: TextStyle(
                          fontFamily: "ProductSans",
                          fontSize: 15,
                          color: Constants.hexToColor(
                            Constants.blackColor,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Container(width: 1, height: 14, color: Colors.black26),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        "dhgb",
                        style: TextStyle(
                          fontFamily: "ProductSans",
                          fontSize: 15,
                          color: Constants.hexToColor(
                            Constants.blackColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    height: 220,
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Weight",
                                  style: TextStyle(
                                    fontFamily: "ProductSans",
                                    fontSize: 15,
                                    color: Constants.hexToColor(
                                      Constants.primaryDarkColor,
                                    ),
                                  ),
                                ),
                                Text(
                                  "105.0 lbps",
                                  style: TextStyle(
                                    fontFamily: "ProductSans",
                                    fontSize: 15,
                                    color: Constants.hexToColor(
                                      Constants.blackColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Height",
                                  style: TextStyle(
                                    fontFamily: "ProductSans",
                                    fontSize: 15,
                                    color: Constants.hexToColor(
                                      Constants.primaryDarkColor,
                                    ),
                                  ),
                                ),
                                Text(
                                  "5.1 inches",
                                  style: TextStyle(
                                    fontFamily: "ProductSans",
                                    fontSize: 15,
                                    color: Constants.hexToColor(
                                      Constants.blackColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Marital Status",
                                  style: TextStyle(
                                    fontFamily: "ProductSans",
                                    fontSize: 15,
                                    color: Constants.hexToColor(
                                      Constants.primaryDarkColor,
                                    ),
                                  ),
                                ),
                                Text(
                                  "Unmarried",
                                  style: TextStyle(
                                    fontFamily: "ProductSans",
                                    fontSize: 15,
                                    color: Constants.hexToColor(
                                      Constants.blackColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Blood Group",
                                  style: TextStyle(
                                    fontFamily: "ProductSans",
                                    fontSize: 15,
                                    color: Constants.hexToColor(
                                      Constants.primaryDarkColor,
                                    ),
                                  ),
                                ),
                                Text(
                                  "-",
                                  style: TextStyle(
                                    fontFamily: "ProductSans",
                                    fontSize: 15,
                                    color: Constants.hexToColor(
                                      Constants.blackColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Email",
                                  style: TextStyle(
                                    fontFamily: "ProductSans",
                                    fontSize: 15,
                                    color: Constants.hexToColor(
                                      Constants.primaryDarkColor,
                                    ),
                                  ),
                                ),
                                Text(
                                  "abc@gmail.com",
                                  style: TextStyle(
                                    fontFamily: "ProductSans",
                                    fontSize: 15,
                                    color: Constants.hexToColor(
                                      Constants.blackColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Phone number",
                                  style: TextStyle(
                                    fontFamily: "ProductSans",
                                    fontSize: 15,
                                    color: Constants.hexToColor(
                                      Constants.primaryDarkColor,
                                    ),
                                  ),
                                ),
                                Text(
                                  "+1 (905) 554-0200",
                                  style: TextStyle(
                                    fontFamily: "ProductSans",
                                    fontSize: 15,
                                    color: Constants.hexToColor(
                                      Constants.blackColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 12,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 8),

                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    height: 52,
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Doctor Notes",
                            style: TextStyle(
                              fontFamily: "ProductSans",
                              fontSize: 16,
                              color: Constants.hexToColor(
                                Constants.primaryDarkColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),


                  SizedBox(height: 8),

                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    height: 52,
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "History",
                            style: TextStyle(
                              fontFamily: "ProductSans",
                              fontSize: 16,
                              color: Constants.hexToColor(
                                Constants.primaryDarkColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),


                  SizedBox(height: 20),

                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 20.0),
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
                          "Next Appointment",
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
              ),
            )
          ],
        ),
      ),
    );
  }
}
