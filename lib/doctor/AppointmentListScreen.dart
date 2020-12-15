import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants.dart';
import 'AppointmentDetailScreen.dart';

class AppointmentList extends StatefulWidget {
  AppointmentList({Key key}) : super(key: key);

  @override
  _AppointmentListState createState() => _AppointmentListState();
}

class _AppointmentListState extends State<AppointmentList> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 16, bottom: 16, left: 8),
            child: Text(
              "Today",
              style: TextStyle(
                fontFamily: "ProductSans",
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Constants.hexToColor(Constants.primaryDarkColor),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(top: 16, bottom: 16),
              child: Text(
                "There is no appointment today",
                style: TextStyle(
                  fontFamily: "ProductSans",
                  fontSize: 14,
                  color: Constants.hexToColor(Constants.primaryDarkColor),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 16, bottom: 16,left: 8),
            child: Text(
              "Upcoming",
              style: TextStyle(
                fontFamily: "ProductSans",
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Constants.hexToColor(Constants.primaryDarkColor),
              ),
            ),
          ),

          // Hrdcoded List

          Padding(
              padding: EdgeInsets.only(top: 8, bottom: 16),
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AppointmentDetail(),
                          ),
                        );
                      },
                      title: Text(
                        "John Davis",
                        style: TextStyle(
                          fontFamily: "ProductSans",
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Constants.hexToColor(Constants.blackColor),
                        ),
                      ),
                      subtitle: Text(
                        "09-02-2020 5:00 PM",
                        style: TextStyle(
                          fontFamily: "ProductSans",
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      leading: SvgPicture.asset(
                        "assets/images/user_avatar.svg",
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Divider(
                        color:
                        Constants.hexToColor(Constants.graySepratorColor),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 16, top: 8),
                          child: Text(
                            "Next Appointment",
                            style: TextStyle(
                                fontFamily: "ProductSans",
                                fontSize: 14,
                                color: Colors.grey),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 16, top: 8),
                          child: Container(
                            width: 1,
                            height: 20,
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
                                fontSize: 14,
                                color: Colors.grey),
                          ),
                        ),
                      ],
                    )
                  ],
                ),

                //
              )),

          //SizedBox(height: 16,),

          Padding(
              padding: EdgeInsets.only(bottom: 16),
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      title: Text(
                        "Micheal Moore",
                        style: TextStyle(
                          fontFamily: "ProductSans",
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Constants.hexToColor(Constants.blackColor),
                        ),
                      ),
                      subtitle: Text(
                        "11-01-2020 7:00 PM",
                        style: TextStyle(
                          fontFamily: "ProductSans",
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      leading: SvgPicture.asset(
                        "assets/images/user_avatar.svg",
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Divider(
                        color:
                        Constants.hexToColor(Constants.graySepratorColor),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 16, top: 8),
                          child: Text(
                            "Next Appointment",
                            style: TextStyle(
                                fontFamily: "ProductSans",
                                fontSize: 14,
                                color: Colors.grey),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 16, top: 8),
                          child: Container(
                            width: 1,
                            height: 20,
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
                                fontSize: 14,
                                color: Colors.grey),
                          ),
                        ),
                      ],
                    )
                  ],
                ),

                //
              )),
        ],
      ),
    );
  }
}