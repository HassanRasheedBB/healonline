import 'dart:async';
import 'dart:convert';

import 'package:HealOnline/LoginScreen/login_screen.dart';
import 'package:HealOnline/Utils.dart';
import 'package:HealOnline/localization/language/languages.dart';
import 'package:HealOnline/models/LoginResponse.dart';
import 'package:HealOnline/models/RegisterDoctor.dart';
import 'package:HealOnline/models/RegisterResponse.dart';
import 'package:custom_radio_grouped_button/CustomButtons/ButtonTextStyle.dart';
import 'package:custom_radio_grouped_button/CustomButtons/CustomRadioButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import 'package:language_pickers/languages.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

import 'package:language_pickers/language_pickers.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

class SignUpPage extends StatefulWidget {
  String phoneNumber;
  SignUpPage(this.phoneNumber, {Key key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final RoundedLoadingButtonController _btnController =
  new RoundedLoadingButtonController();

  TextEditingController _firstnameController = TextEditingController();
  TextEditingController _lastnameController = TextEditingController();
  TextEditingController _dateofbirthController = TextEditingController();
  TextEditingController _lanuageController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _conPasswordController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  String selectType = "PATIENT";
  String phoneNumber = "";

  int _radioValue = 0;
  bool _isShowPwd = false;
  bool _isConfirmShowPwd = false;

  String initialCountry = 'CA';
  PhoneNumber number = PhoneNumber(isoCode: 'CA');
  bool isNumberValidated = false;
  String selectedGender  = "male";


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _phoneNumberController.text = widget.phoneNumber;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 10, 24, 30),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 50,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  Languages.of(context).signup_as,
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      fontFamily: "ProductSans"),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              CustomRadioButton(
                defaultSelected: "PATIENT",
                spacing: 2,
                elevation: 6,
                height: 40,
                width: MediaQuery
                    .of(context)
                    .size
                    .width / 2 - 37,
                customShape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(6.0)),
                enableShape: true,
                unSelectedColor: Theme
                    .of(context)
                    .canvasColor,
                buttonLables: [
                  Languages.of(context).patient_string,
                  Languages.of(context).health_provider_string,
                ],
                buttonValues: [
                  "PATIENT",
                  "HEALTH PROVIDER",
                ],
                buttonTextStyle: ButtonTextStyle(
                    selectedColor: Colors.white,
                    unSelectedColor: Colors.black,
                    textStyle:
                    TextStyle(fontSize: 16, fontFamily: "ProductSans")),
                radioButtonValue: (value) {
                  selectType = value.toString();
                  print(value);
                },
                selectedColor: Constants.hexToColor(Constants.primaryDarkColor),
              ),
              SizedBox(
                height: 16,
              ),
               TextFormField(textInputAction: TextInputAction.done,
                key: Key('FirstName'),
                controller: _firstnameController,
                validator: (value) =>
                (value
                    .toString()
                    .isEmpty) ? Languages.of(context).enter_first_name : null,
                decoration: InputDecoration(
                  // prefixIcon: Icon(Icons.person_outline),
                    border: OutlineInputBorder(),
                    hintText: Languages.of(context).first_name,
                    hintStyle: TextStyle(fontFamily: "ProductSans")),
              ),
              SizedBox(
                height: 10,
              ),
               TextFormField(textInputAction: TextInputAction.done,
                key: Key('LastName'),
                controller: _lastnameController,
                validator: (value) =>
                (value
                    .toString()
                    .isEmpty) ? Languages.of(context).enter_last_name : null,
                decoration: InputDecoration(
                  //prefixIcon: Icon(Icons.person_outline),
                    border: OutlineInputBorder(),
                    hintText: Languages.of(context).last_name,
                    hintStyle: TextStyle(fontFamily: "ProductSans")),
              ),
              SizedBox(
                height: 10,
              ),
               TextFormField(textInputAction: TextInputAction.done,
                onTap: () {
                  _selectDate(context);
                },
                readOnly: true,
                key: Key('DateOfBirth'),
                controller: _dateofbirthController,
                validator: (value) =>
                (value.isEmpty) ? Languages.of(context).enter_date_of_birth : null,
                decoration: InputDecoration(
                  //prefixIcon: Icon(Icons.person_outline),
                    suffixIcon: Icon(Icons.calendar_today),
                    border: OutlineInputBorder(),
                    hintText: Languages.of(context).dob_hint,
                    hintStyle: TextStyle(fontFamily: "ProductSans")),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 94,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                decoration: Constants.InputBoxDecoration(),
                child: Padding(
                  padding:
                  EdgeInsets.only(left: 0, top: 0, right: 16, bottom: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 12.0,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 14.0),
                        child: Text(Languages.of(context).gender,
                            style: new TextStyle(
                                fontSize: 16,
                                fontFamily: "ProductSans",
                                color: Colors.black54)),
                      ),
                      SizedBox(
                        height: 4.0,
                      ),
                      new Row(
                        //mainAxisAlignment: MainAxisAlignment.center,
                        //crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          new Radio(
                            activeColor:
                            Constants.hexToColor(Constants.primaryColor),
                            value: 0,
                            groupValue: _radioValue,
                            onChanged: _handleRadioValueChange,
                          ),
                          new Text(
                            Languages.of(context).male,
                            style: new TextStyle(
                                fontFamily: "ProductSans", color: Colors.grey),
                          ),
                          new Radio(
                            activeColor:
                            Constants.hexToColor(Constants.primaryColor),
                            value: 1,
                            groupValue: _radioValue,
                            onChanged: _handleRadioValueChange,
                          ),
                          new Text(
                            Languages.of(context).female,
                            style: new TextStyle(
                                fontFamily: "ProductSans", color: Colors.grey),
                          ),
                          new Radio(
                            activeColor:
                            Constants.hexToColor(Constants.primaryColor),
                            value: 2,
                            groupValue: _radioValue,
                            onChanged: _handleRadioValueChange,
                          ),
                          new Text(
                              Languages.of(context).other,
                            style: new TextStyle(
                                fontFamily: "ProductSans", color: Colors.grey),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
               TextFormField(textInputAction: TextInputAction.done,
                readOnly: true,
                onTap: () {
                  _openLanguagePickerDialog();
                },
                key: Key('Language'),
                controller: _lanuageController,
                validator: (value) =>
                (value.isEmpty) ? Languages.of(context).enter_language : null,
                decoration: InputDecoration(
                  //prefixIcon: Icon(Icons.person_outline),
                    suffixIcon: Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                    ),
                    border: OutlineInputBorder(),
                    hintText: Languages.of(context).language_hint,
                    hintStyle: TextStyle(fontFamily: "ProductSans")),
              ),
              SizedBox(
                height: 10,
              ),
               TextFormField(textInputAction: TextInputAction.done,
                key: Key('EmailAddress'),
                controller: _emailController,
                validator: (value) {
                  if (value.isEmpty) {
                    return Languages.of(context).enter_email_address;
                  } else if (!validateEmail(value)) {
                    return Languages.of(context).invalid_email_address;
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                  //prefixIcon: Icon(Icons.person_outline),
                  //suffixIcon: Icon(Icons.arrow_forward_ios, size: 8,),
                    border: OutlineInputBorder(),
                    hintText: Languages.of(context).email_address_hint,
                    hintStyle: TextStyle(fontFamily: "ProductSans")),
              ),
              SizedBox(
                height: 10,
              ),
//               IntlPhoneField(
//                 //controller: _phoneNumberController,
//                 decoration: InputDecoration(
//                   labelText: 'Mobile Number',
//                   border: OutlineInputBorder(
//                     borderSide: BorderSide(),
//                   ),
//                 ),
//                 initialCountryCode: 'CA',
//                 onChanged: (phone) {
// //                  _phoneNumberController..text = phone.completeNumber;
// //                  _phoneNumberController
// //                    ..selection = TextSelection.collapsed(offset: 0);
//                   phoneNumber = phone.completeNumber;
//                   print(phone.completeNumber);
//                 },
//               ),




               TextFormField(textInputAction: TextInputAction.done,
                readOnly: true,
                key: Key('Phone Number'),
                controller: _phoneNumberController,
                validator: (value) {
                  if (value.isEmpty) {
                    return Languages.of(context).please_enter_phone_number;
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                  //prefixIcon: Icon(Icons.person_outline),
                  //suffixIcon: Icon(Icons.arrow_forward_ios, size: 8,),
                    border: OutlineInputBorder(),
                    hintText: Languages.of(context).phone_number,
                    hintStyle: TextStyle(fontFamily: "ProductSans")),
              ),


              // InternationalPhoneNumberInput(
              //   onInputChanged: (PhoneNumber number) {
              //     phoneNumber = number.phoneNumber;
              //      print(number.phoneNumber);
              //   },
              //   onInputValidated: (bool value) {
              //     isNumberValidated = value;
              //     // print(value);
              //   },
              //   validator: (value) {
              //     if (value.isEmpty) {
              //       return "Please enter phone number";
              //     } else if (!isNumberValidated) {
              //       return "Please use correct number";
              //     } else {
              //       return null;
              //     }
              //   },
              //   selectorConfig: SelectorConfig(
              //     selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
              //   ),
              //   ignoreBlank: false,
              //   autoValidateMode: AutovalidateMode.disabled,
              //   selectorTextStyle: TextStyle(color: Colors.black),
              //   textFieldController: _phoneNumberController,
              //   initialValue: number,
              //   formatInput: false,
              //   keyboardType: TextInputType.numberWithOptions(
              //       signed: true, decimal: true),
              //   inputBorder: OutlineInputBorder(),
              //   onSaved: (PhoneNumber number) {
              //     //print('On Saved: $number');
              //   },
              // ),


              SizedBox(
                height: 10,
              ),
               TextFormField(textInputAction: TextInputAction.done,
                key: Key('Password'),
                controller: _passwordController,
                validator: (value) {
                  if (value.isEmpty) {
                    return Languages.of(context).please_enter_password;
                  } else if (!validateStructure(value)) {
                    return Languages.of(context).use_strong_password;
                  } else {
                    return null;
                  }
                },
                obscureText: (_isShowPwd) ? false : true,
                decoration: InputDecoration(
                  //prefixIcon: Icon(Icons.lock_outline),
                  border: OutlineInputBorder(),
                  hintText: Languages.of(context).password,
                  hintStyle: TextStyle(fontFamily: "ProductSans"),
                  suffixIcon: InkWell(
                    onTap: () {
                      setState(() {
                        _isShowPwd = !_isShowPwd;
                      });
                    },
                    child: _isShowPwd
                        ? Icon(
                      Icons.visibility,
                      color: Constants.hexToColor(
                          Constants.primaryDarkColor),
                    )
                        : Icon(Icons.visibility_off,
                        color: Constants.hexToColor(
                            Constants.primaryDarkColor)),
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                Languages.of(context).password_instructions,
                style: TextStyle(
                    fontFamily: "ProductSans",
                    color: Colors.grey,
                    fontSize: 14),
              ),
              SizedBox(
                height: 14,
              ),
               TextFormField(textInputAction: TextInputAction.done,
                key: Key('ConfirmPassword'),
                controller: _conPasswordController,
                validator: (value) {
                  if (value.isEmpty) {
                    return Languages.of(context).enter_confirm_password;
                  } else if (_conPasswordController.text !=
                      _passwordController.text) {
                    return Languages.of(context).passwords_dont_match;
                  } else {
                    return null;
                  }
                },
                obscureText: (_isConfirmShowPwd) ? false : true,
                decoration: InputDecoration(
                  //prefixIcon: Icon(Icons.lock_outline),
                  border: OutlineInputBorder(),
                  hintText: Languages.of(context).confirm_password_hint,
                  hintStyle: TextStyle(fontFamily: "ProductSans"),
                  suffixIcon: InkWell(
                    onTap: () {
                      setState(() {
                        _isConfirmShowPwd = !_isConfirmShowPwd;
                      });
                    },
                    child: _isConfirmShowPwd
                        ? Icon(
                      Icons.visibility,
                      color: Constants.hexToColor(
                          Constants.primaryDarkColor),
                    )
                        : Icon(Icons.visibility_off,
                        color: Constants.hexToColor(
                            Constants.primaryDarkColor)),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                child: RoundedLoadingButton(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width - 32,
                  animateOnTap: true,
                  color: Constants.hexToColor(Constants.primaryDarkColor),
                  elevation: 8,
                  borderRadius: 10,
                  child: Text(Languages.of(context).create_account,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: "ProductSans")),
                  controller: _btnController,
                  onPressed: () {
                    registerUser();
                  },
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                       Languages.of(context).already_have_account,
                      style: TextStyle(fontFamily: "ProductSans"),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginPage(),
                          ),
                        );
                      },
                      child: Text(
                          Languages.of(context).login_here,
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: "ProductSans",
                            color:
                            Constants.hexToColor(Constants.primaryColor)),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }


  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;

      switch (_radioValue) {
        case 0:
          selectedGender = "male";
          break;
        case 1:
          selectedGender = "female";
          break;
        case 2:
          selectedGender = "other";
          break;
      }
    });
  }

  Language _selectedDropdownLanguage =
  LanguagePickerUtils.getLanguageByIsoCode('ko');

// It's sample code of Dropdown Item.
  Widget _buildDropdownItem(Language language) {
    return Row(
      children: <Widget>[
        SizedBox(
          width: 8.0,
        ),
        Text("${language.name} (${language.isoCode})"),
      ],
    );
  }

  Language _selectedDialogLanguage =
  LanguagePickerUtils.getLanguageByIsoCode('ko');

// It's sample code of Dialog Item.
  Widget _buildDialogItem(Language language) =>
      Row(
        children: <Widget>[
          Text(language.name,
              style: TextStyle(
                fontFamily: "ProductSans",
                fontSize: 14,
                //fontWeight: FontWeight.bold,
                color: Colors.grey,
              )),
          SizedBox(width: 8.0),
          Flexible(
              child: Text("(${language.isoCode})",
                  style: TextStyle(
                    fontFamily: "ProductSans",
                    fontSize: 14,
                    //fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  )))
        ],
      );

  void _openLanguagePickerDialog() =>
      showDialog(
        context: context,
        builder: (context) =>
            Theme(
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
                    onValuePicked: (Language language) =>
                        setState(() {
                          _selectedDialogLanguage = language;
                          _lanuageController.text =
                              _selectedDialogLanguage.name;
                          print(_selectedDialogLanguage.name);
                          print(_selectedDialogLanguage.isoCode);
                        }),
                    itemBuilder: _buildDialogItem)),
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
        _dateofbirthController.text = "${selectedDate.toLocal()}".split(' ')[0];
      });
  }

  Future<void> registerUser() async {
    //getPhoneNumber(phoneNumber);

    if (_formKey.currentState.validate()) {

      int roleId = 2;
      if(selectType.toString() != "PATIENT"){
        roleId = 3;
      }

      String body = "";

      RegisterUser registerUser = new RegisterUser(
          roleId,
          _firstnameController.text,
          _lastnameController.text,
          _dateofbirthController.text,
          selectedGender,
          _lanuageController.text,
          _emailController.text,
          _phoneNumberController.text,
          _passwordController.text,
          _conPasswordController.text,
          "",
          Constants.fcm_token
      );

      try {

        String url = Utils.baseURL + Utils.USER_REGISTER;
        Map<String, String> headers = Utils.HEADERS;
        String jsonUser = jsonEncode(registerUser);
        Response response = await post(Uri.parse(url), headers: headers, body: jsonUser);
        int statusCode = response.statusCode;

        if (statusCode == 200 || statusCode == 203) {
          body = response.body;
          RegisterReponse p = RegisterReponse.fromJson(json.decode(body));

          if (p.err != null) {

            _btnController.reset();
            if(p.err.email != null){
              showAlertDialog(Languages.of(context).error_string, p.err.email.toString(), context);
            }
            else{
              showAlertDialog(Languages.of(context).server_error,
                  Languages.of(context).something_went_wrong, context);
            }

          }else{
            Utils.user = LoginResponse();
            Utils.user.token = p.auth;
            Utils.user.profile_obj = p.profile_obj;
            Utils.user.is_loggedIn = "1";


            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setString('loggedIn', "1");
            await prefs.setInt('profile_id', p.profile_obj.umeta_obj.profile_id);
            await prefs.setInt('id', p.profile_obj.umeta_obj.id);
            await prefs.setString(
                'user_login', p.profile_obj.umeta_obj.user_login.toString());
            await prefs.setString(
                'user_pass', p.profile_obj.umeta_obj.user_pass.toString());
            await prefs.setString(
                'user_email', p.profile_obj.umeta_obj.user_email.toString());
            await prefs.setString(
                'user_type', p.profile_obj.pmeta_obj.user_type.toString());
            await prefs.setString(
                'full_name', p.profile_obj.pmeta_obj.full_name.toString());
            await prefs.setString(
                'profile_img', p.profile_obj.pmeta_obj.profile_img.toString());
            await prefs.setString('token', p.auth.toString());

            _btnController.reset();
            showSuccessAlertDialog(Languages.of(context).message,
                Languages.of(context).user_registered, context);

          }
        }else{
          _btnController.reset();
          showAlertDialog(Languages.of(context).server_error,
              Languages.of(context).something_went_wrong, context);
        }


      } catch (e) {
        _btnController.reset();
        showAlertDialog(Languages.of(context).server_error,
            Languages.of(context).something_went_wrong, context);
        //print(e.message);
      }
    } else {
      _btnController.reset();
      return;
    }
  }

  bool validateStructure(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }

  bool validateEmail(String email) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!(regex.hasMatch(email)))
      return false;
    else {
      return true;
    }
  }

  void showAlertDialog(String title, String msg, BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) =>
            CupertinoAlertDialog(
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
            )
    );
  }


  void gotoLoginScreen() {
    _btnController.reset();
    Timer(Duration(seconds: 1), () {
      Navigator.of(context).pop();
     // Navigator.pushReplacement(
     //   context,
     //   MaterialPageRoute(
     //     builder: (context) => LoginPage(),
     //   ),
     // );
    });
  }

  void getPhoneNumber(String phoneNumber) async {
    PhoneNumber number =
    await PhoneNumber.getRegionInfoFromPhoneNumber(phoneNumber, 'CA');

    setState(() {
      this.number = number;
      print(number);
    });
  }

  void showSuccessAlertDialog(String title, String msg, BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) =>
            CupertinoAlertDialog(
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
                    gotoLoginScreen();
                  },
                )
              ],
            )
    );
  }


}
