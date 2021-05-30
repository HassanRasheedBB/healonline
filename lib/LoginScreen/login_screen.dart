import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:HealOnline/SignUpScreen/SignupScreen.dart';
import 'package:HealOnline/Utils.dart';
import 'package:HealOnline/doctor/HomePage.dart';
import 'package:HealOnline/localization/language/languages.dart';
import 'package:HealOnline/localization/locale_constant.dart';
import 'package:HealOnline/main.dart';
import 'package:HealOnline/models/LoginRequest.dart';
import 'package:HealOnline/models/LoginResponse.dart';
import 'package:HealOnline/patient/HomePagePatient.dart';
import 'package:HealOnline/patient/fragments/HomePage.dart';
import 'package:HealOnline/phone_authentication/phone_number_screen.dart';
import 'package:HealOnline/restart_widget.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:custom_radio_grouped_button/CustomButtons/ButtonTextStyle.dart';
import 'package:custom_radio_grouped_button/CustomButtons/CustomCheckBoxGroup.dart';
import 'package:custom_radio_grouped_button/CustomButtons/CustomRadioButton.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';

import '../constants.dart';


Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

/// Create a [AndroidNotificationChannel] for heads up notifications
const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  'This channel is used for important notifications.', // description
  importance: Importance.high,
);

/// Initialize the [FlutterLocalNotificationsPlugin] package.
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();


class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final RoundedLoadingButtonController _btnController =
  new RoundedLoadingButtonController();

  // FirebaseMessaging _firebaseMessaging = FirebaseMessaging();


  bool _isShowPwd = false;
  String selectedUserAs = "PATIENT";



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setUpNotifications();
    getLocale();
    // firebaseCloudMessaging_Listeners();
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

  // String token;

  // void firebaseCloudMessaging_Listeners() {
  //   if (Platform.isIOS) iOS_Permission();
  //
  //   _firebaseMessaging.getToken().then((token){
  //     this.token = token;
  //     Constants.fcm_token = token;
  //     print("token----:   "+token);
  //   });
  //
  //   _firebaseMessaging.configure(
  //     onMessage: (Map<String, dynamic> message) async {
  //       print('on message $message');
  //     },
  //     onResume: (Map<String, dynamic> message) async {
  //       print('on resume $message');
  //     },
  //     onLaunch: (Map<String, dynamic> message) async {
  //       print('on launch $message');
  //     },
  //   );
  // }
  //
  //
  // void iOS_Permission() {
  //   _firebaseMessaging.requestNotificationPermissions(
  //       IosNotificationSettings(sound: true, badge: true, alert: true)
  //   );
  //   _firebaseMessaging.onIosSettingsRegistered
  //       .listen((IosNotificationSettings settings)
  //   {
  //     print("Settings registered: $settings");
  //   });
  // }


  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  int selected_index = 1;
  var langs = ["English", "Arabic"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Align(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 30),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[

                Align(
                  alignment: Alignment.topRight,
                  child: PopupMenuButton(

                    onSelected: (value){

                      if(value == "English"){
                        changeLanguage(context, "en", true);
                      }else{
                        changeLanguage(context, "ar", true);
                      }
                      // Future.delayed(
                      //   Duration(milliseconds: 500),
                      //       () {
                      //     Utils.user.is_loggedIn = "0";
                      //     // setState(() {
                      //     Navigator.pushReplacement(
                      //       context,
                      //       MaterialPageRoute(
                      //         builder: (context) => MyApp(),
                      //       ),
                      //     );
                      //   },
                      // );


                    },
                    elevation: 2,
                    offset: Offset(0, 20),
                    child: Container(
                      width: 36,
                      height: 36,
                      child: SvgPicture.asset(
                        "assets/images/language.svg",
                        color: Constants.hexToColor(Constants.primaryDarkColor),
                      ),
                    ),
                    itemBuilder: (context) {
                      return List.generate(langs.length, (index) {
                        return PopupMenuItem(
                          value: langs[index],
                          child: Text(langs[index]),
                        );
                      });
                    },
                  ),
                ),

                Image(
                  image: AssetImage("assets/images/logo.png"),
                  width: 180,
                ),
                Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  child: Text(
                    Languages
                        .of(context)
                        .login_as,
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        fontFamily: "ProductSans"),
                  ),
                ),
                SizedBox(
                  height: 24,
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
                    Languages
                        .of(context)
                        .patient_string,
                    Languages
                        .of(context)
                        .health_provider_string,
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
                    selectedUserAs = value;
                  },
                  selectedColor:
                  Constants.hexToColor(Constants.primaryDarkColor),
                ),
                SizedBox(
                  height: 16,
                ),
                TextFormField(textInputAction: TextInputAction.done,
                  key: Key(Languages
                      .of(context)
                      .username),
                  controller: _usernameController,
                  validator: (value) =>
                  (value.isEmpty) ? Languages
                      .of(context)
                      .please_enter_user_name : null,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person_outline),
                      border: OutlineInputBorder(),
                      hintText: Languages
                          .of(context)
                          .username,
                      hintStyle: TextStyle(fontFamily: "ProductSans")),
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(textInputAction: TextInputAction.done,
                  key: Key(Languages
                      .of(context)
                      .password),
                  controller: _passwordController,
                  validator: (value) =>
                  (value.isEmpty) ? Languages
                      .of(context)
                      .please_enter_password : null,
                  obscureText: (_isShowPwd) ? false : true,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock_outline),
                    border: OutlineInputBorder(),
                    hintText: Languages
                        .of(context)
                        .password,
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
                  height: 12,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    Languages
                        .of(context)
                        .forgot_password,
                    style: TextStyle(
                      fontFamily: "ProductSans",
                      color: Constants.hexToColor(Constants.primaryColor),
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
                    child: Text(Languages
                        .of(context)
                        .login,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: "ProductSans")),
                    controller: _btnController,
                    onPressed: () {
                      loginUser();
                      //loginTemporary();
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
                        Languages
                            .of(context)
                            .dont_have_an_account,
                        style: TextStyle(fontFamily: "ProductSans"),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PhoneNumberScreen(),
                            ),
                          );
                        },
                        child: Text(
                          Languages
                              .of(context)
                              .signup,
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
      ),
    );
  }

  Future<void> loginUser() async {
    if (_formKey.currentState.validate()) {
      String url = Utils.baseURL + Utils.USER_LOGIN;
      Map<String, String> headers = Utils.HEADERS;
      LoginRequest user = LoginRequest(
          _usernameController.text, _passwordController.text,
          Constants.fcm_token.toString());
      String jsonUser = jsonEncode(user);
      Response response = await post(
          Uri.parse(url), headers: headers, body: jsonUser);
      int statusCode = response.statusCode;

      if (statusCode == 200) {
        String body = response.body;
        LoginResponse _loginResponse = LoginResponse.fromJson(
            json.decode(body));

        Utils.user = _loginResponse;
        Utils.user.is_loggedIn = "1";

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('loggedIn', "1");
        await prefs.setInt(
            'profile_id', _loginResponse.profile_obj.umeta_obj.profile_id);
        await prefs.setInt('id', _loginResponse.profile_obj.umeta_obj.id);
        await prefs.setString('user_login',
            _loginResponse.profile_obj.umeta_obj.user_login.toString());
        await prefs.setString('user_pass',
            _loginResponse.profile_obj.umeta_obj.user_pass.toString());
        await prefs.setString('user_email',
            _loginResponse.profile_obj.umeta_obj.user_email.toString());
        await prefs.setString('user_type',
            _loginResponse.profile_obj.pmeta_obj.user_type.toString());
        await prefs.setString('full_name',
            _loginResponse.profile_obj.pmeta_obj.full_name.toString());
        await prefs.setString('profile_img',
            _loginResponse.profile_obj.pmeta_obj.profile_img.toString());
        await prefs.setString('token', _loginResponse.token.toString());




        if (Platform.isIOS) {
          getNotificationForIos();
        } else {
          _btnController.reset();
          RestartWidget.restartApp(context);
        }



        // if (_loginResponse.profile_obj.pmeta_obj.user_type == "patient") {
        //   Navigator.pushReplacement(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => HomePagePatient(),
        //     ),
        //   );
        // }
        // else {
        //   Navigator.pushReplacement(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => HomeScreen(),
        //     ),
        //   );
        // }



      } else {
        showAlertDialog(Languages
            .of(context)
            .invalid_credentials,
            Languages
                .of(context)
                .either_username_or_password_not_correct, context);
        _btnController.reset();
      }
    } else {
      showAlertDialog(Languages
          .of(context)
          .missing_information,
          Languages
              .of(context)
              .plz_fill_all_fields, context);
      _btnController.reset();
      return;
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
                  child: Text(Languages
                      .of(context)
                      .ok,
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

  void loginTemporary() {
    if (selectedUserAs == "PATIENT" &&
        _usernameController.text == 'anya@gmail.com' &&
        _passwordController.text == 'Pakistan@123') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePagePatient(),
        ),
      );
    } else if (selectedUserAs != "PATIENT" &&
        _usernameController.text == 'David@gmail.com' &&
        _passwordController.text == 'Pakistan@123') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
      );
    } else {
      showAlertDialog("Error", "Invalid Credentials", context);
    }
    _btnController.reset();
  }


  Future<void> setUpNotifications() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();

    // Set the background messaging handler early on, as a named top-level function
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    /// Create an Android Notification Channel.
    ///
    /// We use this channel in the `AndroidManifest.xml` file to override the
    /// default FCM channel to enable heads up notifications.
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    if (Platform.isIOS) {
      FirebaseMessaging.instance.requestPermission();
    }


    String token = await FirebaseMessaging.instance.getToken();
    //String apn_token = await FirebaseMessaging.instance.getAPNSToken();
    if (token != null) {
      Constants.fcm_token = token;
      print(token);
    }


    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage message) {
      if (message != null) {}
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;

      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                  channel.id,
                  channel.name,
                  channel.description,
                  // TODO add a proper drawable resource to android, for now using
                  //      one that already exists in example app.
                  icon: 'ic_launcher', playSound: true,
                  priority: Priority.high
              ),
            ));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
    });
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
          if (typeList[i]["title"] == "Login Alert") {

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

    _btnController.reset();
    RestartWidget.restartApp(context);

  }


}
