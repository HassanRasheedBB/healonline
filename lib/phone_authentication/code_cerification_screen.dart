import 'dart:async';
import 'dart:convert';

import 'package:HealOnline/SignUpScreen/SignupScreen.dart';
import 'package:HealOnline/constants.dart';
import 'package:HealOnline/localization/language/languages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:progress_dialog/progress_dialog.dart';

class CodeVerification extends StatefulWidget {
  String number;
  int profile_id;

  CodeVerification(this.number, {Key key}) : super(key: key);

  @override
  _CodeVerificationState createState() => _CodeVerificationState(number);
}

class _CodeVerificationState extends State<CodeVerification> {
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  String verifyId;
  String number;
  int profile_id;

  //ProgressDialog pr;

  _CodeVerificationState(this.number);

  @override
  void initState() {
    super.initState();
    startTimer();
    verifyNumber();
  }

  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
        color: Colors.white30,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          width: 1,
          color: Colors.white,
        ));
  }

  Timer _timer;
  int _start = 60;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
            if (_start == 0) {
              getResendOption();
            }
          });
        }
      },
    );
  }

  Card resendBtn = Card();

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final text_title = Container(
        margin: EdgeInsets.only(left: 32.0, right: 32.0, top: 16),
        child: Text(
          Languages.of(context).verfication_code,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
        ));

    final text_sub_title = Container(
      margin: EdgeInsets.only(left: 32.0, right: 32.0),
      child: Text(
        Languages.of(context).type_verification_sent+" \nto " + number,
        style: TextStyle(fontSize: 16, color: Colors.white),
        textAlign: TextAlign.center,
      ),
    );

//
    final image_back = InkWell(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Container(
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.only(top: 48, left: 16),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Constants.hexToColor(Constants.primaryDarkColor),
      body: Builder(
        builder: (context) {
          return Container(
            color: Constants.hexToColor(Constants.primaryDarkColor),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  image_back,
                  text_title,
                  SizedBox(height: 28.0),
                  text_sub_title,
                  Container(
                    color: Colors.white,
                    margin: EdgeInsets.only(
                        bottom: 16.0, left: 36.0, right: 36.0, top: 36.0),
                    child: PinPut(
                      fieldsCount: 6,
                      onSubmit: (String pin) => verifyCode(pin, context),
                      focusNode: _pinPutFocusNode,
                      controller: _pinPutController,
                      keyboardType: TextInputType.text,
                      textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                      submittedFieldDecoration: _pinPutDecoration.copyWith(
                          color: Colors.white30,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            width: 1,
                            color: Colors.white,
                          )),
                      selectedFieldDecoration: _pinPutDecoration,
                      followingFieldDecoration: _pinPutDecoration.copyWith(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white30,
                        border: Border.all(
                          width: 1,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.access_time,
                        color: Colors.white70,
                        size: 20,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        "$_start" + " s",
                        style: TextStyle(
                            color: Colors.white70,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  SizedBox(height: 28.0),
                  resendBtn,
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void getResendOption() {
    setState(() {
      resendBtn = Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: InkWell(
          onTap: (){
            verifyNumber();
          },
          child: Container(
            width: 150,
            height: 50,
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Center(
              child: Text(
                Languages.of(context).resend_code,
                style: TextStyle(
                    color: Constants.hexToColor(Constants.primaryColor),
                    fontSize: 16,
                    fontWeight: FontWeight.w800),
              ),
            ),
          ),
        )
      );
    });
  }


  String smsCode = "";
  String currentPin = "";

  verifyCode(String pin, BuildContext context) async {
    currentPin = pin;
    if(smsCode == "") {
      authenticateAgain();
    }

  }

  Future<void> verifyNumber() async {
    FirebaseAuth auth = FirebaseAuth.instance;

    await auth.verifyPhoneNumber(
      phoneNumber: number,
      timeout: Duration(seconds: 30),

      verificationCompleted: (PhoneAuthCredential credential) async {
        _pinPutController.text = credential.smsCode;
        smsCode = credential.smsCode;


        if(smsCode != "") {
          if (currentPin == smsCode) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => SignUpPage(number),
              ),
            );
          } else {
            showAlertDialog(Languages.of(context).error_string, Languages.of(context).invalid_code, context);
          }
        }

        print("verificationCompleted: " + credential.smsCode);
      },
      codeSent: (String verificationId, int forceResendingToken) async {
        print(verificationId);
        verifyId = verificationId;
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        verifyId = verificationId;

      },
      verificationFailed: (FirebaseAuthException error) {
        print(Languages.of(context).error_string+": " + error.message);
      },
    );
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

    ;
  }

  Future<void> authenticateAgain() async {

   try {
     FirebaseAuth auth = FirebaseAuth.instance;
     PhoneAuthCredential credential = PhoneAuthProvider.credential(
         verificationId: verifyId, smsCode: currentPin);
    var res =  await auth.signInWithCredential(credential).whenComplete(() => () {
       print(Languages.of(context).success+":  " + credential.smsCode);
     }).catchError((err) {
       showAlertDialog(Languages.of(context).error_string, Languages.of(context).invalid_code, context);
     });


     if(res.user != null){
       Navigator.push(
         context,
         MaterialPageRoute(
           builder: (context) => SignUpPage(number),
         ),
       );
     }else{
       showAlertDialog(Languages.of(context).error_string, Languages.of(context).invalid_code, context);
     }

   }catch(e){
     showAlertDialog(Languages.of(context).error_string, Languages.of(context).invalid_code, context);
   }



  }


}
