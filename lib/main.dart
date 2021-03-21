import 'dart:async';

import 'package:HealOnline/Utils.dart';
import 'package:HealOnline/doctor/HomePage.dart';
import 'package:HealOnline/models/LoginResponse.dart';
import 'package:HealOnline/patient/HomePagePatient.dart';
import 'package:HealOnline/patient/fragments/HomePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'LoginScreen/login_screen.dart';
import 'constants.dart';
import 'doctor/AllPatientsListScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Constants.ThemePrimaryDarkColor,
      ),
      home: SplashScreen(),
      routes: <String, WidgetBuilder>{
        'main': (context) => new MyApp(),
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FadeIn();
}

class FadeIn extends State<SplashScreen> with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getUserFromSharedPreference();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    );

    Future.delayed(
      Duration(seconds: 2),
      () {
        _controller.stop();
        setState(() {
          _visible = !_visible;
          showLoading();
        });
        goToSignUpSignInPage();
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    Widget image = Image.asset(
      "assets/images/logo.png",
      width: 300,
    );
    return Scaffold(
        body: Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ScaleTransition(scale: _animation, child: image),
              AnimatedOpacity(
                opacity: _visible ? 1.0 : 0.0,
                duration: Duration(milliseconds: 500),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
//                        SizedBox(
//                          height: 8,
//                        ),
//                        Text(
//                          "HealOnline",
//                          style: TextStyle(
//                              fontSize: 26,
//                              fontWeight: FontWeight.bold,
//                              fontFamily: "ProductSans"),
//                        ),
//                        SizedBox(height: 8,),
//                        Text(
//                          "Health is Wealth",
//                          style: TextStyle(
//                              fontSize: 14,
////                          fontWeight: FontWeight.bold,
//                              fontFamily: "ProductSans"),
//                        ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
                padding:
                    EdgeInsets.only(bottom: 24.0, top: 0, left: 0, right: 0),
                child: Opacity(
                  opacity: isLoading ? 1.0 : 00,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Constants.hexToColor(Constants.primaryDarkColor)),
                  ),
                )))
      ],
    ));
  }

  void goToSignUpSignInPage() {
    Future.delayed(
      Duration(seconds: 4),
      () {
        if (Utils.user.is_loggedIn == null || Utils.user.is_loggedIn == "0") {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => LoginPage(),
            ),
          );
        } else {
          if (Utils.user.profile_obj.pmeta_obj.user_type == "patient") {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomePagePatient(),
              ),
            );
          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(),
              ),
            );
          }
        }
      },
    );
  }

  void showLoading() {
    Future.delayed(
      Duration(seconds: 1),
      () {
        setState(() {
          isLoading = true;
          goToSignUpSignInPage();
        });
      },
    );
  }

  Future<void> getUserFromSharedPreference() async {
    if (Utils.user == null) {
      Utils.user = new LoginResponse();

      Utils.user.profile_obj = new profile();
      Utils.user.profile_obj.umeta_obj = umeta();
      Utils.user.profile_obj.pmeta_obj = pmeta();

      SharedPreferences prefs = await SharedPreferences.getInstance();
      Utils.user.token = prefs.getString("token");
      Utils.user.profile_obj.umeta_obj.profile_id = prefs.getInt('profile_id');
      Utils.user.profile_obj.umeta_obj.id = prefs.getInt('id');
      Utils.user.profile_obj.umeta_obj.user_login =
          prefs.getString('user_login');
      Utils.user.profile_obj.umeta_obj.user_pass = prefs.getString('user_pass');
      Utils.user.profile_obj.umeta_obj.user_email =
          prefs.getString('user_email');
      Utils.user.profile_obj.pmeta_obj.user_type = prefs.getString('user_type');
      Utils.user.profile_obj.pmeta_obj.full_name = prefs.getString('full_name');
      Utils.user.profile_obj.pmeta_obj.profile_img =
          prefs.getString('profile_img');
      Utils.user.token = prefs.getString('token');
      Utils.user.is_loggedIn = prefs.getString("loggedIn");
    }
  }
}
