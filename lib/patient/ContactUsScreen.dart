//ContactUsScreen
import 'dart:convert';
import 'dart:io';

import 'package:HealOnline/Utils.dart';
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
        title: Text("Contact Us",
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
                (value.isEmpty) ? "Please Enter Name" : null,
                decoration: InputDecoration(

                    prefixIcon: Icon(Icons.person_outline),
                    border: OutlineInputBorder(),
                    hintText: 'Name*',
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
                (value.isEmpty) ? "Please Enter Email" : null,
                decoration: InputDecoration(
                    prefixIcon: Icon(CupertinoIcons.mail),
                    border: OutlineInputBorder(),
                    hintText: 'Email*',
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
                (value.isEmpty) ? "Please Enter Message" : null,
                decoration: InputDecoration(
                  // prefixIcon: Icon(Icons.person_outline),
                    border: OutlineInputBorder(),
                    hintText: 'Message*',
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
          child: Text('SUBMIT',
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
        showAlertDialog("Success", "Query is sent to admin successfully!", context);

      } else {
        _btnController.reset();
        showAlertDialog(
            "Error", "Something went wrong please try again", context);
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

}