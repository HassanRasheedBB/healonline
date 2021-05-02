
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'models/Appoitment.dart';
//#1185e0, #4dcfe0
class Constants {
  static String primaryColor = "#1185e0";
  static String primaryDarkColor = "#4dcfe0";
  static String whiteColor = "#ffffff";
  static String blackColor = "#000000";
  static String graySepratorColor = "#DCDCDC";

  static var ThemePrimaryDarkColor = const Color(0xFF4dcfe0);

  static Appointment appointment = Appointment("","","","","","","","","","","","","","","");

  static Color hexToColor(String code) {
    return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

  static String fcm_token = "1234";

  static BoxDecoration InputBoxDecoration() {
    return BoxDecoration(
      border: Border.all(
          width: 1.0,
        color: Colors.grey
      ),
      borderRadius: BorderRadius.all(
          Radius.circular(5.0) //                 <--- border radius here
      ),
    );
  }

}