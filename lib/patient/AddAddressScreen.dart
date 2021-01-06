import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healonline/models/AdditionalAddress.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:firebase_database/firebase_database.dart' as firebase_database;

import '../constants.dart';
import 'fragments/CityPicker.dart';

class AddAddressScreen extends StatefulWidget {
  AddAddressScreen({Key key}) : super(key: key);

  @override
  AddAddressScreenState createState() => AddAddressScreenState();


}

class AddAddressScreenState extends State<AddAddressScreen> {

  TextEditingController addressOneController = TextEditingController();
  TextEditingController addressTwoController = TextEditingController();
  static TextEditingController cityController = TextEditingController();
  TextEditingController zipCodeController = TextEditingController();
  static TextEditingController provinceController = TextEditingController();

  final RoundedLoadingButtonController _btnController =
  new RoundedLoadingButtonController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  AdditionalAddress address;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAdditionalAddressFromDB();
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
        title: Text("Add Address",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: "ProductSans",
                color: Constants.hexToColor(Constants.primaryDarkColor))),
      ),

      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
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
                  controller: zipCodeController,
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
                  controller: provinceController,
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
        ),
      ),

      bottomNavigationBar:  Container(
        margin: EdgeInsets.only(bottom: 8),
        child: RoundedLoadingButton(
          width: MediaQuery.of(context).size.width - 32,
          animateOnTap: true,
          color: Constants.hexToColor(Constants.primaryDarkColor),
          elevation: 4,
          borderRadius: 10,
          child: Text('SAVE ADDRESS',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: "ProductSans")),
          controller: _btnController,
          onPressed: () {
            saveAddress();
          },
        ),
      ),
    );
  }

  Future<void> saveAddress() async {
    if (_formKey.currentState.validate()) {

      AdditionalAddress additionalAddress = new AdditionalAddress(
          addressOneController.text.toString(), addressTwoController.text.toString(), cityController.text,
        zipCodeController.text.toString(), provinceController.text
      );

      final mainReference =
      firebase_database.FirebaseDatabase.instance.reference();

      String key = mainReference.child("additional_address").child("09007860101").push().key;
      await mainReference.child("additional_address").child("09007860101").remove();


      mainReference
          .child("additional_address")
          .child("09007860101")
          .child(key)
          .set(additionalAddress.toJson())
          .then((value) {
        showAlertDialog("Success", 'Address saved successfully !', context);
        _btnController.success();
      }, onError: (error) {
        _btnController.reset();
        showAlertDialog(
            "Server Error", 'Address not added please try again', context);
      }).catchError((error) {
        _btnController.reset();
        showAlertDialog(
            "Server Error", 'Address not added please try again', context);
      });

    }else{
      _btnController.reset();
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
              },
            )
          ],
        ));
  }

  static String selectedCity;
  static String selectedProvince;

  static void updateCity(String loc) {
    cityController.text = loc;
  }

  static void updateProvince(String loc) {
    provinceController.text = loc;
  }

  void getAdditionalAddressFromDB() {
    final databaseReference = FirebaseDatabase.instance.reference();
    databaseReference.child("additional_address").child("09007860101").once().then(
            (DataSnapshot snapshot) {
          if (snapshot != null) {

            setState(() {

              Map<dynamic, dynamic> values = snapshot.value;
              values.forEach((key, value) {
                addressOneController.text = value["address1"];
                addressTwoController.text = value["address2"];
                cityController.text = value["city_name"];
                zipCodeController.text = value["zipCode"];
                provinceController.text = value["province"];
              });

            });
          }
        }, onError: (error) {}).catchError((error) {});
  }


}