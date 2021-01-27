//PatientProfile
import 'package:HealOnline/LoginScreen/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants.dart';
import 'AddAddressScreen.dart';
import 'AddedPharmaciesScreen.dart';
import 'EditProfileScreen.dart';
import 'ReferApp.dart';
import 'SaveCardScreen.dart';
import 'SettingsScreen.dart';

class PatientProfile extends StatefulWidget {
  PatientProfile({Key key}) : super(key: key);

  @override
  _PatientProfileState createState() => _PatientProfileState();
}

class _PatientProfileState extends State<PatientProfile> {
  final double circleRadius = 80.0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Padding(
              padding: EdgeInsets.only(right: 8),
              child: Icon(CupertinoIcons.settings, color: Constants.hexToColor(Constants.primaryDarkColor),),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingsScreen(),
                ),
              );
            },
          )
        ],
        backgroundColor: Constants.hexToColor(Constants.whiteColor),
        title: Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Text(
            "Profile",
            style: TextStyle(
              fontFamily: "ProductSans",
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Constants.hexToColor(
                Constants.primaryDarkColor,
              ),
            ),
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 24,
          ),
         Padding(
           padding: EdgeInsets.symmetric(horizontal: 8),
           child:  ListTile(
             onTap: (){
               Navigator.push(
                 context,
                 MaterialPageRoute(
                   builder: (context) => EditProfileScreen(),
                 ),
               );
             },
             leading: SvgPicture.asset(
               "assets/images/user_avatar.svg",
             ),
             title: Text('Anya Wayne',
                 style: TextStyle(
                     color: Constants.hexToColor(
                       Constants.primaryDarkColor,
                     ),
                     fontSize: 20,
                     fontWeight: FontWeight.w500,
                     fontFamily: "ProductSans")),
             subtitle: Padding(
               padding: EdgeInsets.only(top:3),
               child: Text('+1 6472059600',
                   style: TextStyle(
                     fontSize: 13,
                       color: Colors.grey,
                       fontFamily: "ProductSans")),
             ),
             trailing: Icon(Icons.arrow_forward_ios, size: 20, color: Constants.hexToColor(Constants.primaryDarkColor),),
           ),
         ),

          SizedBox(
            height: 28,
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: ListTile(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditProfileScreen(),
                  ),
                );
              },
              leading: Icon(CupertinoIcons.profile_circled,
                size: 28,
                color: Constants.hexToColor(Constants.primaryDarkColor),),
              title: Text('Personal Info',
                  style: TextStyle(
                      color: Constants.hexToColor(
                        Constants.blackColor,
                      ),
                      fontSize: 18,
                      fontFamily: "ProductSans")),
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 22),
            child: Divider(),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: ListTile(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddedPharmaciesScreen(),
                  ),
                );
              },
              leading: Icon(CupertinoIcons.lab_flask_solid,
                size: 28,
                color: Constants.hexToColor(Constants.primaryDarkColor),),
              title: Text('Pharmacies',
                  style: TextStyle(
                      color: Constants.hexToColor(
                        Constants.blackColor,
                      ),
                      fontSize: 18,
                      fontFamily: "ProductSans")),
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 22),
            child: Divider(),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: ListTile(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ReferApp(),
                  ),
                );
              },
              leading: Icon(CupertinoIcons.person_3_fill,
                size: 28,
                color: Constants.hexToColor(Constants.primaryDarkColor),),
              title: Text('Refer Healonline App',
                  style: TextStyle(
                      color: Constants.hexToColor(
                        Constants.blackColor,
                      ),
                      fontSize: 18,
                      fontFamily: "ProductSans")),
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 22),
            child: Divider(),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: ListTile(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddAddressScreen(),
                  ),
                );
              },
              leading: Icon(CupertinoIcons.map_pin_ellipse,
                size: 28,
                color: Constants.hexToColor(Constants.primaryDarkColor),),
              title: Text('Address',
                  style: TextStyle(
                      color: Constants.hexToColor(
                        Constants.blackColor,
                      ),
                      fontSize: 18,
                      fontFamily: "ProductSans")),
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 22),
            child: Divider(),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: ListTile(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SaveCardScreen(),
                  ),
                );
              },
              leading: Icon(CupertinoIcons.creditcard_fill,
                size: 28,
                color: Constants.hexToColor(Constants.primaryDarkColor),),
              title: Text('Payment Method',
                  style: TextStyle(
                      color: Constants.hexToColor(
                        Constants.blackColor,
                      ),
                      fontSize: 18,
                      fontFamily: "ProductSans")),
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 22),
            child: Divider(),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: ListTile(
              leading: Icon(Icons.logout,
                size: 28,
                color: Constants.hexToColor(Constants.primaryDarkColor),),
              title: Text('Log Out',
                  style: TextStyle(
                      color: Constants.hexToColor(
                        Constants.blackColor,
                      ),
                      fontSize: 18,
                      fontFamily: "ProductSans")),

              onTap: (){
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ),
                );
              },
            ),
          ),

        ],
      ),
    );
  }
}
