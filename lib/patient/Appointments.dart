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

  Map<int, Color> color = {
    50: Color.fromRGBO(255, 92, 87, .1),
    100: Color.fromRGBO(255, 92, 87, .2),
    200: Color.fromRGBO(255, 92, 87, .3),
    300: Color.fromRGBO(255, 92, 87, .4),
    400: Color.fromRGBO(255, 92, 87, .5),
    500: Color.fromRGBO(255, 92, 87, .6),
    600: Color.fromRGBO(255, 92, 87, .7),
    700: Color.fromRGBO(255, 92, 87, .8),
    800: Color.fromRGBO(255, 92, 87, .9),
    900: Color.fromRGBO(255, 92, 87, 1),
  };



  @override
  Widget build(BuildContext context) {
    MaterialColor colorCustom = MaterialColor(0xFF4dcfe0, color);
    // TODO: implement build
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: colorCustom,
      ),
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