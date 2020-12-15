import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:healonline/doctor/AllPatientsListScreen.dart';
import 'package:healonline/doctor/AppointmentDetailScreen.dart';
import 'package:healonline/doctor/AppointmentListScreen.dart';
import 'package:healonline/doctor/NotificationScreen.dart';
import '../constants.dart';
import 'DoctorProfileScreen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() =>
      _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey _bottomNavigationKey = GlobalKey<CurvedNavigationBarState>();
  int _page = 0;

  Widget home = Container();

  Widget appointmentTab = CircleAvatar(
      backgroundColor: Colors.transparent,
      child: Padding(
        padding: EdgeInsets.all(5),
        child: SvgPicture.asset(
          "assets/images/appointment.svg",
          color: Colors.white,
        ),
      ));

  Widget patientsTab = CircleAvatar(
      backgroundColor: Colors.transparent,
      child: Padding(
        padding: EdgeInsets.all(4),
        child: SvgPicture.asset(
          "assets/images/patients.svg",
          color: Colors.white,
        ),
      ));

  Widget notificationsTab = CircleAvatar(
      backgroundColor: Colors.transparent,
      child: Padding(
        padding: EdgeInsets.all(5),
        child: SvgPicture.asset(
          "assets/images/bell.svg",
          color: Colors.white,
        ),
      ));

  Widget profileTab = CircleAvatar(
      backgroundColor: Colors.transparent,
      child: Padding(
        padding: EdgeInsets.all(5),
        child: SvgPicture.asset(
          "assets/images/profile.svg",
          color: Colors.white,
        ),
      ));

  String appBarTitle = "Appointments";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    home = AppointmentList();
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
        title: Text(appBarTitle,
            style: TextStyle(
                fontSize: 20,
                fontFamily: "ProductSans",
                color: Constants.hexToColor(Constants.blackColor))),
      ),
      resizeToAvoidBottomPadding: false,
      backgroundColor: Constants.hexToColor(Constants.whiteColor),
      bottomNavigationBar: CurvedNavigationBar(
        color: Constants.hexToColor(Constants.primaryDarkColor),
        backgroundColor: Constants.hexToColor(Constants.whiteColor),
        key: _bottomNavigationKey,
        items: <Widget>[
          appointmentTab,
          patientsTab,
          notificationsTab,
          profileTab,
        ],
        onTap: (index) {
          setState(() {
            _page = index;
            getPage();
          });
        },
      ),
      body: home,
    );
  }

  getPage() {
    if (_page == 0) {
      appBarTitle = "Appointments";
      home = AppointmentList();
    }
    else if(_page == 1) {
      appBarTitle = "Patients";
      home = Container(
        child: FutureBuilder(
          future: Future.delayed(Duration(milliseconds: 1000)),
            builder: (c, s) =>
            s.connectionState == ConnectionState.done
            ? AllPatientListScreen()
            : Container(
              height: MediaQuery.of(context).size.height,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
        ),
      );

//home = AllPatientListScreen()

    }
    else if(_page == 2) {
      appBarTitle = "Notifications";
      home = Container(
        child: FutureBuilder(
            future: Future.delayed(Duration(milliseconds: 1000)),
            builder: (c, s) =>
            s.connectionState == ConnectionState.done
                ?  NotificationScreen()
                : Container(
              height: MediaQuery.of(context).size.height,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
        ),
      );
      //home = NotificationScreen();
    }
    else{
      appBarTitle = "Profile";
      home = Container(
        child: FutureBuilder(
            future: Future.delayed(Duration(milliseconds: 1000)),
            builder: (c, s) =>
            s.connectionState == ConnectionState.done
                ?  DoctorProfile()
                : Container(
              height: MediaQuery.of(context).size.height,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
        ),
      );
    }
  }


}
