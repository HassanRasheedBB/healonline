
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Constants {
  static String primaryColor = "#4dcfe0";
  static String primaryDarkColor = "#1185e0";
  static String whiteColor = "#ffffff";
  static String blackColor = "#000000";
  static String graySepratorColor = "#DCDCDC";



  static Color hexToColor(String code) {
    return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }


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