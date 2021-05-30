import 'package:HealOnline/localization/language/languages.dart';
import 'package:HealOnline/localization/locale_constant.dart';
import 'package:HealOnline/patient/PatientProfile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

class ReferApp extends StatefulWidget {
  PatientProfileState fragment;
  ReferApp(this.fragment, {Key key}) : super(key: key);

  @override
  _ReferAppState createState() => _ReferAppState();
}

class _ReferAppState extends State<ReferApp> {

  TextEditingController linkController = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocale();

  }



  String savedCode;
  getLocale() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String languageCode = _prefs.getString(prefSelectedLanguageCode);

    if (languageCode != null) {
      savedCode = languageCode;
      changeLanguage(context, savedCode, true);

    }
  }

  @override
  void dispose() {
    super.dispose();
    widget.fragment.getLocale();
  }



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
        title: Text(Languages.of(context).refer_app,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: "ProductSans",
                color: Constants.hexToColor(Constants.primaryDarkColor))),
      ),

      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [

            SizedBox(height: 34,),

            Container(
              width: MediaQuery.of(context).size.width,
              height: 200,
              child:  Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: SvgPicture.asset(
                  "assets/images/sharing.svg",
                  fit: BoxFit.contain,
                ),
              ),
            ),

            SizedBox(height: 32,),

            Container(
              height:105,
              padding: EdgeInsets.all(12),
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal:22),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                      Radius.circular(8.0) //
                  ),
                  border: Border.all(color:Colors.black26,)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [

                  Text(Languages.of(context).referal_link,
                      style: TextStyle(
                          color: Constants.hexToColor(
                            Constants.primaryColor,
                          ),
                          fontSize: 14,
                          fontFamily: "ProductSans")
                  ),


                  SizedBox(height: 8,),
                  Text('http://healonlineca.page.link\n/8LlopqTu8uLp0',
                      style: TextStyle(
                          color: Constants.hexToColor(
                            Constants.primaryDarkColor,
                          ),
                          fontSize: 18,
                          fontFamily: "ProductSans")
                  ),


                ],
              ),
            ),

            SizedBox(height: 16,),

            Container(
              margin: EdgeInsets.symmetric(horizontal: 22),
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                color: Constants.hexToColor(Constants.primaryDarkColor),
              ),
              child: FlatButton(
                onPressed: () {
                },
                child: Center(
                  child: Text(Languages.of(context).share_with_friends,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: "ProductSans")),
                ),
              ),
            ),


            SizedBox(height: 20,),

            Align(
              alignment: Alignment.center,
              child: Text(Languages.of(context).or_string,
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      fontFamily: "ProductSans")),
            ),

            SizedBox(height: 20,),


            Container(
              margin: EdgeInsets.symmetric(horizontal: 22),
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                color: Constants.hexToColor(Constants.whiteColor),
                border: Border.all(color:Constants.hexToColor(Constants.primaryDarkColor),)
              ),
              child: FlatButton(
                onPressed: () {
                },
                child: Center(
                  child: Text(Languages.of(context).refer_email,
                      style: TextStyle(
                          color: Constants.hexToColor(Constants.primaryDarkColor),
                          fontSize: 16,
                          fontFamily: "ProductSans")),
                ),
              ),
            ),

          ],
        ),
      ),

    );
  }



}