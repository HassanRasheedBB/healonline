//EditProfileScreen

import 'dart:convert';
import 'dart:io';

import 'package:HealOnline/Utils.dart';
import 'package:HealOnline/localization/language/languages.dart';
import 'package:HealOnline/localization/locale_constant.dart';
import 'package:HealOnline/models/PatientModel.dart';
import 'package:HealOnline/patient/PatientProfile.dart';
import 'package:HealOnline/patient/fragments/CityPicker.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:language_pickers/language_picker_dialog.dart';
import 'package:language_pickers/language_pickers.dart';
import 'package:language_pickers/languages.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

class EditProfileScreen extends StatefulWidget {
  PatientProfileState fragment;
  EditProfileScreen(this.fragment, {Key key}) : super(key: key);

  @override
  EditProfileScreenState createState() => EditProfileScreenState();
}

class EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController fNameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController languageController = TextEditingController();
  TextEditingController pharmacyController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  static TextEditingController provinceController = TextEditingController();
  TextEditingController cardNoController = TextEditingController();
  TextEditingController insuranceProviderController = TextEditingController();
  TextEditingController policyNoController = TextEditingController();

  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController bloodGrpController = TextEditingController();


  List<String> _gender = ["Male", "Female", "Other"];
  String selectedGender ;


  List<String> _maritalStatus = ["Married", "Unmarried"];
  String selectedMaritalStatus;

  static void updateProvince(String citi) {
    provinceController.text = citi;
  }

  int userProfileId = 0;
  ProgressDialog pr;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProfileFromDB();
    getLocale();
  }





  String savedCode;
  getLocale() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String languageCode = _prefs.getString(prefSelectedLanguageCode);

    if (languageCode != null) {
      savedCode = languageCode;
      changeLanguage(context, savedCode, false);

    }


    pr = new ProgressDialog(context);
    pr.style(
        message: Languages.of(context).please_wait,
        borderRadius: 4.0,
        backgroundColor: Colors.white,
        progressWidget: Padding(
          padding: EdgeInsets.all(8.0),
          child: CircularProgressIndicator(),
        ),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progress: 0.0,
        maxProgress: 100.0,
        messageTextStyle: TextStyle(
            fontFamily: "ProductSans",
            color: Colors.black,
            fontSize: 19.0,
            fontWeight: FontWeight.w600));

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
      resizeToAvoidBottomInset: true,
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
        title: Text(Languages.of(context).edit_profile,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: "ProductSans",
                color: Constants.hexToColor(Constants.primaryDarkColor))),
      ),
      body: SingleChildScrollView(
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
                key: Key('Username'),
                controller: fNameController,
                validator: (value) =>
                    (value.isEmpty) ? Languages.of(context).enter_first_name : null,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person_outline),
                    border: OutlineInputBorder(),
                    hintText: Languages.of(context).first_name,
                    hintStyle: TextStyle(fontFamily: "ProductSans")),
              ),
            ),
            SizedBox(
              height: 16,
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18),
              child:  TextFormField(textInputAction: TextInputAction.done,
                key: Key('Username'),
                controller: lNameController,
                validator: (value) =>
                    (value.isEmpty) ? Languages.of(context).enter_last_name : null,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person_outline),
                    border: OutlineInputBorder(),
                    hintText: Languages.of(context).last_name,
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
                controller: phoneNoController,
                validator: (value) =>
                    (value.isEmpty) ? Languages.of(context).please_enter_phone_number : null,
                decoration: InputDecoration(
                    prefixIcon: Container(
                      //padding: EdgeInsets.all(12),
                      width: 8,
                      height: 8,
                      child: Icon(CupertinoIcons.phone_fill),
                    ),
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
                readOnly: true,
                onTap: () {
                  _openLanguagePickerDialog();
                },
                key: Key('Username'),
                controller: languageController,
                validator: (value) =>
                    (value.isEmpty) ? Languages.of(context).select_language : null,
                decoration: InputDecoration(
                    suffixIcon: Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Colors.grey,
                    ),
                    prefixIcon: Container(
                      padding: EdgeInsets.all(12),
                      width: 8,
                      height: 8,
                      child: SvgPicture.asset(
                        "assets/images/language.svg",
                        color: Colors.black45,
                      ),
                    ),
                    border: OutlineInputBorder(),
                    hintText: Languages.of(context).language_hint,
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
                key: Key('DOB'),
                controller: emailController,
                validator: (value) =>
                    (value.isEmpty) ? Languages.of(context).enter_email_address : null,
                decoration: InputDecoration(
                    prefixIcon: Icon(CupertinoIcons.mail),
                    border: OutlineInputBorder(),
                    hintText: Languages.of(context).email_address_hint,
                    hintStyle: TextStyle(fontFamily: "ProductSans")),
              ),
            ),
            SizedBox(
              height: 16,
            ),





            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18),
              child:  TextFormField(textInputAction: TextInputAction.done,
                key: Key('Weight'),
                keyboardType: TextInputType.number,
                controller: weightController,
                decoration: InputDecoration(
                    prefixIcon: Icon(CupertinoIcons.square_favorites),
                    border: OutlineInputBorder(),
                    hintText: Languages.of(context).weight,
                    hintStyle: TextStyle(fontFamily: "ProductSans")),
              ),
            ),
            SizedBox(
              height: 16,
            ),


            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18),
              child:  TextFormField(textInputAction: TextInputAction.done,
                key: Key('Height'),
                keyboardType: TextInputType.number,
                controller: heightController,
                decoration: InputDecoration(
                    prefixIcon: Icon(CupertinoIcons.square_favorites),
                    border: OutlineInputBorder(),
                    hintText: Languages.of(context).height,
                    hintStyle: TextStyle(fontFamily: "ProductSans")),
              ),
            ),
            SizedBox(
              height: 16,
            ),





            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18),
              child:  TextFormField(textInputAction: TextInputAction.done,
                key: Key('BloodGrp'),
                controller: bloodGrpController,
                decoration: InputDecoration(
                    prefixIcon: Icon(CupertinoIcons.drop_fill),
                    border: OutlineInputBorder(),
                    hintText: Languages.of(context).blood_grp,
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
                  )
              ),
            ),
            SizedBox(
              height: 16,
            ),


            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: Languages.of(context).marital_status,
                    labelStyle: Theme.of(context)
                        .primaryTextTheme
                        .caption
                        .copyWith(color: Colors.black),
                    border: const OutlineInputBorder(),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      hint: Text(
                        Languages.of(context).marital_status,
                        style: TextStyle(fontFamily: "ProductSans"),
                      ),
                      //isExpanded: true,
                      isDense: true,
                      // Reduces the dropdowns height by +/- 50%
                      icon: Icon(Icons.keyboard_arrow_down),
                      value: selectedMaritalStatus,
                      items: _maritalStatus.map((item) {
                        return DropdownMenuItem(
                          value: item,
                          child: Text(
                            item,
                            style: TextStyle(fontFamily: "ProductSans"),
                          ),
                        );
                      }).toList(),
                      onChanged: (selectedItem) =>
                          setState(() => selectedMaritalStatus = selectedItem),
                    ),
                  )
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
              height: 18,
            ),

            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 18),
            //   child: IntlPhoneField(
            //     decoration: InputDecoration(
            //       labelText: 'Mobile Number',
            //       border: OutlineInputBorder(
            //         borderSide: BorderSide(),
            //       ),
            //     ),
            //     initialCountryCode: 'CA',
            //     onChanged: (phone) {
            //       print(phone.completeNumber);
            //     },
            //   ),
            // ),
            //
            // SizedBox(
            //   height: 24,
            // ),

            Divider(
              color: Colors.black26,
            ),

            SizedBox(
              height: 18,
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 22),
              child: Text(Languages.of(context).pref_parmacy,
                  style: TextStyle(
                      color: Constants.hexToColor(
                        Constants.primaryDarkColor,
                      ),
                      fontSize: 18,
                      fontFamily: "ProductSans")),
            ),

            SizedBox(
              height: 16,
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18),
              child:  TextFormField(textInputAction: TextInputAction.done,
                key: Key('Username'),
                controller: pharmacyController,
                validator: (value) =>
                    (value.isEmpty) ? Languages.of(context).select_pharmacy : null,
                decoration: InputDecoration(
                    suffixIcon: Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Colors.grey,
                    ),
                    prefixIcon: Icon(CupertinoIcons.lab_flask_solid),
                    border: OutlineInputBorder(),
                    hintText: Languages.of(context).pref_parmacy,
                    hintStyle: TextStyle(fontFamily: "ProductSans")),
              ),
            ),
            SizedBox(
              height: 18,
            ),


            Divider(
              color: Colors.black26,
            ),


            SizedBox(
              height: 18,
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 22),
              child: Text(Languages.of(context).insurance,
                  style: TextStyle(
                      color: Constants.hexToColor(
                        Constants.primaryDarkColor,
                      ),
                      fontSize: 18,
                      fontFamily: "ProductSans")),
            ),

            SizedBox(
              height: 16,
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18),
              child:  TextFormField(textInputAction: TextInputAction.done,
                key: Key('Health'),
                controller: insuranceProviderController,
                validator: (value) =>
                    (value.isEmpty) ? Languages.of(context).select_province : null,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.domain),
                    border: OutlineInputBorder(),
                    hintText: Languages.of(context).insurance_provider,
                    hintStyle: TextStyle(fontFamily: "ProductSans")),
              ),
            ),
            SizedBox(
              height: 16,
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18),
              child:  TextFormField(textInputAction: TextInputAction.done,
                key: Key('Health'),
                controller: policyNoController,
                validator: (value) =>
                    (value.isEmpty) ? Languages.of(context).enter_policy_no : null,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.note),
                    border: OutlineInputBorder(),
                    hintText: Languages.of(context).policy_no,
                    hintStyle: TextStyle(fontFamily: "ProductSans")),
              ),
            ),
            SizedBox(
              height: 28,
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(6)),
          color: Constants.hexToColor(Constants.primaryDarkColor),
        ),
        child: FlatButton(
          onPressed: () {
            updateProfile();
          },
          child: Center(
            child: Text(Languages.of(context).save_string,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: "ProductSans")),
          ),
        ),
      ),
    );
  }

  bool isLoading = false;

  Future<void> updateProfile() async {
    pr.show();

    PatientModel patientModel = new PatientModel(
        first_name: fNameController.text.toString(),
        last_name: lNameController.text.toString(),
        // email: emailController.text.toString(),
        gender: selectedGender,
        dob: dobController.text.toString(),
        mobile: phoneNoController.text.toString(),
        language: languageController.text.toString(),
        pharmacy: pharmacyController.text.toString(),
        p_mob_1: phoneNoController.text.toString(),
        p_mob_2: phoneNoController.text.toString(),
        province: provinceController.text.toString(),
        insurance_provider: insuranceProviderController.text.toString(),
        policy_number: policyNoController.text.toString(),
        bloodGrp: bloodGrpController.text.toString(),
        height: heightController.text.toString(),
        weight: weightController.text.toString(),
        maritalStatus: selectedMaritalStatus
    );

    try {
      String url = Utils.baseURL +
          Utils.UPDATE_USER +
          "/" +
          Utils.user.profile_obj.umeta_obj.profile_id.toString();

      String jsonUser = jsonEncode(patientModel);
      Map<String, String> headers = {
        "Content-type": "application/json",
        HttpHeaders.authorizationHeader: "Bearer " + Utils.user.token
      };

      print(jsonUser);

      Response response = await post(Uri.parse(url), headers: headers, body: jsonUser);
      int statusCode = response.statusCode;

      if (statusCode == 200) {

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('full_name', fNameController.text.toString()+" "+lNameController.text.toString());
        await prefs.setString('user_login', emailController.text.toString());

        Utils.user.profile_obj.pmeta_obj.full_name = fNameController.text.toString()+" "+lNameController.text.toString();
        Utils.user.profile_obj.umeta_obj.user_login = emailController.text.toString();


        pr.hide();
        showAlertDialog(Languages.of(context).success, Languages.of(context).profile_updated, context);

        if (Platform.isIOS) {
          getNotificationForIos();
        }
        
      } else {
        pr.hide();
        showAlertDialog(
            Languages.of(context).error_string, Languages.of(context).something_went_wrong, context);
      }
    } catch (e) {
      pr.hide();
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
                  child: Text(Languages.of(context).ok,
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

  String gender = "";

  Future<void> getProfileFromDB() async {
    try {
      String url = Utils.baseURL + Utils.GET_USER;
      print(url);
      Map<String, String> headers = {
        "Content-type": "application/json",
        HttpHeaders.authorizationHeader: "Bearer " + Utils.user.token
      };
      Response response = await get(Uri.parse(url), headers: headers);
      String body = response.body;
      print(response.body);
      var typeList = (json.decode(response.body))["Profile"];
      if (typeList != null) {
        fNameController.text =
            typeList["first_name"] != null ? typeList["first_name"] : "";
        lNameController.text =
            typeList["last_name"] != null ? typeList["last_name"] : "";
        phoneNoController.text =
            typeList["p_mob_1"] != null ? typeList["p_mob_1"] : "";
        dobController.text = typeList["dob"] != null ? typeList["dob"] : "";
        languageController.text =
            typeList["language"] != null ? typeList["language"] : "";
        emailController.text = Utils.user.profile_obj.umeta_obj.user_email;
        provinceController.text =
            typeList["province"] != null ? typeList["province"] : "";

        insuranceProviderController.text =
            typeList["insurance_provider"] != null
                ? typeList["insurance_provider"]
                : "";
        policyNoController.text =
            typeList["policy_number"] != null ? typeList["policy_number"] : "";
        pharmacyController.text =
        typeList["pharmacy"] != null ? typeList["pharmacy"] : "";

        weightController.text =
        typeList["weight"] != null ? typeList["weight"] : "";
        heightController.text =
        typeList["height"] != null ? typeList["height"] : "";
        bloodGrpController.text =
        typeList["blood_group"] != null ? typeList["blood_group"] : "";

        setState(() {
          if(typeList["martial_status"] != null){
            selectedMaritalStatus = typeList["martial_status"] ;
          }
          if(typeList["gender"] != null){
            if(typeList["gender"] == "male" || typeList["gender"] == "Male") {
              selectedGender = "Male";
            }
            else if(typeList["gender"] == "female" || typeList["gender"] == "Female"){
              selectedGender = "Female";
            }else{
              selectedGender = "Other";
            }
          }
        });



      }
    } catch (e) {}
  }

  Language _selectedDialogLanguage =
      LanguagePickerUtils.getLanguageByIsoCode('ko');

  void _openLanguagePickerDialog() => showDialog(
        context: context,
        builder: (context) => Theme(
            data: Theme.of(context).copyWith(primaryColor: Colors.pink),
            child: LanguagePickerDialog(
                titlePadding: EdgeInsets.all(8.0),
                searchCursorColor: Constants.hexToColor(
                  Constants.primaryDarkColor,
                ),
                searchInputDecoration: InputDecoration(
                    hintText: Languages.of(context).search,
                    hintStyle: TextStyle(
                        fontFamily: "ProductSans",
                        fontSize: 14,
                        color: Colors.grey)),
                isSearchable: true,
                title: Text(Languages.of(context).select_language,
                    style: TextStyle(
                        fontFamily: "ProductSans",
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Constants.hexToColor(
                          Constants.primaryDarkColor,
                        ))),
                onValuePicked: (Language language) => setState(() {
                      _selectedDialogLanguage = language;
                      languageController.text = _selectedDialogLanguage.name;
                      print(_selectedDialogLanguage.name);
                      print(_selectedDialogLanguage.isoCode);
                    }),
                itemBuilder: _buildDialogItem)),
      );

  Widget _buildDialogItem(Language language) => Row(
        children: <Widget>[
          Text(language.name,
              style: TextStyle(
                fontFamily: "ProductSans",
                fontSize: 16,
                //fontWeight: FontWeight.bold,
                color: Colors.grey,
              )),
          SizedBox(width: 8.0),
        ],
      );

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
          if (typeList[i]["title"] == "Profile Updated") {

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
