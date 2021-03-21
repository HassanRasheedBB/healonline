//DoctorProfileSettingScreen

import 'dart:convert';
import 'dart:io';

import 'package:HealOnline/Utils.dart';
import 'package:HealOnline/models/DoctorModel.dart';
import 'package:HealOnline/models/PatientModel.dart';
import 'package:HealOnline/patient/fragments/CityPicker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart';
import 'package:language_pickers/language_picker_dialog.dart';
import 'package:language_pickers/language_pickers.dart';
import 'package:language_pickers/languages.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:progress_dialog/progress_dialog.dart';

import '../constants.dart';

class DoctorProfileSettingScreen extends StatefulWidget {
  DoctorProfileSettingScreen({Key key}) : super(key: key);

  @override
  _DoctorProfileSettingScreen createState() => _DoctorProfileSettingScreen();
}

class _DoctorProfileSettingScreen extends State<DoctorProfileSettingScreen> {
  TextEditingController fNameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController languageController = TextEditingController();
  TextEditingController degreeController = TextEditingController();
  TextEditingController degreeDateController = TextEditingController(); //
  TextEditingController degreeUniversityController = TextEditingController();
  TextEditingController degreeLocationController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController totalExpController = TextEditingController();
  static TextEditingController provinceController = TextEditingController();
  TextEditingController cardNoController = TextEditingController();
  TextEditingController insuranceProviderController = TextEditingController();
  TextEditingController policyNoController = TextEditingController();
  TextEditingController healthCardNoController = TextEditingController();
  TextEditingController specialityController = TextEditingController();
  TextEditingController speciality1Controller = TextEditingController();
  TextEditingController speciality2Controller = TextEditingController();
  TextEditingController speciality3Controller = TextEditingController();
  TextEditingController speciality4Controller = TextEditingController();
  TextEditingController cpsoController = TextEditingController();
  TextEditingController mincController = TextEditingController();

  String _selectedUni = '';
  List<String> _universities = ['A', 'B', 'C', 'D'];

  String _selectedTotExp = '';

  int selectedSpecialityIndex = 1;

  List<String> _specialitiesList = ['A', 'B', 'C', 'D', ''];

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
    pr = new ProgressDialog(context);
    pr.style(
        message: 'Please Wait...',
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
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomPadding: true,
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
        title: Text("Edit Profile Info",
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
              child: TextFormField(
                key: Key('Username'),
                controller: fNameController,
                validator: (value) =>
                    (value.isEmpty) ? "Please Enter First Name" : null,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person_outline),
                    border: OutlineInputBorder(),
                    hintText: 'First Name*',
                    hintStyle: TextStyle(fontFamily: "ProductSans")),
              ),
            ),
            SizedBox(
              height: 16,
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18),
              child: TextFormField(
                key: Key('Username'),
                controller: lNameController,
                validator: (value) =>
                    (value.isEmpty) ? "Please Enter Last Name" : null,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person_outline),
                    border: OutlineInputBorder(),
                    hintText: 'Last Name*',
                    hintStyle: TextStyle(fontFamily: "ProductSans")),
              ),
            ),
            SizedBox(
              height: 16,
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18),
              child: TextFormField(
                key: Key('Phone Number'),
                controller: phoneNoController,
                validator: (value) =>
                    (value.isEmpty) ? "Enter Phone Number" : null,
                decoration: InputDecoration(
                    prefixIcon: Container(
                      //padding: EdgeInsets.all(12),
                      width: 8,
                      height: 8,
                      child: Icon(CupertinoIcons.phone_fill),
                    ),
                    border: OutlineInputBorder(),
                    hintText: 'Phone Number*',
                    hintStyle: TextStyle(fontFamily: "ProductSans")),
              ),
            ),
            SizedBox(
              height: 16,
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18),
              child: TextFormField(
                onTap: () {
                  _selectDate(context);
                },
                readOnly: true,
                key: Key('DOB'),
                controller: dobController,
                validator: (value) =>
                    (value.isEmpty) ? "Please Enter Date of Birth" : null,
                decoration: InputDecoration(
                    suffixIcon: Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Colors.grey,
                    ),
                    prefixIcon: Icon(CupertinoIcons.calendar),
                    border: OutlineInputBorder(),
                    hintText: 'Date of Birth',
                    hintStyle: TextStyle(fontFamily: "ProductSans")),
              ),
            ),
            SizedBox(
              height: 16,
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18),
              child: TextFormField(
                readOnly: true,
                onTap: () {
                  _openLanguagePickerDialog();
                },
                key: Key('Username'),
                controller: languageController,
                validator: (value) =>
                    (value.isEmpty) ? "Please Select Language" : null,
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
                    hintText: 'Language',
                    hintStyle: TextStyle(fontFamily: "ProductSans")),
              ),
            ),
            SizedBox(
              height: 16,
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18),
              child: TextFormField(
                key: Key('DOB'),
                controller: emailController,
                validator: (value) =>
                    (value.isEmpty) ? "Please Enter Email" : null,
                decoration: InputDecoration(
                    prefixIcon: Icon(CupertinoIcons.mail),
                    border: OutlineInputBorder(),
                    hintText: 'Email',
                    hintStyle: TextStyle(fontFamily: "ProductSans")),
              ),
            ),
            SizedBox(
              height: 16,
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18),
              child: TextFormField(
                key: Key('CPSO'),
                controller: cpsoController,
                validator: (value) =>
                    (value.isEmpty) ? "Please CPSO Number" : null,
                decoration: InputDecoration(
                    prefixIcon: Icon(CupertinoIcons.number_square),
                    border: OutlineInputBorder(),
                    hintText: 'CPSO Number',
                    hintStyle: TextStyle(fontFamily: "ProductSans")),
              ),
            ),
            SizedBox(
              height: 16,
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18),
              child: TextFormField(
                key: Key('MINC'),
                controller: mincController,
                validator: (value) =>
                    (value.isEmpty) ? "Please MINC Number" : null,
                decoration: InputDecoration(
                    prefixIcon: Icon(CupertinoIcons.number_square),
                    border: OutlineInputBorder(),
                    hintText: 'MINC Number',
                    hintStyle: TextStyle(fontFamily: "ProductSans")),
              ),
            ),
            SizedBox(
              height: 16,
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
              child: Text('Recent Education',
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
              child: TextFormField(
                key: Key('Degree'),
                controller: degreeController,
                validator: (value) =>
                    (value.isEmpty) ? "Please Select Degree" : null,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.badge),
                    border: OutlineInputBorder(),
                    hintText: 'Degree',
                    hintStyle: TextStyle(fontFamily: "ProductSans")),
              ),
            ),
            SizedBox(
              height: 16,
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18),
              child: TextFormField(
                key: Key('Degree Date'),
                controller: degreeDateController,
                validator: (value) =>
                    (value.isEmpty) ? "Please Select Date" : null,
                onTap: () {
                  _selectDegreeDate(context);
                },
                readOnly: true,
                decoration: InputDecoration(
                    suffixIcon: Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Colors.grey,
                    ),
                    prefixIcon: Icon(CupertinoIcons.calendar),
                    border: OutlineInputBorder(),
                    hintText: 'Date',
                    hintStyle: TextStyle(fontFamily: "ProductSans")),
              ),
            ),
            SizedBox(
              height: 16,
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18),
              child: TextFormField(
                key: Key('Degree Date'),
                controller: degreeUniversityController,
                validator: (value) =>
                    (value.isEmpty) ? "Please Select Institution" : null,
                onTap: () => showUniModal(context),
                readOnly: true,
                decoration: InputDecoration(
                    suffixIcon: Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Colors.grey,
                    ),
                    prefixIcon: Icon(Icons.apartment_rounded),
                    border: OutlineInputBorder(),
                    hintText: 'Institution',
                    hintStyle: TextStyle(fontFamily: "ProductSans")),
              ),
            ),
            SizedBox(
              height: 16,
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18),
              child: TextFormField(
                key: Key('Degree Location'),
                controller: degreeLocationController,
                validator: (value) =>
                    (value.isEmpty) ? "Please Select Location" : null,
                decoration: InputDecoration(
                    prefixIcon: Icon(CupertinoIcons.location_solid),
                    border: OutlineInputBorder(),
                    hintText: 'Address',
                    hintStyle: TextStyle(fontFamily: "ProductSans")),
              ),
            ),
            SizedBox(
              height: 16,
            ),

            Divider(
              color: Colors.black26,
            ),

            SizedBox(
              height: 18,
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 22),
              child: Text('Professional Experience',
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
              child: TextFormField(
                readOnly: true,
                onTap: () => showTotExpModal(context),
                key: Key('Years'),
                controller: totalExpController,
                validator: (value) => (value.isEmpty)
                    ? "Please Select Overall Experience Years"
                    : null,
                decoration: InputDecoration(
                    suffixIcon: Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Colors.grey,
                    ),
                    prefixIcon: Icon(Icons.app_registration),
                    border: OutlineInputBorder(),
                    hintText: 'Total Experience',
                    hintStyle: TextStyle(fontFamily: "ProductSans")),
              ),
            ),
            SizedBox(
              height: 16,
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18),
              child: TextFormField(
                key: Key('Speciality'),
                controller: specialityController,
                validator: (value) =>
                    (value.isEmpty) ? "Please Select Speciality" : null,
                readOnly: true,
                onTap: () {
                  selectedSpecialityIndex = 1;
                  showSpecialityModal(context);
                },
                decoration: InputDecoration(
                    suffixIcon: Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Colors.grey,
                    ),
                    prefixIcon: Icon(CupertinoIcons.asterisk_circle),
                    border: OutlineInputBorder(),
                    hintText: 'Select Primary Speciality ',
                    hintStyle: TextStyle(fontFamily: "ProductSans")),
              ),
            ),
            SizedBox(
              height: 16,
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18),
              child: TextFormField(
                key: Key('Speciality'),
                controller: speciality1Controller,
                validator: (value) =>
                    (value.isEmpty) ? "Please Select Speciality" : null,
                readOnly: true,
                onTap: () {
                  selectedSpecialityIndex = 2;
                  showSpecialityModal(context);
                },
                decoration: InputDecoration(
                    suffixIcon: Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Colors.grey,
                    ),
                    prefixIcon: Icon(CupertinoIcons.asterisk_circle),
                    border: OutlineInputBorder(),
                    hintText: 'Select Speciality ',
                    hintStyle: TextStyle(fontFamily: "ProductSans")),
              ),
            ),
            SizedBox(
              height: 16,
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18),
              child: TextFormField(
                key: Key('Speciality'),
                controller: speciality2Controller,
                validator: (value) =>
                    (value.isEmpty) ? "Please Select Speciality" : null,
                readOnly: true,
                onTap: () {
                  selectedSpecialityIndex = 3;
                  showSpecialityModal(context);
                },
                decoration: InputDecoration(
                    suffixIcon: Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Colors.grey,
                    ),
                    prefixIcon: Icon(CupertinoIcons.asterisk_circle),
                    border: OutlineInputBorder(),
                    hintText: 'Select Speciality ',
                    hintStyle: TextStyle(fontFamily: "ProductSans")),
              ),
            ),
            SizedBox(
              height: 16,
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18),
              child: TextFormField(
                key: Key('Speciality'),
                controller: speciality3Controller,
                validator: (value) =>
                    (value.isEmpty) ? "Please Select Speciality" : null,
                readOnly: true,
                onTap: () {
                  selectedSpecialityIndex = 4;
                  showSpecialityModal(context);
                },
                decoration: InputDecoration(
                    suffixIcon: Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Colors.grey,
                    ),
                    prefixIcon: Icon(CupertinoIcons.asterisk_circle),
                    border: OutlineInputBorder(),
                    hintText: 'Select Speciality ',
                    hintStyle: TextStyle(fontFamily: "ProductSans")),
              ),
            ),
            SizedBox(
              height: 16,
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18),
              child: TextFormField(
                key: Key('Speciality'),
                controller: speciality4Controller,
                validator: (value) =>
                    (value.isEmpty) ? "Please Select Speciality" : null,
                readOnly: true,
                onTap: () {
                  selectedSpecialityIndex = 5;
                  showSpecialityModal(context);
                },
                decoration: InputDecoration(
                    suffixIcon: Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Colors.grey,
                    ),
                    prefixIcon: Icon(CupertinoIcons.asterisk_circle),
                    border: OutlineInputBorder(),
                    hintText: 'Select Speciality ',
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
            child: Text('SAVE',
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
    var specialities = "";
    pr.show();

    if (specialityController.text.toString() != "") {
      specialities = specialityController.text.toString();
    }

    if (specialities == "" &&
        (speciality1Controller.text.toString() != "" ||
            speciality2Controller.text.toString() != "" ||
            speciality3Controller.text.toString() != "" ||
            speciality4Controller.text.toString() != "")) {
      pr.hide();
      showAlertDialog("Missing Information",
          "Please select your primary speciality first.", context);
      return;
    } else {
      if (speciality1Controller.text.toString() != "") {
        specialities += "," + speciality1Controller.text.toString();
      }
      if (speciality2Controller.text.toString() != "") {
        specialities += "," + speciality2Controller.text.toString();
      }
      if (speciality3Controller.text.toString() != "") {
        specialities += "," + speciality3Controller.text.toString();
      }
      if (speciality4Controller.text.toString() != "") {
        specialities += "," + speciality4Controller.text.toString();
      }
    }

    DoctorModel doctorModel = new DoctorModel(
      first_name: fNameController.text.toString(),
      last_name: lNameController.text.toString(),
      // email: emailController.text.toString(),
      gender: gender,
      dob: dobController.text.toString(),
      mobile: phoneNoController.text.toString(),
      language: languageController.text.toString(),
      cpso: cpsoController.text.toString(),
      minc: mincController.text.toString(),
    );

    Education education = new Education(
        degree: degreeController.text.toString(),
        date: degreeDateController.text.toString(),
        university: degreeUniversityController.text.toString(),
        location: degreeLocationController.text.toString());

    if (degreeId != null) {
      education.id = degreeId;
    }

    List<Education> degreeList = [];
    degreeList.add(education);
    doctorModel.education = degreeList;

    Experience experience = new Experience(
        year: totalExpController.text.toString(), skills: specialities);
    if (experienceId != null) {
      experience.id = experienceId;
    }

    List<Experience> expList = [];
    expList.add(experience);
    doctorModel.experience = expList;

    try {
    String url = Utils.baseURL +
        Utils.UPDATE_USER +
        "/" +
        Utils.user.profile_obj.umeta_obj.profile_id.toString();

    String jsonUser = jsonEncode(doctorModel);
    Map<String, String> headers = {
      "Content-type": "application/json",
      HttpHeaders.authorizationHeader: "Bearer " + Utils.user.token
    };
    Response response = await post(url, headers: headers, body: jsonUser);
    int statusCode = response.statusCode;

    if (statusCode == 200) {
      pr.hide();
      showAlertDialog("Success", "Profile is updated successfully", context);
    } else {
      pr.hide();
      showAlertDialog(
          "Error", "Something went wrong please try again", context);
    }
    } catch (e) {
      print(e.toString());
      pr.hide();
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
                  },
                )
              ],
            ));
  }

  String gender = "";
  int degreeId, experienceId;

  Future<void> getProfileFromDB() async {
    try {
      String url = Utils.baseURL +
          Utils.GET_DOCTOR +
          Utils.user.profile_obj.umeta_obj.profile_id.toString();
      print(url);
      Map<String, String> headers = {
        "Content-type": "application/json",
        HttpHeaders.authorizationHeader: "Bearer " + Utils.user.token
      };
      Response response = await get(url, headers: headers);
      String body = response.body;
      print(response.body);
      var typeList = (json.decode(response.body))["doctor"];
      if (typeList != null) {
        fNameController.text =
            typeList[0]["first_name"] != null ? typeList[0]["first_name"] : "";
        lNameController.text =
            typeList[0]["last_name"] != null ? typeList[0]["last_name"] : "";
        phoneNoController.text =
            typeList[0]["p_mob_1"] != null ? typeList[0]["p_mob_1"] : "";
        dobController.text =
            typeList[0]["dob"] != null ? typeList[0]["dob"] : "";
        languageController.text =
            typeList[0]["language"] != null ? typeList[0]["language"] : "";
        emailController.text = Utils.user.profile_obj.umeta_obj.user_email;
        provinceController.text =
            typeList[0]["province"] != null ? typeList[0]["province"] : "";
        healthCardNoController.text = typeList[0]["health_card_number"] != null
            ? typeList[0]["health_card_number"]
            : "";
        insuranceProviderController.text =
            typeList[0]["insurance_provider"] != null
                ? typeList[0]["insurance_provider"]
                : "";
        policyNoController.text = typeList[0]["policy_number"] != null
            ? typeList[0]["policy_number"]
            : "";

        gender = typeList[0]["gender"];

        cpsoController.text =
            typeList[0]["cpso"] != null ? typeList[0]["cpso"] : "";

        mincController.text =
            typeList[0]["minc"] != null ? typeList[0]["minc"] : "";

        if (typeList[0]["education"] != null) {
          degreeId = typeList[0]["education"][0]["id"];
          degreeController.text = typeList[0]["education"][0]["degree"] != null
              ? typeList[0]["education"][0]["degree"]
              : "";
          degreeDateController.text = typeList[0]["education"][0]["date"] != null
              ? typeList[0]["education"][0]["date"]
              : "";
          degreeUniversityController.text = typeList[0]["education"][0]["university"] != null
              ? typeList[0]["education"][0]["university"]
              : "";
          degreeLocationController.text = typeList[0]["education"][0]["location"] != null
              ? typeList[0]["education"][0]["location"]
              : "";
        }

        if (typeList[0]["experience"] != null) {
          experienceId = typeList[0]["experience"][0]["id"];

          totalExpController.text = typeList[0]["experience"][0]["years"] != null
              ? typeList[0]["experience"][0]["years"]
              : "";

          String skills = typeList[0]["experience"][0]["skills"] != null
              ? typeList[0]["experience"][0]["skills"]
              : "";

          if(skills != ""){

            var arr = skills.split(",");
            if(arr.length > 0){
              specialityController.text = arr[0];
            }
            if(arr.length > 1){
              speciality1Controller.text = arr[1];
            }
            if(arr.length > 2){
              speciality2Controller.text = arr[2];
            }
            if(arr.length > 3){
              speciality3Controller.text = arr[3];
            }
            if(arr.length > 4){
              speciality4Controller.text = arr[4];
            }
          }

        }
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
                    hintText: 'Search...',
                    hintStyle: TextStyle(
                        fontFamily: "ProductSans",
                        fontSize: 14,
                        color: Colors.grey)),
                isSearchable: true,
                title: Text("Select Language",
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

  _selectDegreeDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(1900),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        degreeDateController.text = "${selectedDate.toLocal()}".split(' ')[0];
      });
  }

  showUniModal(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        enableDrag: true,
        elevation: 8,
        context: context,
        builder: (BuildContext bc) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.50,
            child: Stack(
              children: <Widget>[
                Container(
                  height: 30.0,
                  width: double.infinity,
                  color: Colors.black54,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Constants.hexToColor(Constants.whiteColor),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      )),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                          child: Text(
                            "Select Institution",
                            style: TextStyle(
                              fontFamily: "ProductSans",
                              fontSize: 24,
                              fontWeight: FontWeight.w800,
                              color: Constants.hexToColor(
                                  Constants.primaryDarkColor),
                            ),
                          ),
                          padding: EdgeInsets.only(top: 24, left: 16)),
                      SizedBox(
                        height: 16,
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        height: 280,
                        alignment: Alignment.center,
                        child: ListView.separated(
                            itemCount: _universities.length,
                            separatorBuilder: (context, int) {
                              return Divider();
                            },
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                  child: ListTile(
                                    title: Text(
                                      _universities[index],
                                      style: TextStyle(
                                        fontFamily: "ProductSans",
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    leading:
                                        Icon(CupertinoIcons.number_circle_fill),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      _selectedUni = _universities[index];
                                      degreeUniversityController.text =
                                          _selectedUni;
                                    });
                                    Navigator.of(context).pop();
                                  });
                            }),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  showTotExpModal(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        enableDrag: true,
        elevation: 8,
        context: context,
        builder: (BuildContext bc) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.50,
            child: Stack(
              children: <Widget>[
                Container(
                  height: 30.0,
                  width: double.infinity,
                  color: Colors.black54,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Constants.hexToColor(Constants.whiteColor),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      )),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                          child: Text(
                            "Select Total Experience",
                            style: TextStyle(
                              fontFamily: "ProductSans",
                              fontSize: 24,
                              fontWeight: FontWeight.w800,
                              color: Constants.hexToColor(
                                  Constants.primaryDarkColor),
                            ),
                          ),
                          padding: EdgeInsets.only(top: 24, left: 16)),
                      SizedBox(
                        height: 16,
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        height: 280,
                        alignment: Alignment.center,
                        child: ListView.separated(
                            itemCount: 50,
                            separatorBuilder: (context, int) {
                              return Divider();
                            },
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                  child: ListTile(
                                    title: Text(
                                      index == 0
                                          ? (index + 1).toString() + " year"
                                          : (index + 1).toString() + " years",
                                      style: TextStyle(
                                        fontFamily: "ProductSans",
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    leading:
                                        Icon(CupertinoIcons.number_circle_fill),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      _selectedTotExp = index == 0
                                          ? (index + 1).toString() + " year"
                                          : (index + 1).toString() + " years";
                                      totalExpController.text = _selectedTotExp;
                                    });
                                    Navigator.of(context).pop();
                                  });
                            }),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  showSpecialityModal(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        enableDrag: true,
        elevation: 8,
        context: context,
        builder: (BuildContext bc) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.50,
            child: Stack(
              children: <Widget>[
                Container(
                  height: 30.0,
                  width: double.infinity,
                  color: Colors.black54,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Constants.hexToColor(Constants.whiteColor),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      )),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                          child: Text(
                            "Select Speciality",
                            style: TextStyle(
                              fontFamily: "ProductSans",
                              fontSize: 24,
                              fontWeight: FontWeight.w800,
                              color: Constants.hexToColor(
                                  Constants.primaryDarkColor),
                            ),
                          ),
                          padding: EdgeInsets.only(top: 24, left: 16)),
                      SizedBox(
                        height: 16,
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        height: 280,
                        alignment: Alignment.center,
                        child: ListView.separated(
                            itemCount: _specialitiesList.length,
                            separatorBuilder: (context, int) {
                              return Divider();
                            },
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                  child: ListTile(
                                    title: Text(
                                      _specialitiesList[index],
                                      style: TextStyle(
                                        fontFamily: "ProductSans",
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    leading:
                                        Icon(CupertinoIcons.number_circle_fill),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      if (selectedSpecialityIndex == 1) {
                                        specialityController.text =
                                            _specialitiesList[index];
                                      } else if (selectedSpecialityIndex == 2) {
                                        speciality1Controller.text =
                                            _specialitiesList[index];
                                      } else if (selectedSpecialityIndex == 3) {
                                        speciality2Controller.text =
                                            _specialitiesList[index];
                                      } else if (selectedSpecialityIndex == 4) {
                                        speciality3Controller.text =
                                            _specialitiesList[index];
                                      } else if (selectedSpecialityIndex == 5) {
                                        speciality4Controller.text =
                                            _specialitiesList[index];
                                      }
                                    });
                                    Navigator.of(context).pop();
                                  });
                            }),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}

/*




Container(
            height: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    child: Text(
                      "Select Institution",
                      style: TextStyle(
                        fontFamily: "ProductSans",
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: Constants.hexToColor(
                            Constants.primaryDarkColor),
                      ),
                    ),
                    padding: EdgeInsets.only(top: 8, left: 12)
                ),

                SizedBox(height: 16,),
                Container(
                  padding: EdgeInsets.all(8),
                  height: 240,
                  alignment: Alignment.center,
                  child: ListView.separated(
                      itemCount: _universities.length,
                      separatorBuilder: (context, int) {
                        return Divider();
                      },
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            child: ListTile(
                              title: Text(
                                _universities[index],
                                style: TextStyle(
                                  fontFamily: "ProductSans",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              leading: Icon(CupertinoIcons.number_circle_fill),
                            ),
                            onTap: () {
                              setState(() {
                                _selectedUni = _universities[index];
                              });
                              Navigator.of(context).pop();
                            }
                        );
                      }
                  ),
                )
              ],
            ),
          );


* */
