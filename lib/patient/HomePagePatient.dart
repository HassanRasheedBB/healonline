import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bubbled_navigation_bar/bubbled_navigation_bar.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../constants.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import 'Appointments.dart';
import 'PatientNotifications.dart';
import 'PatientProfile.dart';
import 'fragments/HomePage.dart';
//HomePagePatient

class HomePagePatient extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Patients',
      theme: ThemeData(
        primaryColor: Constants.ThemePrimaryDarkColor,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  final titles = ['Home', 'Appointments', 'Notifications', 'Profile'];
  final components = [
    HomePage(),
    Appointments(),
    PatientNotifications(),
    PatientProfile(),
  ];

  final icons = [
    CupertinoIcons.home,
    CupertinoIcons.calendar,
    CupertinoIcons.bell_solid,
    CupertinoIcons.profile_circled
  ];

  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PageController _pageController;
  MenuPositionController _menuPositionController;
  bool userPageDragging = false;


  @override
  void initState() {
    _menuPositionController = MenuPositionController(initPosition: 0);

    _pageController =
        PageController(initialPage: 0, keepPage: false, viewportFraction: 1.0);
    _pageController.addListener(handlePageChange);

    super.initState();
  }

  void handlePageChange() {
    _menuPositionController.absolutePosition = _pageController.page;
  }

  void checkUserDragging(ScrollNotification scrollNotification) {
    if (scrollNotification is UserScrollNotification &&
        scrollNotification.direction != ScrollDirection.idle) {
      userPageDragging = true;
    } else if (scrollNotification is ScrollEndNotification) {
      userPageDragging = false;
    }
    if (userPageDragging) {
      _menuPositionController.findNearestTarget(_pageController.page);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: NotificationListener<ScrollNotification>(
          onNotification: (scrollNotification) {
            checkUserDragging(scrollNotification);
          },
          child: PageView(
            controller: _pageController,
            children:
                widget.components.map(
                        (Widget widget) => widget
                ).toList(),
            onPageChanged: (page) {},
          ),
        ),
        bottomNavigationBar: BubbledNavigationBar(
          controller: _menuPositionController,
          initialIndex: 0,
          itemMargin: EdgeInsets.symmetric(horizontal: 8),
          backgroundColor: Constants.hexToColor(
            Constants.whiteColor,
          ),
          defaultBubbleColor: Constants.hexToColor(
            Constants.primaryDarkColor,
          ),
          onTap: (index) {
            _pageController.animateToPage(index,
                curve: Curves.easeInOutQuad,
                duration: Duration(milliseconds: 500));
          },
          items: widget.titles.map((title) {
            var index = widget.titles.indexOf(title);
            var icon = widget.icons[index];
            return BubbledNavigationBarItem(
              icon: getIcon(index, Constants.hexToColor(
                Constants.primaryDarkColor,
              )),
              activeIcon: getIcon(index, Constants.hexToColor(
                Constants.whiteColor,
              )),
              bubbleColor: Constants.hexToColor(
                Constants.primaryDarkColor,
              ),
              title: Text(
                title,
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            );
          }).toList(),
        ));
  }

  Padding getIcon(int index, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 3),
      child: Icon(
          widget.icons[index], size: 30, color: color)
      );
  }
}
