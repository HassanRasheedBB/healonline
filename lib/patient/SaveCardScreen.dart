import 'dart:convert';
import 'dart:io';

import 'package:HealOnline/Utils.dart';
import 'package:HealOnline/models/CreditCardModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';

class SaveCardScreen extends StatefulWidget {
  SaveCardScreen({Key key}) : super(key: key);

  @override
  _SaveCardScreenState createState() => _SaveCardScreenState();
}

class _SaveCardScreenState extends State<SaveCardScreen> {
  TextEditingController _cardNumberController = TextEditingController();
  TextEditingController _cardHolderNameController = TextEditingController();
  TextEditingController _cardExpiryController = TextEditingController();
  TextEditingController _cardSecurityCodeController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final RoundedLoadingButtonController _btnController =
      new RoundedLoadingButtonController();

  CreditCard card;
  int creditCardId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCardFromDB();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      //resizeToAvoidBottomPadding: false,
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
        title: Text("Add Card",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: "ProductSans",
                color: Constants.hexToColor(Constants.primaryDarkColor))),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 300,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: SvgPicture.asset(
                    "assets/images/credit_card.svg",
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 18),
                child: TextFormField(
                  key: Key('Username'),
                  controller: _cardNumberController,
                  validator: (value) =>
                      (value.isEmpty) ? "Please Enter Card Number" : null,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      prefixIcon: Icon(CupertinoIcons.creditcard),
                      border: OutlineInputBorder(),
                      hintText: 'Card Number*',
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
                  controller: _cardHolderNameController,
                  validator: (value) =>
                      (value.isEmpty) ? "Please Enter Card Number" : null,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person_outline),
                      border: OutlineInputBorder(),
                      hintText: 'Card Holder Name*',
                      hintStyle: TextStyle(fontFamily: "ProductSans")),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 2 - 22,
                      child: TextFormField(
                        keyboardType: TextInputType.datetime,
                        key: Key('Username'),
                        controller: _cardExpiryController,
                        validator: (value) =>
                            (value.isEmpty) ? "Please Enter Expiry Date" : null,
                        decoration: InputDecoration(
                            prefixIcon: Icon(CupertinoIcons.calendar),
                            border: OutlineInputBorder(),
                            hintText: 'Expiry*',
                            hintStyle: TextStyle(fontFamily: "ProductSans")),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 2 - 22,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        key: Key('Username'),
                        controller: _cardSecurityCodeController,
                        validator: (value) => (value.isEmpty)
                            ? "Please Enter Security Code"
                            : null,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.security),
                            border: OutlineInputBorder(),
                            hintText: 'Code*',
                            hintStyle: TextStyle(fontFamily: "ProductSans")),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(bottom: 8),
        child: RoundedLoadingButton(
          width: MediaQuery.of(context).size.width - 32,
          animateOnTap: true,
          color: Constants.hexToColor(Constants.primaryDarkColor),
          elevation: 4,
          borderRadius: 10,
          child: Text('UPDATE CARD',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: "ProductSans")),
          controller: _btnController,
          onPressed: () {
            saveCard();
          },
        ),
      ),
    );
  }

  Future<void> saveCard() async {
    if (_formKey.currentState.validate()) {

      if(!_cardExpiryController.text.contains("/")){
        showAlertDialog("Error", "Expiry date format should be Month/Year (00/00)", context);
        return;
      }

      CreditCard creditCard = new CreditCard(
          card_number: _cardNumberController.text.toString(),
          card_holder_name: _cardHolderNameController.text.toString(),
          expiry_month: _cardExpiryController.text.toString().split("/").first,
          expiry_year: _cardExpiryController.text.toString().split("/").last,
          card_code: _cardSecurityCodeController.text.toString());

      String url = "";
      if (creditCardId == 0 || creditCardId == null) {
        url = Utils.baseURL + Utils.UPDATE_CARD;
      } else {
        url = Utils.baseURL + Utils.UPDATE_CARD + "/" + creditCardId.toString();
      }

      String jsonUser = jsonEncode(creditCard);
      Map<String, String> headers = {
        "Content-type": "application/json",
        HttpHeaders.authorizationHeader: "Bearer " + Utils.user.token
      };
      Response response = await post(url, headers: headers, body: jsonUser);
      int statusCode = response.statusCode;

      if (statusCode == 200) {
        _btnController.reset();
        showAlertDialog("Success", "Card is updated successfully", context);
      } else {
        _btnController.reset();
        showAlertDialog(
            "Error", "Something went wrong please try again", context);
      }
    } else {
      showAlertDialog(
          "Error", "Something went wrong please try again", context);
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

  Future<void> getCardFromDB() async {
    String url = Utils.baseURL +
        Utils.GET_CARD +
        Utils.user.profile_obj.umeta_obj.profile_id.toString();
    print(url);
    Map<String, String> headers = {
      "Content-type": "application/json",
      HttpHeaders.authorizationHeader: "Bearer " + Utils.user.token
    };
    Response response = await get(url, headers: headers);
    String body = response.body;
    print(response.body);
    final List typeList = (json.decode(response.body))["cards"];
    setState(() {
      if (typeList.isNotEmpty) {
        _cardNumberController.text = typeList[0]["number"];
        _cardHolderNameController.text = typeList[0]["name"];
        _cardExpiryController.text = typeList[0]["expiry_month"]+"/"+typeList[0]["expiry_year"];
        _cardSecurityCodeController.text = typeList[0]["code"];
        creditCardId = typeList[0]["id"];
      }
    });
  }
}
