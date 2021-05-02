//SettingsScreen
import 'package:HealOnline/patient/StripePaymentScreen.dart';
import 'package:HealOnline/patient/pages/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants.dart';
import 'ContactUsScreen.dart';
import 'FAQScreen.dart';
import 'PasswordChangeScreen.dart';

class SettingsScreen extends StatefulWidget {
  SettingsScreen({Key key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
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
        title: Text("Settings",
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
                   "Change Password",
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
                    "Hotline",
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
                    "FAQ's",
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
                    "About Us",
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
                    "Contact Us",
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