import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../constants.dart';
import 'fragments/CityPicker.dart';

class AddAddressScreen extends StatefulWidget {
  AddAddressScreen({Key key}) : super(key: key);

  @override
  _AddAddressScreenState createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {

  TextEditingController addressOneController = TextEditingController();
  TextEditingController addressTwoController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController zipCodeController = TextEditingController();
  TextEditingController provinceController = TextEditingController();


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
        title: Text("Add Address",
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

          SizedBox(height: 24,),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18),
            child: TextFormField(
              key: Key('Address 1'),
              controller: addressOneController,
              validator: (value) =>
              (value.isEmpty) ? "Please Enter Address" : null,
              decoration: InputDecoration(
                  prefixIcon: Icon(CupertinoIcons.map_pin_ellipse),
                  border: OutlineInputBorder(),
                  hintText: 'Address 1*',
                  hintStyle: TextStyle(fontFamily: "ProductSans")),
            ),
          ),

          SizedBox(
            height:16,
          ),


          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18),
            child: TextFormField(
              key: Key('Address 2'),
              controller: addressTwoController,
              validator: (value) =>
              (value.isEmpty) ? "Please Enter Address" : null,
              decoration: InputDecoration(
                  prefixIcon: Icon(CupertinoIcons.map_pin_ellipse),
                  border: OutlineInputBorder(),
                  hintText: 'Address 2*',
                  hintStyle: TextStyle(fontFamily: "ProductSans")),
            ),
          ),

          SizedBox(
            height:16,
          ),


          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18),
            child: TextFormField(
              readOnly: true,
              onTap: () {
                showCupertinoModalBottomSheet(
                  elevation: 8,
                  topRadius: Radius.circular(24),
                  context: context,
                  builder: (context) => Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    height: 600,
                    child: CityPicker("City",true),
                  ),
                );
              },
              key: Key('City Name'),
              controller: cityController,
              validator: (value) =>
              (value.isEmpty) ? "Please Enter City Name" : null,
              decoration: InputDecoration(
                  prefixIcon: Icon(CupertinoIcons.location),
                  suffixIcon: Icon(Icons.arrow_forward_ios, size: 16, color:Colors.grey,),
                  border: OutlineInputBorder(),
                  hintText: 'City Name*',
                  hintStyle: TextStyle(fontFamily: "ProductSans")),
            ),
          ),

          SizedBox(
            height:16,
          ),


          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18),
            child: TextFormField(
              key: Key('Postal / ZipCode'),
              controller: cityController,
              validator: (value) =>
              (value.isEmpty) ? "Please Enter Postal / Zip Code" : null,
              decoration: InputDecoration(
                  prefixIcon: Icon(CupertinoIcons.creditcard),
                  border: OutlineInputBorder(),
                  hintText: 'Postal / ZipCode*',
                  hintStyle: TextStyle(fontFamily: "ProductSans")),
            ),
          ),

          SizedBox(
            height:16,
          ),


          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18),
            child: TextFormField(
              key: Key('Province'),
              readOnly: true,
              onTap: () {
                showCupertinoModalBottomSheet(
                  elevation: 8,
                  topRadius: Radius.circular(24),
                  context: context,
                  builder: (context) => Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    height: 600,
                    child: CityPicker("Province", true),
                  ),
                );
              },
              controller: cityController,
              validator: (value) =>
              (value.isEmpty) ? "Please Enter Province" : null,
              decoration: InputDecoration(
                  prefixIcon: Icon(CupertinoIcons.location),
                  suffixIcon: Icon(Icons.arrow_forward_ios, size: 16, color:Colors.grey,),
                  border: OutlineInputBorder(),
                  hintText: 'Province*',
                  hintStyle: TextStyle(fontFamily: "ProductSans")),
            ),
          ),

          SizedBox(
            height:16,
          ),

        ],
      ),

      bottomNavigationBar:  Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),

        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(6)),
          color: Constants.hexToColor(Constants.primaryDarkColor),
        ),
        child: FlatButton(

          onPressed: () {
          },
          child: Center(
            child: Text('ADD ADDRESS',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: "ProductSans")),
          ),
        ),
      ),
    );
  }


}