import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp();

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
                        valueColor: AlwaysStoppedAnimation<Color>(Constants.hexToColor(Constants.primaryDarkColor)),
                      ),
                    )))
          ],
        )
    );
  }

  void goToSignUpSignInPage() {
    Future.delayed(
      Duration(seconds: 4),
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginPage(),
          ),
        );
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
}
