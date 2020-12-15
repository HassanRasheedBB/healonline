import 'package:custom_radio_grouped_button/CustomButtons/ButtonTextStyle.dart';
import 'package:custom_radio_grouped_button/CustomButtons/CustomRadioButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healonline/LoginScreen/login_screen.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

import '../constants.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController _firstnameController = TextEditingController();
  TextEditingController _lastnameController = TextEditingController();
  TextEditingController _dateofbirthController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();


  int _radioValue = 0;
  bool _isShowPwd = false;
  bool _isConfirmShowPwd = false;

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
                spacing: 2,
                elevation: 6,
                height: 40,
                width: MediaQuery.of(context).size.width / 2 - 37,
                customShape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(6.0)),
                enableShape: true,
                unSelectedColor: Theme.of(context).canvasColor,
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
                    (value.isEmpty) ? "Please Enter First Name" : null,
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
                    (value.isEmpty) ? "Please Enter Last Name" : null,
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
                width: MediaQuery.of(context).size.width,
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
                            activeColor: Constants.hexToColor(
                                Constants.primaryDarkColor),
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
                            activeColor: Constants.hexToColor(
                                Constants.primaryDarkColor),
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
                            activeColor: Constants.hexToColor(
                                Constants.primaryDarkColor),
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


              SizedBox(height: 10,),

              TextFormField(
                key: Key('Language'),
                controller: _dateofbirthController,
                validator: (value) =>
                (value.isEmpty) ? "Please Enter Languages" : null,
                decoration: InputDecoration(
                  //prefixIcon: Icon(Icons.person_outline),
                    suffixIcon: Icon(Icons.arrow_forward_ios, size: 16,),
                    border: OutlineInputBorder(),
                    hintText: 'Languages*',
                    hintStyle: TextStyle(fontFamily: "ProductSans")),
              ),


              SizedBox(height: 10,),

              TextFormField(
                key: Key('EmailAddress'),
                controller: _dateofbirthController,
                validator: (value) =>
                (value.isEmpty) ? "Please Enter Email Address" : null,
                decoration: InputDecoration(
                  //prefixIcon: Icon(Icons.person_outline),
                    //suffixIcon: Icon(Icons.arrow_forward_ios, size: 8,),
                    border: OutlineInputBorder(),
                    hintText: 'Email Address*',
                    hintStyle: TextStyle(fontFamily: "ProductSans")),
              ),

              SizedBox(height: 10,),

              IntlPhoneField(
                decoration: InputDecoration(
                  labelText: 'Mobile Number',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(),
                  ),
                ),
                initialCountryCode: 'CA',
                onChanged: (phone) {
                  print(phone.completeNumber);
                },
              ),

              SizedBox(height: 10,),

              TextFormField(
                key: Key('Password'),
                controller: _passwordController,
                validator: (value) =>
                (value.isEmpty) ? "Please Enter Password" : null,
                obscureText: (_isShowPwd) ? false : true,
                decoration: InputDecoration(
                  //prefixIcon: Icon(Icons.lock_outline),
                  border: OutlineInputBorder(),
                  hintText: 'Password*',
                  hintStyle: TextStyle(fontFamily: "ProductSans"),
                  suffixIcon: InkWell(
                    onTap: ()
                    {
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

              SizedBox(height: 8,),
              Text(
                "(Password must contain at least 8 characters, 1 lower case (a-z) & 1 Upper case (A-Z), 1 number (0-9) or a symbol)",
                  style: TextStyle(fontFamily: "ProductSans", color: Colors.grey, fontSize: 14),
              ),


              SizedBox(height: 14,),

              TextFormField(
                key: Key('ConfirmPassword'),
                controller: _passwordController,
                validator: (value) =>
                (value.isEmpty) ? "Please Enter Confirm Password" : null,
                obscureText: (_isConfirmShowPwd) ? false : true,
                decoration: InputDecoration(
                  //prefixIcon: Icon(Icons.lock_outline),
                  border: OutlineInputBorder(),
                  hintText: 'Confirm Password*',
                  hintStyle: TextStyle(fontFamily: "ProductSans"),
                  suffixIcon: InkWell(
                    onTap: ()
                    {
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
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Constants.hexToColor(Constants.primaryDarkColor),
                ),
                child: FlatButton(
                  onPressed: () {},
                  child: Center(
                    child: Text('CREATE ACCOUNT',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: "ProductSans")),
                  ),
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
                            color: Constants.hexToColor(
                                Constants.primaryDarkColor)),
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
}
