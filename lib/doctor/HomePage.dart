import 'package:HealOnline/LoginScreen/login_screen.dart';
import 'package:HealOnline/Utils.dart';
import 'package:HealOnline/VideoCall/call.dart';
import 'package:HealOnline/VideoCall/index.dart';
import 'package:HealOnline/localization/language/languages.dart';
import 'package:HealOnline/localization/locale_constant.dart';
import 'package:HealOnline/patient/ContactUsScreen.dart';
import 'package:HealOnline/patient/SettingsScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart';
import 'AllPatientsListScreen.dart';
import 'AppointmentListScreen.dart';
import 'DoctorProfileScreen.dart';
import 'NotificationScreen.dart';

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
    getLocale();
    home = AppointmentList();


  }



  String savedCode;
  getLocale() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String languageCode = _prefs.getString(prefSelectedLanguageCode);
    if (languageCode != null) {
      savedCode = languageCode;
      changeLanguage(context, savedCode, false);

    }
    setState(() {
      appBarTitle = Languages.of(context).appointments;
    });
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
      resizeToAvoidBottomInset: false,
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
                          "Dr. "+Utils.user.profile_obj.pmeta_obj.full_name,
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
                  color: Constants.hexToColor(Constants.primaryDarkColor),
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
                  Languages.of(context).appointments,
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
                  Languages.of(context).patients,
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
                  Languages.of(context).notifications,
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
                  Languages.of(context).profile,
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
                  child: Icon(Icons.settings, color: Constants.hexToColor(Constants.primaryDarkColor),),
                ),
                title: Text(
                  Languages.of(context).settings,
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SettingsScreen(null),
                    ),
                  );
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
                    Languages.of(context).logout,
                  style: TextStyle(
                      fontFamily: "ProductSans",
                      fontSize: 16,
                      color: Constants.hexToColor(Constants.blackColor)),
                ),
                onTap: () async {
                  Navigator.pop(context);
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  await prefs.remove('loggedIn');

                  Future.delayed(
                    Duration(milliseconds: 500),
                        () {
                      setState(() {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginPage(),
                          ),
                        );
                      });
                    },
                  );
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
      appBarTitle = Languages.of(context).appointments;
      home = AppointmentList();
    } else if (_page == 1) {
      appBarTitle = Languages.of(context).patients;
      home = Container(
        child: FutureBuilder(
            future: Future.delayed(Duration(milliseconds: 1000)),
            builder: (c, s) => s.connectionState == ConnectionState.done
                ? AllPatientListScreen()
                : Container(
                    height: 80,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )),
      );

//home = AllPatientListScreen()

    } else if (_page == 2) {
      appBarTitle = Languages.of(context).notifications;
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
    }

    else if (_page == 9) {
      //appBarTitle = "Call";
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => IndexPage(),
        ),
      );
      //home = IndexPage();
      //home = NotificationScreen();
    }

    else {
      appBarTitle = Languages.of(context).profile;
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
