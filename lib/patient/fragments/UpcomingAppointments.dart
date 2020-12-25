//UpcomingAppointments

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants.dart';

class UpcomingAppointments extends StatefulWidget {
  UpcomingAppointments({Key key}) : super(key: key);

  @override
  _UpcomingAppointmentsState createState() => _UpcomingAppointmentsState();
}

class _UpcomingAppointmentsState extends State<UpcomingAppointments> {
  final double circleRadius = 80.0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(16),
          height: 160,
          child: Material(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Stack(
              alignment: Alignment.topLeft,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 12),
                  child: ListTile(
                    isThreeLine: true,
                    leading: Container(
                      width: circleRadius,
                      height: circleRadius,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Constants.hexToColor(Constants.primaryDarkColor),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 8.0,
                            offset: Offset(0.0, 5.0),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Center(
                          child: Container(
                            child: Image(
                                image: AssetImage("assets/images/doctor.png")),

                            /// replace your image with the Icon
                          ),
                        ),
                      ),
                    ),
                    title: Text('Dr. Liz Haynes',
                        style: TextStyle(
                            color: Constants.hexToColor(
                              Constants.primaryDarkColor,
                            ),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: "ProductSans")),
                    subtitle: Text('Physiotherapist',
                        style: TextStyle(
                            color: Constants.hexToColor(
                              Constants.primaryDarkColor,
                            ),
                            fontFamily: "ProductSans")),
                  ),
                ),


                Padding(
                  padding: EdgeInsets.only(top: 71, left: 112),
                  child: Text(
                    "Jan 19, 2021 - 09:00 AM",
                    style: TextStyle(
                      fontSize: 12,
                        fontFamily: "ProductSans",
                        color: Constants.hexToColor(
                          Constants.primaryDarkColor,
                        )),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(top: 96, left: 8, right: 8),
                  child: Divider(),
                ),


                Padding(
                    padding: EdgeInsets.only(top: 112),
                    child:  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 16, top: 8),
                          child: Text(
                            "Reschedual",
                            style: TextStyle(
                                fontFamily: "ProductSans",
                                fontSize: 16,
                                color: Colors.grey),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 16, top: 8),
                          child: Container(
                            width: 1,
                            height: 22,
                            color: Constants.hexToColor(
                                Constants.graySepratorColor),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 16, top: 8),
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                                fontFamily: "ProductSans",
                                fontSize: 16,
                                color: Colors.red),
                          ),
                        ),
                      ],
                    )
                ),
              ],
            ),
          ),
        ),


        Container(
          margin: EdgeInsets.only(left:16,right:16,bottom:16),
          height: 160,
          child: Material(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Stack(
              alignment: Alignment.topLeft,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 12),
                  child: ListTile(
                    isThreeLine: true,
                    leading: Container(
                      width: circleRadius,
                      height: circleRadius,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Constants.hexToColor(Constants.primaryDarkColor),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 8.0,
                            offset: Offset(0.0, 5.0),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Center(
                          child: Container(
                            child: Image(
                                image: AssetImage("assets/images/doctor.png")),

                            /// replace your image with the Icon
                          ),
                        ),
                      ),
                    ),
                    title: Text('Dr. Robert Jones',
                        style: TextStyle(
                            color: Constants.hexToColor(
                              Constants.primaryDarkColor,
                            ),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: "ProductSans")),
                    subtitle: Text('Internal Medicine',
                        style: TextStyle(
                            color: Constants.hexToColor(
                              Constants.primaryDarkColor,
                            ),
                            fontFamily: "ProductSans")),
                  ),
                ),


                Padding(
                  padding: EdgeInsets.only(top: 71, left: 112),
                  child: Text(
                    "Jan 21, 2021 - 01:00 PM",
                    style: TextStyle(
                        fontSize: 12,
                        fontFamily: "ProductSans",
                        color: Constants.hexToColor(
                          Constants.primaryDarkColor,
                        )),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(top: 96, left: 8, right: 8),
                  child: Divider(),
                ),


                Padding(
                    padding: EdgeInsets.only(top: 112),
                    child:  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 16, top: 8),
                          child: Text(
                            "Reschedual",
                            style: TextStyle(
                                fontFamily: "ProductSans",
                                fontSize: 16,
                                color: Colors.grey),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 16, top: 8),
                          child: Container(
                            width: 1,
                            height: 22,
                            color: Constants.hexToColor(
                                Constants.graySepratorColor),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 16, top: 8),
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                                fontFamily: "ProductSans",
                                fontSize: 16,
                                color: Colors.red),
                          ),
                        ),
                      ],
                    )
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
