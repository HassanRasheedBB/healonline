import 'package:HealOnline/localization/language/languages.dart';
import 'package:HealOnline/phone_authentication/code_cerification_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:intl_phone_number_input/src/models/country_list.dart';

import '../constants.dart';

class PhoneNumberScreen extends StatefulWidget {
  PhoneNumberScreen({Key key}) : super(key: key);

  @override
  _PhoneNumberScreenState createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
  @override
  void initState() {
    super.initState();
  }

  TextEditingController _phoneNumberController = TextEditingController();
  String phoneNumber = "";
  bool isNumberValidated = false;
  PhoneNumber number = PhoneNumber(isoCode: 'CA');

  String selectedCountry = "Canada";
  String selectedIso = "+1";

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 2,
                color: Constants.hexToColor(Constants.primaryDarkColor),
                child: Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 48, left: 18),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Image(
                        image: AssetImage("assets/images/phone_number.png"),
                        height: 100,
                        width: 100,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, right: 8),
                child: Text(
                  selectedCountry + " (" + selectedIso + ")",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                      fontSize: 20),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Divider(),
              SizedBox(
                height: 24,
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, right: 16),
                child: InternationalPhoneNumberInput(

                  hintText: Languages.of(context).phone_number,
                  errorMessage: Languages.of(context).invalid_phone_number,
                  onInputChanged: (PhoneNumber number) {
                    phoneNumber = number.phoneNumber;
                    setState(() {
                      selectedIso = number.dialCode;
                      getCountry();
                    });
                  },
                  onInputValidated: (bool value) {
                    isNumberValidated = value;
                    // print(value);
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return Languages.of(context).please_enter_phone_number;
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
              ),
              SizedBox(
                height: 24,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  Languages.of(context).otp_message,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
              SizedBox(
                height: 24,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 60,
        margin: EdgeInsets.all(16),
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        child: FloatingActionButton(
            backgroundColor: Constants.hexToColor(Constants.primaryDarkColor),
            onPressed: () {
              getVerificationCode();
            },
            child: Center(
              child: Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
              ),
            )),
      ),
    );
  }

  Future<void> getVerificationCode() async {
    if (_formKey.currentState.validate()) {
      print(phoneNumber);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => CodeVerification(phoneNumber),
        ),
      );

      // FirebaseAuth auth = FirebaseAuth.instance;
      // await auth.verifyPhoneNumber(
      //   phoneNumber: phoneNumber,
      //   verificationCompleted: (PhoneAuthCredential credential) async {
      //     print("verificationCompleted: "+credential.smsCode );
      //   },
      //   codeSent: (String verificationId, int forceResendingToken) async {
      //     String smsCode = '123456';
      //     PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);
      //     await auth.signInWithCredential(credential);
      //   },
      //   codeAutoRetrievalTimeout: (String verificationId) {  },
      //   verificationFailed: (FirebaseAuthException error) {
      //     print("Error: "+error.message);
      //   },
      // );

    }
  }

  void getCountry() {
    String country = "";

    for (int i = 0; i < Countries.countryList.length; i++) {
      Countries.countryList[i].forEach((key, value) {

        if (key == "en_short_name") {
          country = value;
        }

        if (key == "dial_code" && value == selectedIso) {
          print(key+"-"+selectedIso+"-"+country);

          setState(() {
            selectedCountry = country;
          });
        }

      });
    }
  }
}
