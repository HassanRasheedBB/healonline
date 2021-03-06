//SettingsScreen
import 'package:HealOnline/LoginScreen/login_screen.dart';
import 'package:HealOnline/localization/language/languages.dart';
import 'package:HealOnline/localization/locale_constant.dart';
import 'package:HealOnline/patient/PatientProfile.dart';
import 'package:HealOnline/patient/StripePaymentScreen.dart';
import 'package:HealOnline/patient/pages/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants.dart';
import 'ContactUsScreen.dart';
import 'FAQScreen.dart';
import 'PasswordChangeScreen.dart';

class SettingsScreen extends StatefulWidget {
  PatientProfileState fragment;
  SettingsScreen(this.fragment, {Key key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {



  String savedCode;
  getLocale() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String languageCode = _prefs.getString(prefSelectedLanguageCode);

    if (languageCode != null) {
      savedCode = languageCode;
      changeLanguage(context, savedCode, false);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getLocale();
    super.initState();


  }


  @override
  void dispose() {
    super.dispose();
    if(widget.fragment != null) {
      widget.fragment.getLocale();
    }
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 8,
        backgroundColor: Constants.hexToColor(Constants.whiteColor),
        leading: Padding(
            padding: EdgeInsets.only(left: 14),
            child: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Icon(Icons.arrow_back_ios,
                  color: Constants.hexToColor(Constants.blackColor)),
            )),
        title: Text(Languages.of(context).settings,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: "ProductSans",
                color: Constants.hexToColor(Constants.primaryDarkColor))),
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          SizedBox(height: 16),
         Padding(
           padding: EdgeInsets.symmetric(horizontal: 16),
           child:  Material(
             elevation: 4,
             shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(8.0),
             ),
             child: Padding(
               padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
               child: ListTile(
                 onTap: (){
                   Navigator.push(
                     context,
                     MaterialPageRoute(
                       builder: (context) => PasswordChangeScreen(),
                     ),
                   );
                 },
                 title: Text(
                   Languages.of(context).change_password,
                   style: TextStyle(
                     fontFamily: "ProductSans",
                     fontSize: 18,
                     fontWeight: FontWeight.w400,
                     color: Constants.hexToColor(Constants.blackColor),
                   ),
                 ),
                 trailing: Icon(Icons.arrow_forward_ios, size: 18, color: Constants.hexToColor(Constants.graySepratorColor),),
               ),
             ),
           ),
         ),

          SizedBox(height: 12),
         Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child:  Material(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: ListTile(

                  onTap: () async {

                    const url = "tel:+19055540200";
                    if (await canLaunch(url)) {
                    await launch(url);
                    } else {
                    throw 'Could not launch $url';
                    }

                  },

                  title: Text(
                    Languages.of(context).hotline,
                    style: TextStyle(
                      fontFamily: "ProductSans",
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Constants.hexToColor(Constants.blackColor),
                    ),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios, size: 18, color: Constants.hexToColor(Constants.graySepratorColor),),
                ),
              ),
            ),
          ),


          SizedBox(height: 12),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child:  Material(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: ListTile(

                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FAQScreen(),
                      ),
                    );
                  },

                  title: Text(
                    Languages.of(context).faq,
                    style: TextStyle(
                      fontFamily: "ProductSans",
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Constants.hexToColor(Constants.blackColor),
                    ),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios, size: 18, color: Constants.hexToColor(Constants.graySepratorColor),),
                ),
              ),
            ),
          ),

          SizedBox(height: 12),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child:  Material(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: ListTile(
                  onTap: () async {
                    String url = "https://healonline.ca/index.html";
                    if (await canLaunch(url)) {
                    await launch(url);
                    } else {
                    throw 'Could not launch $url';
                    }
                  },
                  title: Text(
                    Languages.of(context).about_us,
                    style: TextStyle(
                      fontFamily: "ProductSans",
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Constants.hexToColor(Constants.blackColor),
                    ),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios, size: 18, color: Constants.hexToColor(Constants.graySepratorColor),),
                ),
              ),
            ),
          ),

          SizedBox(height: 12),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child:  Material(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: ListTile(

                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ContactUsScreen(),
                      ),
                    );
                  },

                  title: Text(
                    Languages.of(context).contact_us,
                    style: TextStyle(
                      fontFamily: "ProductSans",
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Constants.hexToColor(Constants.blackColor),
                    ),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios, size: 18, color: Constants.hexToColor(Constants.graySepratorColor),),
                ),
              ),
            ),
          ),




          // SizedBox(height: 12),
          // Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 16),
          //   child:  Material(
          //     elevation: 4,
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(8.0),
          //     ),
          //     child: Padding(
          //       padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          //       child: ListTile(
          //           onTap: () async {
          //             Navigator.push(
          //               context,
          //               MaterialPageRoute(
          //                 builder: (context) => PaymentHomePage(),
          //               ),
          //             );
          //           },
          //         title: Text(
          //           "Payment Due",
          //           style: TextStyle(
          //             fontFamily: "ProductSans",
          //             fontSize: 18,
          //             fontWeight: FontWeight.w400,
          //             color: Constants.hexToColor(Constants.blackColor),
          //           ),
          //         ),
          //         trailing: Icon(Icons.arrow_forward_ios, size: 18, color: Constants.hexToColor(Constants.graySepratorColor),),
          //       ),
          //     ),
          //   ),
          // ),


        ],
      ),
    );
  }

}