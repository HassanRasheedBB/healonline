//EditProfileScreen

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../constants.dart';

class EditProfileScreen extends StatefulWidget {
  EditProfileScreen({Key key}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController fNameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController languageController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController provinceController = TextEditingController();
  TextEditingController cardNoController = TextEditingController();
  TextEditingController insuranceProviderController = TextEditingController();
  TextEditingController policyNoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomPadding: false,
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
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height - 140,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  SizedBox(
                    height:24,
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
                      key: Key('Username'),
                      controller: lNameController,
                      validator: (value) =>
                      (value.isEmpty) ? "Please Select Gender" : null,
                      decoration: InputDecoration(
                          suffixIcon: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey,),
                          prefixIcon: Container(
                            padding: EdgeInsets.all(12),
                            width: 8,
                            height: 8,
                            child: SvgPicture.asset(
                              "assets/images/gender.svg",
                              color: Colors.black45,
                            ),
                          ),
                          border: OutlineInputBorder(),
                          hintText: 'Gender*',
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
                      controller: lNameController,
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
                      key: Key('Username'),
                      controller: languageController,
                      validator: (value) =>
                      (value.isEmpty) ? "Please Select Language" : null,
                      decoration: InputDecoration(
                          suffixIcon: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey,),
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
                          hintText: 'Lanuage*',
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
                    child: IntlPhoneField(
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
                  ),

                  SizedBox(
                    height: 24,
                  ),

                  Divider(color: Colors.black26,),

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
                      controller: languageController,
                      validator: (value) =>
                      (value.isEmpty) ? "Please Select Language" : null,
                      decoration: InputDecoration(
                          suffixIcon: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey,),
                          prefixIcon: Icon(CupertinoIcons.lab_flask_solid),
                          border: OutlineInputBorder(),
                          hintText: 'Pharmacy*',
                          hintStyle: TextStyle(fontFamily: "ProductSans")),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18),
                    child: IntlPhoneField(
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
                  ),





                  SizedBox(
                    height: 16,
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18),
                    child: IntlPhoneField(
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        border: OutlineInputBorder(
                          borderSide: BorderSide(),
                        ),
                      ),
                      initialCountryCode: 'CA',
                      onChanged: (phone) {
                        print(phone.completeNumber);
                      },
                    ),
                  ),

                  SizedBox(
                    height: 28,
                  ),



                  Divider(color: Colors.black26,),

                  SizedBox(
                    height: 18,
                  ),


                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 22),
                    child: Text('Health Card',
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
                      controller: provinceController,
                      validator: (value) =>
                      (value.isEmpty) ? "Please Select Province" : null,
                      decoration: InputDecoration(
                          suffixIcon: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey,),
                          prefixIcon: Icon(CupertinoIcons.location),
                          border: OutlineInputBorder(),
                          hintText: 'Province',
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
                      controller: cardNoController,
                      validator: (value) =>
                      (value.isEmpty) ? "Please Enter Card Number" : null,
                      decoration: InputDecoration(
                          prefixIcon: Icon(CupertinoIcons.creditcard),
                          border: OutlineInputBorder(),
                          hintText: '0000-000-000-XX',
                          hintStyle: TextStyle(fontFamily: "ProductSans")),
                    ),
                  ),
                  SizedBox(
                    height: 28,
                  ),



                  Divider(color: Colors.black26,),

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
                          suffixIcon: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey,),
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
          ),

          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Constants.hexToColor(Constants.primaryDarkColor),
            ),
            child: FlatButton(
              onPressed: () {},
              child: Center(
                child: Text('SAVE',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: "ProductSans")),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
