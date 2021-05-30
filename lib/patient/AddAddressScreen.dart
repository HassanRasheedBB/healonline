import 'dart:convert';
import 'dart:io';

import 'package:HealOnline/Utils.dart';
import 'package:HealOnline/localization/language/languages.dart';
import 'package:HealOnline/localization/locale_constant.dart';
import 'package:HealOnline/models/AdditionalAddress.dart';
import 'package:HealOnline/patient/PatientProfile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';
import 'fragments/CityPicker.dart';
import 'package:http/http.dart' as http;

class AddAddressScreen extends StatefulWidget {
  PatientProfileState fragment;
  AddAddressScreen(this.fragment, {Key key}) : super(key: key);

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

  int addressId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAdditionalAddressFromDB();
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
        title: Text(Languages.of(context).add_address,
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
              SizedBox(
                height: 24,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 18),
                child:  TextFormField(textInputAction: TextInputAction.done,
                  key: Key('Address 1'),
                  controller: addressOneController,
                  validator: (value) =>
                      (value.isEmpty) ? Languages.of(context).enter_address : null,
                  decoration: InputDecoration(
                      prefixIcon: Icon(CupertinoIcons.map_pin_ellipse),
                      border: OutlineInputBorder(),
                      hintText: Languages.of(context).address_1,
                      hintStyle: TextStyle(fontFamily: "ProductSans")),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 18),
                child:  TextFormField(textInputAction: TextInputAction.done,
                  key: Key('Address 2'),
                  controller: addressTwoController,
                  validator: (value) =>
                      (value.isEmpty) ? Languages.of(context).enter_address: null,
                  decoration: InputDecoration(
                      prefixIcon: Icon(CupertinoIcons.map_pin_ellipse),
                      border: OutlineInputBorder(),
                      hintText: Languages.of(context).address_2,
                      hintStyle: TextStyle(fontFamily: "ProductSans")),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 18),
                child:  TextFormField(textInputAction: TextInputAction.done,
                  readOnly: true,
                  onTap: () {
                    showCupertinoModalBottomSheet(
                      elevation: 8,
                      topRadius: Radius.circular(24),
                      context: context,
                      builder: (context) => Container(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        height: 600,
                        child: CityPicker("City", true),
                      ),
                    );
                  },
                  key: Key('City Name'),
                  controller: cityController,
                  validator: (value) =>
                      (value.isEmpty) ? Languages.of(context).enter_city : null,
                  decoration: InputDecoration(
                      prefixIcon: Icon(CupertinoIcons.location),
                      suffixIcon: Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Colors.grey,
                      ),
                      border: OutlineInputBorder(),
                      hintText: Languages.of(context).city_name,
                      hintStyle: TextStyle(fontFamily: "ProductSans")),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 18),
                child:  TextFormField(textInputAction: TextInputAction.done,
                  key: Key('Postal / ZipCode'),
                  controller: zipCodeController,
                  validator: (value) =>
                      (value.isEmpty) ? Languages.of(context).enter_postal_code : null,
                  decoration: InputDecoration(
                      prefixIcon: Icon(CupertinoIcons.creditcard),
                      border: OutlineInputBorder(),
                      hintText: Languages.of(context).postal_code,
                      hintStyle: TextStyle(fontFamily: "ProductSans")),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 18),
                child:  TextFormField(textInputAction: TextInputAction.done,
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
                      (value.isEmpty) ? Languages.of(context).select_province : null,
                  decoration: InputDecoration(
                      prefixIcon: Icon(CupertinoIcons.location),
                      suffixIcon: Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Colors.grey,
                      ),
                      border: OutlineInputBorder(),
                      hintText: Languages.of(context).province,
                      hintStyle: TextStyle(fontFamily: "ProductSans")),
                ),
              ),
              SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(bottom: 8),
        child: RoundedLoadingButton(
          width: MediaQuery.of(context).size.width - 32,
          animateOnTap: true,
          color: Constants.hexToColor(Constants.primaryDarkColor),
          elevation: 4,
          borderRadius: 10,
          child: Text(Languages.of(context).save_address,
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
          address1: addressOneController.text.toString(),
          address2: addressTwoController.text.toString(),
          city_name: cityController.text,
          zipCode: zipCodeController.text.toString(),
          province: provinceController.text);

      String url = "";

      if (addressId == 0) {
        url = Utils.baseURL + Utils.UPDATE_ADDRESS;
      } else {
        url = Utils.baseURL + Utils.UPDATE_ADDRESS + "/" + addressId.toString();
      }

      String jsonUser = jsonEncode(additionalAddress);
      Map<String, String> headers = {
        "Content-type": "application/json",
        HttpHeaders.authorizationHeader: "Bearer " + Utils.user.token
      };
      Response response = await post(Uri.parse(url), headers: headers, body: jsonUser);
      int statusCode = response.statusCode;

      if (statusCode == 200) {
        _btnController.reset();
        showAlertDialog(Languages.of(context).success, Languages.of(context).address_updated, context);
      } else {
        _btnController.reset();
        showAlertDialog(
            Languages.of(context).error_string, Languages.of(context).something_went_wrong, context);
      }
    } else {
      _btnController.reset();
      showAlertDialog(
          Languages.of(context).error_string, Languages.of(context).something_went_wrong, context);
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
                  child: Text( Languages.of(context).ok,
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

  Future<void> getAdditionalAddressFromDB() async {
    String url = Utils.baseURL +
        Utils.GET_ADDRESS +
        Utils.user.profile_obj.umeta_obj.profile_id.toString();
    print(url);
    Map<String, String> headers = {
      "Content-type": "application/json",
      HttpHeaders.authorizationHeader: "Bearer " + Utils.user.token
    };
    Response response = await get(Uri.parse(url), headers: headers);
    String body = response.body;
    print(response.body);
    final List typeList = (json.decode(response.body))["addresss"];
    setState(() {
      if (typeList.isNotEmpty) {
        addressOneController.text = typeList[0]["address_1"];
        addressTwoController.text = typeList[0]["address_2"];
        cityController.text = typeList[0]["city"];
        zipCodeController.text = typeList[0]["zipcode"];
        provinceController.text = typeList[0]["province"];
        addressId = typeList[0]["id"];
      }
    });
  }
}

/*






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

 */
