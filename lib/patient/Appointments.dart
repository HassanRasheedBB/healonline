import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healonline/patient/fragments/CompletedAppointmets.dart';
import 'package:healonline/patient/fragments/UpcomingAppointments.dart';

import '../constants.dart';

class Appointments extends StatefulWidget {
  Appointments({Key key}) : super(key: key);

  @override
  _AppointmentsState createState() => _AppointmentsState();
}

class _AppointmentsState extends State<Appointments> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          drawerScrimColor: Constants.hexToColor(
            Constants.primaryDarkColor,
          ),
          appBar: AppBar(
            backgroundColor: Constants.hexToColor(
              Constants.whiteColor,
            ),
            bottom: TabBar(
              indicatorColor: Constants.hexToColor(
                Constants.primaryDarkColor,
              ),
              tabs: [
                Padding(
                  padding: EdgeInsets.only(bottom:8.0),
                  child: Text(
                    "Completed",
                    style: TextStyle(
                      fontFamily: "ProductSans",
                      fontSize: 16,
                      color: Constants.hexToColor(
                        Constants.primaryDarkColor,
                      ),
                    ),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(bottom:8.0),
                  child: Text(
                    "Upcoming",
                    style: TextStyle(
                      fontFamily: "ProductSans",
                      fontSize: 16,
                      color: Constants.hexToColor(
                        Constants.primaryDarkColor,
                      ),
                    ),
                  ),
                )

              ],
            ),
            title: Padding(
              padding: EdgeInsets.only(left:8.0, top:16.0),
             child: Text(
               "Appointments",
               style: TextStyle(
                 fontFamily: "ProductSans",
                 fontSize: 24,
                 fontWeight: FontWeight.bold,
                 color: Constants.hexToColor(
                   Constants.primaryDarkColor,
                 ),
               ),
             ),
            )
          ),
          body: TabBarView(
            children: [
              CompletedAppointments(),
              UpcomingAppointments(),
            ],
          ),
        ),
      ),
    );
  }
  
}