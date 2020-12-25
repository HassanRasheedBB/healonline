import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants.dart';

class AddedPharmaciesScreen extends StatefulWidget {
  AddedPharmaciesScreen({Key key}) : super(key: key);

  @override
  _AddedPharmaciesScreenState createState() => _AddedPharmaciesScreenState();
}

class _AddedPharmaciesScreenState extends State<AddedPharmaciesScreen> {
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
        title: Text("Pharmacies",
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

         Padding(
           padding: EdgeInsets.only(top: 16),
           child:  Align(
               alignment: Alignment.topCenter,
               child:  Text('Preferred Pharmacy is a pharmacy where you\nwould like us to send your prescription.',
                   textAlign: TextAlign.center,
                   style: TextStyle(
                       color: Colors.grey,
                       fontSize: 15,
                       fontFamily: "ProductSans")
               )
           ),
         ),

          SizedBox(
            height: 24
          ),




          Padding(
              padding: EdgeInsets.only(top: 8, bottom: 16, right: 16, left: 16),
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      onTap: () {

                      },
                      title: Text(
                        "Shoppers Drug Mart",
                        style: TextStyle(
                          fontFamily: "ProductSans",
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Constants.hexToColor(Constants.blackColor),
                        ),
                      ),
                      subtitle: Text(
                        "Ontario",
                        style: TextStyle(
                          fontFamily: "ProductSans",
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      leading: Padding(
                        padding: EdgeInsets.only(top:6, left: 8),
                        child: Icon(CupertinoIcons.lab_flask_solid,
                            color: Constants.hexToColor(Constants.primaryDarkColor)),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Divider(
                        color:
                        Constants.hexToColor(Constants.graySepratorColor),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 16, top: 8),
                          child: Text(
                            "Delete",
                            style: TextStyle(
                                fontFamily: "ProductSans",
                                fontSize: 14,
                                color: Colors.red),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 16, top: 8),
                          child: Container(
                            width: 1,
                            height: 20,
                            color: Constants.hexToColor(
                                Constants.graySepratorColor),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 16, top: 8),
                          child: Text(
                            "Edit",
                            style: TextStyle(
                                fontFamily: "ProductSans",
                                fontSize: 14,
                                color: Constants.hexToColor(Constants.primaryDarkColor)),
                          ),
                        ),
                      ],
                    )
                  ],
                ),

                //
              )),


        ],
      )
    );
  }

}