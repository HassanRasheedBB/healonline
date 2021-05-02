//PatientProfile
import 'dart:convert';
import 'dart:io';

import 'package:HealOnline/LoginScreen/login_screen.dart';
import 'package:HealOnline/Utils.dart';
import 'package:HealOnline/VideoCall/index.dart';
import 'package:HealOnline/models/ContactUsModel.dart';
import 'package:HealOnline/patient/HealthCardScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  TextEditingController commentsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Padding(
              padding: EdgeInsets.only(right: 8),
              child: Icon(
                CupertinoIcons.settings,
                color: Constants.hexToColor(Constants.primaryDarkColor),
              ),
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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 24,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: ListTile(
                onTap: () {
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
                title: Text(Utils.user.profile_obj.pmeta_obj.full_name,
                    style: TextStyle(
                        color: Constants.hexToColor(
                          Constants.primaryDarkColor,
                        ),
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        fontFamily: "ProductSans")),
                subtitle: Padding(
                  padding: EdgeInsets.only(top: 3),
                  child: Text(Utils.user.profile_obj.umeta_obj.user_login,
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                          fontFamily: "ProductSans")),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                  color: Constants.hexToColor(Constants.primaryDarkColor),
                ),
              ),
            ),

            SizedBox(
              height: 28,
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditProfileScreen(),
                    ),
                  );
                },
                leading: Icon(
                  CupertinoIcons.profile_circled,
                  size: 28,
                  color: Constants.hexToColor(Constants.primaryDarkColor),
                ),
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
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HealthCardScreen(),
                    ),
                  );
                },
                leading: Icon(
                  CupertinoIcons.creditcard,
                  size: 28,
                  color: Constants.hexToColor(Constants.primaryDarkColor),
                ),
                title: Text('Health Card',
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
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ReferApp(),
                    ),
                  );
                },
                leading: Icon(
                  CupertinoIcons.person_3_fill,
                  size: 28,
                  color: Constants.hexToColor(Constants.primaryDarkColor),
                ),
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
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddAddressScreen(),
                    ),
                  );
                },
                leading: Icon(
                  CupertinoIcons.map_pin_ellipse,
                  size: 28,
                  color: Constants.hexToColor(Constants.primaryDarkColor),
                ),
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
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SaveCardScreen(),
                    ),
                  );
                },
                leading: Icon(
                  CupertinoIcons.creditcard_fill,
                  size: 28,
                  color: Constants.hexToColor(Constants.primaryDarkColor),
                ),
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

            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 8),
            //   child: ListTile(
            //     onTap: (){
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //           builder: (context) => IndexPage(),
            //         ),
            //       );
            //     },
            //     leading: Icon(CupertinoIcons.video_camera_solid,
            //       size: 28,
            //       color: Constants.hexToColor(Constants.primaryDarkColor),),
            //     title: Text('Video Call',
            //         style: TextStyle(
            //             color: Constants.hexToColor(
            //               Constants.blackColor,
            //             ),
            //             fontSize: 18,
            //             fontFamily: "ProductSans")),
            //   ),
            // ),

            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 22),
            //   child: Divider(),
            // ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: ListTile(
                leading: Icon(
                  Icons.feedback,
                  size: 28,
                  color: Constants.hexToColor(Constants.primaryDarkColor),
                ),
                title: Text('Feedback',
                    style: TextStyle(
                        color: Constants.hexToColor(
                          Constants.blackColor,
                        ),
                        fontSize: 18,
                        fontFamily: "ProductSans")),
                onTap: () async {
                  showRatingDialog();
                },
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 22),
              child: Divider(),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: ListTile(
                leading: Icon(
                  Icons.logout,
                  size: 28,
                  color: Constants.hexToColor(Constants.primaryDarkColor),
                ),
                title: Text('Log Out',
                    style: TextStyle(
                        color: Constants.hexToColor(
                          Constants.blackColor,
                        ),
                        fontSize: 18,
                        fontFamily: "ProductSans")),
                onTap: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
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
            ),
          ],
        ),
      ),
    );
  }

  double rating;

  void showRatingDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: Container(
              height: 290,
              child: Column(
                children: [
                  SizedBox(
                    height: 12,
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        child: Text(
                          "Did you like the app?",
                          style: TextStyle(
                              fontFamily: "ProductSans",
                              color: Colors.black,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                      )),
                  SizedBox(
                    height: 8,
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        child: Text(
                          "Let us know what you think",
                          style: TextStyle(
                            fontFamily: "ProductSans",
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                      )),


                  SizedBox(
                    height: 16,
                  ),
                  RatingBar.builder(
                    initialRating: 3,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 3.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Constants.hexToColor(Constants.primaryColor),
                    ),
                    onRatingUpdate: (rating) {
                      print(rating);
                      this.rating = rating;
                    },
                  ),


                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    height:100,
                    padding: EdgeInsets.symmetric(horizontal:16),
                    child:  TextFormField(
                      controller: commentsController,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.multiline,
                      maxLines: 4,
                      key: Key('Location'),
                      validator: (value) =>
                      (value.isEmpty) ? "Please Enter Message" : null,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Comments',
                          hintStyle: TextStyle(fontFamily: "ProductSans")),
                    ),
                  ),


                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 16, top: 12),
                        child: InkWell(

                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            "CANCEL",
                            style: TextStyle(
                                color: Constants.hexToColor(Constants.primaryColor),
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                fontFamily: "ProductSans"),
                          ),
                        ),
                      ),


                      Padding(
                        padding: EdgeInsets.only(right: 16, top: 12),
                        child: InkWell(

                          onTap: () {
                            sendQueryToAdmin();
                          },
                          child: Text(
                            "SEND COMMENT",
                            style: TextStyle(
                                color: Constants.hexToColor(Constants.primaryColor),
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                fontFamily: "ProductSans"),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  Future<void> sendQueryToAdmin() async {


    String name = Utils.user.profile_obj.pmeta_obj.full_name;
    String email = Utils.user.profile_obj.umeta_obj.user_email;
    String msg = commentsController.text;

    ContactUs contactUsModel = new ContactUs(
        message: msg,
        email: email
    );
    contactUsModel.rating = rating.toString();


    String jsonUser = jsonEncode(contactUsModel);
    Map<String, String> headers = {
      "Content-type": "application/json",
      HttpHeaders.authorizationHeader: "Bearer " + Utils.user.token
    };

    print(jsonUser);
    String url = Utils.baseURL + Utils.QUERY_TO_ADMIN;
    print(url);

    Response response = await post(Uri.parse(url), headers: headers, body: jsonUser);
    int statusCode = response.statusCode;

    print(statusCode);
    print(response.body);
    print(Utils.user.token);

    if (statusCode == 200) {
      showAlertDialog("Success", "Thank you so much for your feedback !", context);

    } else {
      showAlertDialog(
          "Error", "Something went wrong please try again", context);
    }


  }

  void showAlertDialog(String title, String msg, BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: Text(title,
              style: TextStyle(
                fontFamily: "ProductSans",
              )),
          content: Text(msg,
              style: TextStyle(
                fontFamily: "ProductSans",
              )),
          actions: [
            CupertinoDialogAction(
              child: Text("OK",
                  style: TextStyle(
                    fontFamily: "ProductSans",
                  )),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            )
          ],
        ));
  }

}
