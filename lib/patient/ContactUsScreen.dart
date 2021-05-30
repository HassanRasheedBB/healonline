//ContactUsScreen
import 'dart:convert';
import 'dart:io';

import 'package:HealOnline/Utils.dart';
import 'package:HealOnline/localization/language/languages.dart';
import 'package:HealOnline/models/ContactUsModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../constants.dart';

class ContactUsScreen extends StatefulWidget {
  ContactUsScreen({Key key}) : super(key: key);

  @override
  _ContactUsScreenState createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController messageController = TextEditingController();


  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final RoundedLoadingButtonController _btnController =
  new RoundedLoadingButtonController();

  @override
  void initState() {
    super.initState();
    nameController.text = Utils.user.profile_obj.pmeta_obj.full_name;
    emailController.text = Utils.user.profile_obj.umeta_obj.user_email;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
        title: Text(Languages.of(context).contact_us,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: "ProductSans",
                color: Constants.hexToColor(Constants.primaryDarkColor))),
      ),

      body: Form(
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
              child:   TextFormField(textInputAction: TextInputAction.done,
                key: Key('Username'),
                controller: nameController,
                validator: (value) =>
                (value.isEmpty) ? Languages.of(context).please_enter_user_name : null,
                decoration: InputDecoration(

                    prefixIcon: Icon(Icons.person_outline),
                    border: OutlineInputBorder(),
                    hintText: Languages.of(context).username,
                    hintStyle: TextStyle(fontFamily: "ProductSans")),
              ),
            ),

            SizedBox(
              height: 16,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18),
              child:   TextFormField(textInputAction: TextInputAction.done,
                key: Key('Username'),
                controller: emailController,
                validator: (value) =>
                (value.isEmpty) ? Languages.of(context).enter_email_address : null,
                decoration: InputDecoration(
                    prefixIcon: Icon(CupertinoIcons.mail),
                    border: OutlineInputBorder(),
                    hintText:Languages.of(context).email_address_hint,
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

            SizedBox(
              height: 16,
            ),

            Container(
              height:100,
              padding: EdgeInsets.symmetric(horizontal:18),
              child:  TextFormField(
                textInputAction: TextInputAction.done,
                keyboardType: TextInputType.multiline,
                maxLines: 4,
                key: Key('Location'),
                controller: messageController,
                validator: (value) =>
                (value.isEmpty) ? Languages.of(context).enter_message : null,
                decoration: InputDecoration(
                  // prefixIcon: Icon(Icons.person_outline),
                    border: OutlineInputBorder(),
                    hintText: Languages.of(context).message,
                    hintStyle: TextStyle(fontFamily: "ProductSans")),
              ),
            ),

          ],
        ),
      ),
      bottomNavigationBar:  Container(
        margin: EdgeInsets.only(bottom: 8),
        child: RoundedLoadingButton(
          width: MediaQuery.of(context).size.width - 32,
          animateOnTap: true,
          color: Constants.hexToColor(Constants.primaryDarkColor),
          elevation: 4,
          borderRadius: 10,
          child: Text(Languages.of(context).submit,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: "ProductSans")),
          controller: _btnController,
          onPressed: () {
            sendQueryToAdmin();
          },
        ),
      ),
    );
  }

  Future<void> sendQueryToAdmin() async {

    if (_formKey.currentState.validate()){

      String name = nameController.text;
      String email = emailController.text;
      String msg = messageController.text;

      ContactUs contactUsModel = new ContactUs(
        message: msg,
        email: email
      );

      String jsonUser = jsonEncode(contactUsModel);
      Map<String, String> headers = {
        "Content-type": "application/json",
        HttpHeaders.authorizationHeader: "Bearer " + Utils.user.token
      };

      print(jsonUser);
      String url = Utils.baseURL + Utils.QUERY_TO_ADMIN;
      print(url);

      Response response = await post(Uri.parse(url), headers: headers, body: jsonUser);
      int statusCode = response.statusCode;

      print(statusCode);
      print(response.body);
      print(Utils.user.token);

      if (statusCode == 200) {
        _btnController.reset();
        showAlertDialog(Languages.of(context).success, Languages.of(context).query_sent, context);

      } else {
        _btnController.reset();
        showAlertDialog(
            Languages.of(context).error_string, Languages.of(context).something_went_wrong, context);
      }

    }else{
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
              },
            )
          ],
        ));
  }

}