import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants.dart';

class ReferApp extends StatefulWidget {
  ReferApp({Key key}) : super(key: key);

  @override
  _ReferAppState createState() => _ReferAppState();
}

class _ReferAppState extends State<ReferApp> {

  TextEditingController linkController = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomPadding: false,
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
        title: Text("Refer HealOnline App",
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
              height:100,
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

                  Text('Referral Link',
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
                  child: Text('Share with friends',
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
              child: Text('- OR -',
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
                  child: Text('Refer by email',
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