import 'dart:async';

import 'package:HealOnline/LoginScreen/login_screen.dart';
import 'package:HealOnline/models/RegisterDoctor.dart';
import 'package:custom_radio_grouped_button/CustomButtons/ButtonTextStyle.dart';
import 'package:custom_radio_grouped_button/CustomButtons/CustomRadioButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import 'package:language_pickers/languages.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

import 'package:language_pickers/language_pickers.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../constants.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key}) : super(key: key);

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
                  'SignUp As',
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
                  'Patient',
                  'Health Provider',
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
              TextFormField(
                key: Key('FirstName'),
                controller: _firstnameController,
                validator: (value) =>
                (value
                    .toString()
                    .isEmpty) ? "Please Enter First Name" : null,
                decoration: InputDecoration(
                  // prefixIcon: Icon(Icons.person_outline),
                    border: OutlineInputBorder(),
                    hintText: 'First Name*',
                    hintStyle: TextStyle(fontFamily: "ProductSans")),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                key: Key('LastName'),
                controller: _lastnameController,
                validator: (value) =>
                (value
                    .toString()
                    .isEmpty) ? "Please Enter Last Name" : null,
                decoration: InputDecoration(
                  //prefixIcon: Icon(Icons.person_outline),
                    border: OutlineInputBorder(),
                    hintText: 'Last Name*',
                    hintStyle: TextStyle(fontFamily: "ProductSans")),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                onTap: () {
                  _selectDate(context);
                },
                readOnly: true,
                key: Key('DateOfBirth'),
                controller: _dateofbirthController,
                validator: (value) =>
                (value.isEmpty) ? "Please Enter Date of Birth" : null,
                decoration: InputDecoration(
                  //prefixIcon: Icon(Icons.person_outline),
                    suffixIcon: Icon(Icons.calendar_today),
                    border: OutlineInputBorder(),
                    hintText: 'Date of Birth (mm/dd/yyyy)*',
                    hintStyle: TextStyle(fontFamily: "ProductSans")),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 90,
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
                        child: Text("Gender*",
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
                            'Male',
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
                            'Female',
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
                            'Other',
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
              TextFormField(
                readOnly: true,
                onTap: () {
                  _openLanguagePickerDialog();
                },
                key: Key('Language'),
                controller: _lanuageController,
                validator: (value) =>
                (value.isEmpty) ? "Please Enter Language" : null,
                decoration: InputDecoration(
                  //prefixIcon: Icon(Icons.person_outline),
                    suffixIcon: Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                    ),
                    border: OutlineInputBorder(),
                    hintText: 'Language*',
                    hintStyle: TextStyle(fontFamily: "ProductSans")),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                key: Key('EmailAddress'),
                controller: _emailController,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please Enter Email Address";
                  } else if (!validateEmail(value)) {
                    return "Invalid Email Address";
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                  //prefixIcon: Icon(Icons.person_outline),
                  //suffixIcon: Icon(Icons.arrow_forward_ios, size: 8,),
                    border: OutlineInputBorder(),
                    hintText: 'Email Address*',
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


              InternationalPhoneNumberInput(
                onInputChanged: (PhoneNumber number) {
                  phoneNumber = number.phoneNumber;
                  // print(number.phoneNumber);
                },
                onInputValidated: (bool value) {
                  isNumberValidated = value;
                  // print(value);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please enter phone number";
                  } else if (!isNumberValidated) {
                    return "Please use correct number";
                  } else {
                    return null;
                  }
                },
                selectorConfig: SelectorConfig(
                  selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                ),
                ignoreBlank: false,
                autoValidateMode: AutovalidateMode.disabled,
                selectorTextStyle: TextStyle(color: Colors.black),
                textFieldController: _phoneNumberController,
                initialValue: number,
                formatInput: false,
                keyboardType: TextInputType.numberWithOptions(
                    signed: true, decimal: true),
                inputBorder: OutlineInputBorder(),
                onSaved: (PhoneNumber number) {
                  //print('On Saved: $number');
                },
              ),


              SizedBox(
                height: 10,
              ),
              TextFormField(
                key: Key('Password'),
                controller: _passwordController,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please Enter Password";
                  } else if (!validateStructure(value)) {
                    return "Please use strong password.";
                  } else {
                    return null;
                  }
                },
                obscureText: (_isShowPwd) ? false : true,
                decoration: InputDecoration(
                  //prefixIcon: Icon(Icons.lock_outline),
                  border: OutlineInputBorder(),
                  hintText: 'Password*',
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
                "(Password must contain at least 8 characters, 1 lower case (a-z) & 1 Upper case (A-Z), 1 number (0-9) or a symbol)",
                style: TextStyle(
                    fontFamily: "ProductSans",
                    color: Colors.grey,
                    fontSize: 14),
              ),
              SizedBox(
                height: 14,
              ),
              TextFormField(
                key: Key('ConfirmPassword'),
                controller: _conPasswordController,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please Enter Confirm Password";
                  } else if (_conPasswordController.text !=
                      _passwordController.text) {
                    return "Passwords don't match";
                  } else {
                    return null;
                  }
                },
                obscureText: (_isConfirmShowPwd) ? false : true,
                decoration: InputDecoration(
                  //prefixIcon: Icon(Icons.lock_outline),
                  border: OutlineInputBorder(),
                  hintText: 'Confirm Password*',
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
                  child: Text('CREATE ACCOUNT',
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
                      "Already have an account? ",
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
                        "Login Here",
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
          break;
        case 1:
          break;
        case 2:
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
    getPhoneNumber(phoneNumber);

    if (_formKey.currentState.validate()) {
      RegisterUser registerUser = new RegisterUser(
          selectType.toLowerCase().toString(),
          _firstnameController.text,
          _lastnameController.text,
          _dateofbirthController.text,
          _radioValue.toString(),
          _lanuageController.text,
          _emailController.text,
          number.phoneNumber,
          _passwordController.text,
          _conPasswordController.text,
          "",
          "",
          "",
          "",
          "",
          "",
          "",
          "",
          "",
          "",
          "",
          "",
          "",
          "",
          "",
          "",
          "",
          "",
          "",
          ""
      );

      try {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
            email: registerUser.email, password: registerUser.password)
            .then((value) {
          onUserCreated(registerUser);
        });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          showAlertDialog(
              "Server Error", 'The password provided is too weak.', context);
          _btnController.reset();
        }
        else if (e.code == 'email-already-in-use') {
          // showAlertDialog("Server Error",
          //     'The account already exists for that email.', context);
          onUserCreated(registerUser);
          //_btnController.reset();
        } else {
          print(e.message);
          showAlertDialog("Server Error", 'Something went wrong.', context);
          _btnController.reset();
        }
      } catch (e) {
        _btnController.reset();
        showAlertDialog("Server Error",
            'Some information went wrong. Please try again', context);
        print(e.message);
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
                  child: Text("OK",
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

  onUserCreated(RegisterUser registerUser) {
    print(registerUser.contact_number);
    final mainReference = FirebaseDatabase.instance.reference();
    mainReference
        .child("users")
        .child(registerUser.userType)
        .child(number.phoneNumber)
        .set(registerUser.toJson())
        .then((value) {
      showSuccessAlertDialog("Success", 'Registered Successfully!', context);
      _btnController.success();
    }, onError: (error) {
      print(error );
    }).catchError((error) {
      print(error.toString());
      _btnController.reset();
      showAlertDialog("Server Error",
          'Some information went wrong. Please try again', context);
    });
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
                  child: Text("OK",
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
