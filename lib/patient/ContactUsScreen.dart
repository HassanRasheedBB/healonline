//ContactUsScreen
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [

          SizedBox(
            height: 24,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18),
            child:  TextFormField(
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
            child:  TextFormField(
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
            child: TextFormField(
              keyboardType: TextInputType.multiline,
              maxLines: 4,
              key: Key('Location'),
              decoration: InputDecoration(
                // prefixIcon: Icon(Icons.person_outline),
                  border: OutlineInputBorder(),
                  hintText: 'Message*',
                  hintStyle: TextStyle(fontFamily: "ProductSans")),
            ),
          ),

        ],
      ),
      bottomNavigationBar:  Container(
        margin: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(6)),
          color: Constants.hexToColor(Constants.primaryDarkColor),
        ),
        child: FlatButton(
          onPressed: () {


          },
          child: Center(
            child: Text('SUBMIT',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: "ProductSans")),
          ),
        ),
      ),
    );
  }

}