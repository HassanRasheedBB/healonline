import 'dart:convert';
import 'dart:io';

import 'package:HealOnline/Utils.dart';
import 'package:HealOnline/localization/language/languages.dart';
import 'package:HealOnline/localization/locale_constant.dart';
import 'package:HealOnline/models/CreditCardModel.dart';
import 'package:HealOnline/patient/PatientProfile.dart';
import 'package:HealOnline/patient/SchedualAppointmentScreen.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

class SaveCardScreen extends StatefulWidget {
  PatientProfileState fragment;
  bool showMessage = false;
  SaveCardScreen(this.fragment, {Key key, this.showMessage}) : super(key: key);

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
    super.initState();
    getLocale();
    getCardFromDB();
  }


  String savedCode;
  getLocale() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String languageCode = _prefs.getString(prefSelectedLanguageCode);

    if (languageCode != null) {
      savedCode = languageCode;
      changeLanguage(context, savedCode, true);

    }
  }

  @override
  void dispose() {
    super.dispose();
    if(widget.fragment != null) {
      widget.fragment.getLocale();
    }
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      //resizeToAvoidBottomInset: false,
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
        title: Text(Languages.of(context).add_stripe_card,
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
                child:  TextFormField(textInputAction: TextInputAction.done,

                  key: Key('Username'),
                  controller: _cardNumberController,
                  validator: (value) =>
                      (value.isEmpty) ? Languages.of(context).enter_card_number : null,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      prefixIcon: Icon(CupertinoIcons.creditcard),
                      border: OutlineInputBorder(),
                      hintText: Languages.of(context).card_number,
                      hintStyle: TextStyle(fontFamily: "ProductSans")),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 18),
                child:  TextFormField(textInputAction: TextInputAction.done,
                  key: Key('Username'),
                  controller: _cardHolderNameController,
                  validator: (value) =>
                      (value.isEmpty) ? Languages.of(context).card_holder_name : null,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person_outline),
                      border: OutlineInputBorder(),
                      hintText: Languages.of(context).card_holder_name_hint,
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
                      child:  TextFormField(textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.datetime,
                        key: Key('Username'),
                        controller: _cardExpiryController,
                        validator: (value) =>
                            (value.isEmpty) ? Languages.of(context).entry_expiry_date : null,
                        decoration: InputDecoration(
                            prefixIcon: Icon(CupertinoIcons.calendar),
                            border: OutlineInputBorder(),
                            hintText: Languages.of(context).expiry,
                            hintStyle: TextStyle(fontFamily: "ProductSans")),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 2 - 22,
                      child:  TextFormField(textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.number,
                        key: Key('Username'),
                        controller: _cardSecurityCodeController,
                        validator: (value) => (value.isEmpty)
                            ? Languages.of(context).enter_security_code
                            : null,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.security),
                            border: OutlineInputBorder(),
                            hintText: Languages.of(context).code,
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
          child: Text(Languages.of(context).update_card,
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
        showAlertDialog(Languages.of(context).error_string, Languages.of(context).expiry_date_err, context);
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
      Response response = await post(Uri.parse(url), headers: headers, body: jsonUser);
      int statusCode = response.statusCode;

      if (statusCode == 200) {
        if(widget.showMessage){
          if(SchedualAppointmentScreenState.creditCard == null){
            SchedualAppointmentScreenState.creditCard = creditCard;
          }
        }
        _btnController.reset();
        showAlertDialog(Languages.of(context).success, Languages.of(context).card_updated, context);

        if (Platform.isIOS) {
          getNotificationForIos();
        }

      } else {
        _btnController.reset();
        showAlertDialog(
            Languages.of(context).error_string, Languages.of(context).something_went_wrong, context);
      }
    } else {
      showAlertDialog(
          Languages.of(context).error_string, Languages.of(context).something_went_wrong, context);
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
                    if(widget.showMessage) {
                      getCardFromDB();
                    }
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
    Response response = await get(Uri.parse(url), headers: headers);
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



        CreditCard creditCard = new CreditCard();
        creditCard.card_number = typeList[0]["number"];
        creditCard.card_holder_name = typeList[0]["name"];
        creditCard.expiry_month = typeList[0]["expiry_month"];
        creditCard.expiry_year = typeList[0]["expiry_year"];
        creditCard.card_code = typeList[0]["code"];
        creditCard.id = typeList[0]["id"];


        if(SchedualAppointmentScreenState.creditCard == null){
          SchedualAppointmentScreenState.creditCard = creditCard;
        }

        if(widget.showMessage){
          Navigator.of(context).pop();
        }


      }
    });

    _btnController.reset();
  }

  Future<void> getNotificationForIos() async {

    String url = Utils.baseURL +
        Utils.GET_NOTIFICATIONS ;
    print(url);
    Map<String, String> headers = {
      "Content-type": "application/json",
      HttpHeaders.authorizationHeader: "Bearer " + Utils.user.token
    };
    Response response = await get(Uri.parse(url), headers: headers);
    String body = response.body;
    print(response.body);

    if(response.statusCode == 200) {

      final List typeList = (json.decode(response.body))["notifications"];
      if (typeList != null) {
        for (int i = 0; i < typeList.length; i++) {
          if (typeList[i]["title"] == "New card saved") {

            AwesomeNotifications().createNotification(
                content: NotificationContent(
                    id: 10,
                    channelKey: 'basic_channel',
                    title: typeList[i]["title"],
                    body: typeList[i]["body"]
                )
            );
            break;
          }
        }
      }
    }

  }


}
