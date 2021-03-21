//EditProfileScreen

import 'dart:convert';
import 'dart:io';

import 'package:HealOnline/Utils.dart';
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
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

class EditProfileScreen extends StatefulWidget {
  EditProfileScreen({Key key}) : super(key: key);

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
  String selectedGender;


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
                    prefixIcon: Icon(CupertinoIcons.calendar),
                    border: OutlineInputBorder(),
                    hintText: 'Date of Birth*',
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
                readOnly: true,
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
                key: Key('Weight'),
                keyboardType: TextInputType.number,
                controller: weightController,
                decoration: InputDecoration(
                    prefixIcon: Icon(CupertinoIcons.square_favorites),
                    border: OutlineInputBorder(),
                    hintText: 'Weight',
                    hintStyle: TextStyle(fontFamily: "ProductSans")),
              ),
            ),
            SizedBox(
              height: 16,
            ),


            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18),
              child: TextFormField(
                key: Key('Height'),
                keyboardType: TextInputType.number,
                controller: heightController,
                decoration: InputDecoration(
                    prefixIcon: Icon(CupertinoIcons.square_favorites),
                    border: OutlineInputBorder(),
                    hintText: 'Height',
                    hintStyle: TextStyle(fontFamily: "ProductSans")),
              ),
            ),
            SizedBox(
              height: 16,
            ),





            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18),
              child: TextFormField(
                key: Key('BloodGrp'),
                controller: bloodGrpController,
                decoration: InputDecoration(
                    prefixIcon: Icon(CupertinoIcons.drop_fill),
                    border: OutlineInputBorder(),
                    hintText: 'Blood Group',
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
                    labelText: 'Gender',
                    labelStyle: Theme.of(context)
                        .primaryTextTheme
                        .caption
                        .copyWith(color: Colors.black),
                    border: const OutlineInputBorder(),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      hint: Text(
                        'Select Gender',
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
                    labelText: 'Marital Status',
                    labelStyle: Theme.of(context)
                        .primaryTextTheme
                        .caption
                        .copyWith(color: Colors.black),
                    border: const OutlineInputBorder(),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      hint: Text(
                        'Select Marital Status',
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
                      child: CityPicker("Province", true),
                    ),
                  );
                },
                key: Key('Health'),
                controller: provinceController,
                validator: (value) =>
                (value.isEmpty) ? "Please Select Province" : null,
                decoration: InputDecoration(
                    suffixIcon: Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Colors.grey,
                    ),
                    prefixIcon: Icon(CupertinoIcons.location),
                    border: OutlineInputBorder(),
                    hintText: 'Province',
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
              child: Text('Preferred Pharmacy',
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
                key: Key('Username'),
                controller: pharmacyController,
                validator: (value) =>
                    (value.isEmpty) ? "Please Select Language" : null,
                decoration: InputDecoration(
                    suffixIcon: Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Colors.grey,
                    ),
                    prefixIcon: Icon(CupertinoIcons.lab_flask_solid),
                    border: OutlineInputBorder(),
                    hintText: 'Pharmacy*',
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
              child: Text('Insurance',
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
                key: Key('Health'),
                controller: insuranceProviderController,
                validator: (value) =>
                    (value.isEmpty) ? "Please Select Province" : null,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.domain),
                    border: OutlineInputBorder(),
                    hintText: 'Insurance Provider',
                    hintStyle: TextStyle(fontFamily: "ProductSans")),
              ),
            ),
            SizedBox(
              height: 16,
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18),
              child: TextFormField(
                key: Key('Health'),
                controller: policyNoController,
                validator: (value) =>
                    (value.isEmpty) ? "Please Enter Policy No" : null,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.note),
                    border: OutlineInputBorder(),
                    hintText: 'Policy No',
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

      Response response = await post(url, headers: headers, body: jsonUser);
      int statusCode = response.statusCode;

      if (statusCode == 200) {

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('full_name', fNameController.text.toString()+" "+lNameController.text.toString());
        await prefs.setString('user_login', emailController.text.toString());

        Utils.user.profile_obj.pmeta_obj.full_name = fNameController.text.toString()+" "+lNameController.text.toString();
        Utils.user.profile_obj.umeta_obj.user_login = emailController.text.toString();


        pr.hide();
        showAlertDialog("Success", "Profile is updated successfully", context);
      } else {
        pr.hide();
        showAlertDialog(
            "Error", "Something went wrong please try again", context);
      }
    } catch (e) {
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

  Future<void> getProfileFromDB() async {
    try {
      String url = Utils.baseURL + Utils.GET_USER;
      print(url);
      Map<String, String> headers = {
        "Content-type": "application/json",
        HttpHeaders.authorizationHeader: "Bearer " + Utils.user.token
      };
      Response response = await get(url, headers: headers);
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
        gender = typeList["gender"];
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
}
