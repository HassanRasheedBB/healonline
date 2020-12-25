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
  _HomeScreenState createState() => _HomeScreenState();
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
        iconTheme:
            IconThemeData(color: Constants.hexToColor(Constants.blackColor)),
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
      drawer: Drawer(
          elevation: 8,
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 4.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: CircleAvatar(
                          radius: 36,
                          backgroundColor:
                              Constants.hexToColor(Constants.whiteColor),
                          child: CircleAvatar(
                            radius: 32,
                            backgroundColor:
                                Constants.hexToColor(Constants.whiteColor),
                            backgroundImage:
                                AssetImage("assets/images/doctor.png"),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Dr. John Davis",
                          style: TextStyle(
                              fontFamily: "ProductSans",
                              fontSize: 16,
                              color:
                                  Constants.hexToColor(Constants.whiteColor)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Orthopedic",
                          style: TextStyle(
                              fontFamily: "ProductSans",
                              fontSize: 12,
                              color:
                                  Constants.hexToColor(Constants.whiteColor)),
                        ),
                      ),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
              ),

              ListTile(
                leading: Container(
                  height: 26,
                  width: 26,
                  child: SvgPicture.asset(
                    "assets/images/appointment.svg",
                    color: Constants.hexToColor(Constants.primaryDarkColor),
                  ),
                ),
                title: Text(
                  "Appointments",
                  style: TextStyle(
                      fontFamily: "ProductSans",
                      fontSize: 16,
                      color: Constants.hexToColor(Constants.blackColor)),
                ),
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    _page = 0;
                    getPage();
                    Future.delayed(Duration(milliseconds: 500)).then((_) {
                      final CurvedNavigationBarState navBarState =
                          _bottomNavigationKey.currentState;
                      navBarState.setPage(0);
                    });
                  });
                },
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Divider(
                  color: Constants.hexToColor(Constants.graySepratorColor),
                ),
              ),

              ListTile(
                leading: Container(
                  height: 26,
                  width: 26,
                  child: SvgPicture.asset(
                    "assets/images/patients.svg",
                    color: Constants.hexToColor(Constants.primaryDarkColor),
                  ),
                ),
                title: Text(
                  "Patients",
                  style: TextStyle(
                      fontFamily: "ProductSans",
                      fontSize: 16,
                      color: Constants.hexToColor(Constants.blackColor)),
                ),
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    _page = 1;
                    getPage();
                    Future.delayed(Duration(milliseconds: 500)).then((_) {
                      final CurvedNavigationBarState navBarState =
                          _bottomNavigationKey.currentState;
                      navBarState.setPage(1);
                    });
                  });

                },
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Divider(
                  color: Constants.hexToColor(Constants.graySepratorColor),
                ),
              ),


              ListTile(
                leading: Container(
                  height: 26,
                  width: 26,
                  child: SvgPicture.asset(
                    "assets/images/bell.svg",
                    color: Constants.hexToColor(Constants.primaryDarkColor),
                  ),
                ),
                title: Text(
                  "Notifications",
                  style: TextStyle(
                      fontFamily: "ProductSans",
                      fontSize: 16,
                      color: Constants.hexToColor(Constants.blackColor)),
                ),
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    _page = 2;
                    getPage();
                    Future.delayed(Duration(milliseconds: 500)).then((_) {
                      final CurvedNavigationBarState navBarState =
                          _bottomNavigationKey.currentState;
                      navBarState.setPage(2);
                    });
                  });
                },
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Divider(
                  color: Constants.hexToColor(Constants.graySepratorColor),
                ),
              ),

              ListTile(
                leading: Container(
                  height: 26,
                  width: 26,
                  child: SvgPicture.asset(
                    "assets/images/profile.svg",
                    color: Constants.hexToColor(Constants.primaryDarkColor),
                  ),
                ),
                title: Text(
                  "Profile",
                  style: TextStyle(
                      fontFamily: "ProductSans",
                      fontSize: 16,
                      color: Constants.hexToColor(Constants.blackColor)),
                ),
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    _page = 3;
                    getPage();
                    Future.delayed(Duration(milliseconds: 500)).then((_) {
                      final CurvedNavigationBarState navBarState =
                          _bottomNavigationKey.currentState;
                      navBarState.setPage(3);
                    });
                  });
                },
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Divider(
                  color: Constants.hexToColor(Constants.graySepratorColor),
                ),
              ),

              ListTile(
                leading: Container(
                  height: 26,
                  width: 26,
                  child: SvgPicture.asset(
                    "assets/images/call.svg",
                    color: Constants.hexToColor(Constants.primaryDarkColor),
                  ),
                ),
                title: Text(
                  "Contact Us",
                  style: TextStyle(
                      fontFamily: "ProductSans",
                      fontSize: 16,
                      color: Constants.hexToColor(Constants.blackColor)),
                ),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Divider(
                  color: Constants.hexToColor(Constants.graySepratorColor),
                ),
              ),

              ListTile(
                leading: Container(
                  height: 26,
                  width: 26,
                  child: SvgPicture.asset(
                    "assets/images/logout.svg",
                    color: Constants.hexToColor(Constants.primaryDarkColor),
                  ),
                ),
                title: Text(
                  "Logout",
                  style: TextStyle(
                      fontFamily: "ProductSans",
                      fontSize: 16,
                      color: Constants.hexToColor(Constants.blackColor)),
                ),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Divider(
                  color: Constants.hexToColor(Constants.graySepratorColor),
                ),
              ),
            ],
          )),
    );
  }

  getPage() {
    if (_page == 0) {
      appBarTitle = "Appointments";
      home = AppointmentList();
    } else if (_page == 1) {
      appBarTitle = "Patients";
      home = Container(
        child: FutureBuilder(
            future: Future.delayed(Duration(milliseconds: 1000)),
            builder: (c, s) => s.connectionState == ConnectionState.done
                ? AllPatientListScreen()
                : Container(
                    height: MediaQuery.of(context).size.height,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )),
      );

//home = AllPatientListScreen()

    } else if (_page == 2) {
      appBarTitle = "Notifications";
      home = Container(
        child: FutureBuilder(
            future: Future.delayed(Duration(milliseconds: 1000)),
            builder: (c, s) => s.connectionState == ConnectionState.done
                ? NotificationScreen()
                : Container(
                    height: MediaQuery.of(context).size.height,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )),
      );
      //home = NotificationScreen();
    } else {
      appBarTitle = "Profile";
      home = Container(
        child: FutureBuilder(
            future: Future.delayed(Duration(milliseconds: 1000)),
            builder: (c, s) => s.connectionState == ConnectionState.done
                ? DoctorProfile()
                : Container(
                    height: MediaQuery.of(context).size.height,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )),
      );
    }
  }
}
