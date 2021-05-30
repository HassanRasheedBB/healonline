//PasswordChangeScreen
import 'dart:convert';
import 'dart:io';

import 'package:HealOnline/Utils.dart';
import 'package:HealOnline/localization/language/languages.dart';
import 'package:HealOnline/localization/locale_constant.dart';
import 'package:HealOnline/models/HealthCardModel.dart';
import 'package:HealOnline/patient/PatientProfile.dart';
import 'package:HealOnline/patient/SchedualAppointmentScreen.dart';
import 'package:HealOnline/patient/fragments/CityPicker.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

class HealthCardScreen extends StatefulWidget {
  PatientProfileState fragment;
  bool showMessage = false;
  HealthCardScreen(this.fragment, {Key key, this.showMessage}) : super(key: key);

  @override
  HealthCardScreenState createState() => HealthCardScreenState();
}

class HealthCardScreenState extends State<HealthCardScreen> {
  static TextEditingController provinceController = TextEditingController();
  TextEditingController cardNoController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController sexTextController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController postalCodeController = TextEditingController();

  List<String> _gender = ["Male", "Female", "Other"];
  String selectedGender;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final RoundedLoadingButtonController _btnController =
      new RoundedLoadingButtonController();

  @override
  void initState() {
    getHealthCard();
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
    if(widget.fragment != null) {
      widget.fragment.getLocale();
    }
  }



  @override
  Widget build(BuildContext context) {
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
        title: Text(Languages.of(context).health_card,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 24,
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
                        child: CityPicker("Province", true),
                      ),
                    );
                  },
                  key: Key('Health'),
                  controller: provinceController,
                  validator: (value) =>
                      (value.isEmpty) ? Languages.of(context).select_province : null,
                  decoration: InputDecoration(
                      suffixIcon: Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Colors.grey,
                      ),
                      prefixIcon: Icon(CupertinoIcons.location),
                      border: OutlineInputBorder(),
                      hintText: Languages.of(context).province,
                      hintStyle: TextStyle(fontFamily: "ProductSans")),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 18),
                child:  TextFormField(textInputAction: TextInputAction.done,
                  key: Key('Health Card'),
                  controller: cardNoController,
                  validator: (value) =>
                      (value.isEmpty) ? Languages.of(context).enter_health_card_no : null,
                  decoration: InputDecoration(
                      prefixIcon: Icon(CupertinoIcons.number_circle),
                      border: OutlineInputBorder(),
                      hintText: Languages.of(context).health_card_no,
                      hintStyle: TextStyle(fontFamily: "ProductSans")),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 18),
                child:  TextFormField(textInputAction: TextInputAction.done,
                  onTap: () {
                    _selectDate(context);
                  },
                  readOnly: true,
                  key: Key('DOB'),
                  controller: dobController,
                  validator: (value) =>
                      (value.isEmpty) ? Languages.of(context).enter_date_of_birth : null,
                  decoration: InputDecoration(
                      prefixIcon: Icon(CupertinoIcons.calendar),
                      border: OutlineInputBorder(),
                      hintText: Languages.of(context).dob_hint,
                      hintStyle: TextStyle(fontFamily: "ProductSans")),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 18),
                child:  TextFormField(textInputAction: TextInputAction.done,
                  key: Key('Phone Number'),
                  controller: phoneController,
                  validator: (value) =>
                      (value.isEmpty) ? Languages.of(context).please_enter_phone_number : null,
                  decoration: InputDecoration(
                      prefixIcon: Icon(CupertinoIcons.phone_fill),
                      border: OutlineInputBorder(),
                      hintText: Languages.of(context).phone_number,
                      hintStyle: TextStyle(fontFamily: "ProductSans")),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 18),
                child:  TextFormField(textInputAction: TextInputAction.done,
                  key: Key('Address'),
                  controller: addressController,
                  validator: (value) =>
                      (value.isEmpty) ? Languages.of(context).enter_address : null,
                  decoration: InputDecoration(
                      prefixIcon: Icon(CupertinoIcons.location_solid),
                      border: OutlineInputBorder(),
                      hintText: Languages.of(context).email_address_hint,
                      hintStyle: TextStyle(fontFamily: "ProductSans")),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                child: InputDecorator(
                    decoration: InputDecoration(
                      labelText: Languages.of(context).gender,
                      labelStyle: Theme.of(context)
                          .primaryTextTheme
                          .caption
                          .copyWith(color: Colors.black),
                      border: const OutlineInputBorder(),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        hint: Text(
                            Languages.of(context).gender,
                          style: TextStyle(fontFamily: "ProductSans"),
                        ),
                        //isExpanded: true,
                        isDense: true,
                        // Reduces the dropdowns height by +/- 50%
                        icon: Icon(Icons.keyboard_arrow_down),
                        value: selectedGender,
                        items: _gender.map((item) {
                          return DropdownMenuItem(
                            value: item,
                            child: Text(
                              item,
                              style: TextStyle(fontFamily: "ProductSans"),
                            ),
                          );
                        }).toList(),
                        onChanged: (selectedItem) =>
                            setState(() => selectedGender = selectedItem),
                      ),
                    )),
              ),
              SizedBox(
                height: 16,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 18),
                child:  TextFormField(textInputAction: TextInputAction.done,
                  key: Key('Postal Code'),
                  controller: postalCodeController,
                  validator: (value) =>
                      (value.isEmpty) ? Languages.of(context).enter_postal_code : null,
                  decoration: InputDecoration(
                      prefixIcon: Icon(CupertinoIcons.number_circle),
                      border: OutlineInputBorder(),
                      hintText: Languages.of(context).postal_code,
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
          child: Text(Languages.of(context).update_card,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: "ProductSans")),
          controller: _btnController,
          onPressed: () {
            updateInformation();
          },
        ),
      ),
    );
  }

  static void updateProvince(String citi) {
    provinceController.text = citi;
  }


  Future<void> updateInformation() async {
    if (_formKey.currentState.validate()) {
      HealthCardModel healthCardModel = new HealthCardModel(
          health_card_province: provinceController.text,
          province: provinceController.text,
          address: addressController.text,
          dob: dobController.text,
          city: provinceController.text,
          number: cardNoController.text,
          phone: phoneController.text,
          sex: selectedGender,
          postal_code: postalCodeController.text);

      String url = Utils.baseURL + Utils.HEALTH_CARD;;

      String jsonUser = jsonEncode(healthCardModel);
      Map<String, String> headers = {
        "Content-type": "application/json",
        HttpHeaders.authorizationHeader: "Bearer " + Utils.user.token
      };
      Response response = await post(Uri.parse(url), headers: headers, body: jsonUser);
      int statusCode = response.statusCode;

      print(url);
      print(jsonUser);
      print(response.body);

      if (statusCode == 200) {
        _btnController.reset();
        if(widget.showMessage){
          if(SchedualAppointmentScreenState.healthCard == null){
            SchedualAppointmentScreenState.healthCard = healthCardModel;
          }
        }
        showAlertDialog(
            Languages.of(context).success, Languages.of(context).card_updated, context);

        if (Platform.isIOS) {
          getNotificationForIos();
        }

      } else {
        _btnController.reset();
        showAlertDialog(
            Languages.of(context).error_string, Languages.of(context).something_went_wrong, context);
      }
    } else {
      showAlertDialog(
          Languages.of(context).error_string, Languages.of(context).something_went_wrong, context);
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
                  child: Text(Languages.of(context).ok,
                      style: TextStyle(
                        fontFamily: "ProductSans",
                      )),
                  onPressed: () {
                    Navigator.of(context).pop();
                    if(widget.showMessage){
                      Navigator.of(context).pop();
                    }
                  },
                )
              ],
            ));
  }

  DateTime selectedDate = DateTime.now();

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(1900),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        dobController.text = "${selectedDate.toLocal()}".split(' ')[0];
      });
  }

  Future<void> getHealthCard() async {
    String url = Utils.baseURL + Utils.HEALTH_CARD;

    print(url);
    Map<String, String> headers = {
      "Content-type": "application/json",
      HttpHeaders.authorizationHeader: "Bearer " + Utils.user.token
    };
    Response response = await get(Uri.parse(url), headers: headers);
    String body = response.body;
    print(response.body);

    var healthCard = (json.decode(response.body))["card"];
    setState(() {
      if (healthCard != null) {
        provinceController.text = healthCard["province"];
        cardNoController.text = healthCard["number"];
        dobController.text = healthCard["dob"];
        phoneController.text = healthCard["phone"];
        addressController.text = healthCard["address"];
        postalCodeController.text = healthCard["postal_code"];

        if (_gender[0] == healthCard["sex"]) {
          selectedGender = _gender[0];
        } else if (_gender[1] == healthCard["sex"]) {
          selectedGender = _gender[1];
        } else {
          selectedGender = _gender[2];
        }
      }
    });
  }

  Future<void> getNotificationForIos() async {

    String url = Utils.baseURL +
        Utils.GET_NOTIFICATIONS ;
    print(url);
    Map<String, String> headers = {
      "Content-type": "application/json",
      HttpHeaders.authorizationHeader: "Bearer " + Utils.user.token
    };
    print(Utils.user.token);
    Response response = await get(Uri.parse(url), headers: headers);
    String body = response.body;
    print(response.body);

    if(response.statusCode == 200) {

      final List typeList = (json.decode(response.body))["notifications"];
      if (typeList != null) {
        for (int i = 0; i < typeList.length; i++) {
          if (typeList[i]["title"] == "Health Card") {

            AwesomeNotifications().createNotification(
                content: NotificationContent(
                    id: 10,
                    channelKey: 'basic_channel',
                    title: typeList[i]["title"],
                    body: typeList[i]["body"]
                )
            );
            break;
          }
        }
      }
    }

  }


}
