import 'dart:convert';
import 'dart:io';

import 'package:HealOnline/Utils.dart';
import 'package:HealOnline/localization/locale_constant.dart';
import 'package:HealOnline/models/CreditCardModel.dart';
import 'package:HealOnline/models/HealthCardModel.dart';
import 'package:HealOnline/models/PaymentModel.dart';
import 'package:HealOnline/patient/HealthCardScreen.dart';
import 'package:HealOnline/patient/SaveCardScreen.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:http/http.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:intl/intl.dart';

class SchedualAppointmentScreen extends StatefulWidget {
  SchedualAppointmentScreen({Key key}) : super(key: key);

  @override
  SchedualAppointmentScreenState createState() =>
      SchedualAppointmentScreenState();
}

class SchedualAppointmentScreenState extends State<SchedualAppointmentScreen> {
  final double circleRadius = 70.0;
  final RoundedLoadingButtonController _btnController =
      new RoundedLoadingButtonController();
  List<TimeObject> timeObjectList = List();

  var _selectedTimeStandard = "EST−05:00";
  List<String> _times = ["EST−05:00", "EST−04:00"];

  var time = [
    "09:00 AM",
    "09:10 AM",
    "09:20 AM",
    "09:40 AM",
    "09:50 AM",
    "10:10 AM",
    "10:20 AM",
    "10:30 AM",
    "10:40 AM",
    "10:50 AM",
    "11:00 AM",
    "11:20 AM",
    "11:30 AM",
    "11:40 AM",
    "12:00 AM",
    "01:30 PM",
    "01:45 PM",
    "02:00 PM",
    "02:10 PM",
    "02:30 PM",
    "02:40 PM",
    "02:50 PM",
    "03:10 PM",
    "03:30 PM",
    "03:40 PM",
    "03:50 PM",
    "04:00 PM",
    "04:10 PM",
    "04:20 PM",
    "04:40 PM",
    "04:50 PM"
  ];


  @override
  void dispose() {
    super.dispose();
    creditCard = null;
    healthCard = null;
  }

  @override
  void initState() {
    super.initState();
    getLocale();
    getHealthCard();
    getCardFromDB();
    Constants.appointment.appointmentDate = DateTime.now().toString();
    for (int i = 0; i < time.length; i++) {
      timeObjectList.add(TimeObject(time[i], false));
    }
  }



  String savedCode;
  getLocale() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String languageCode = _prefs.getString(prefSelectedLanguageCode);

    if (languageCode != null) {
      savedCode = languageCode;
      changeLanguage(context, "en", false);

      if (savedCode == "ar") {
        doMakeLangChanges();
      }
    }

  }


  var Appointment = "Appointment";
  var Time_Standard = "Time Standard";
  var Appointment_Time = "Appointment Time";
  var CONFIRM_APPOINTMENT = "CONFIRM APPOINTMENT";
  var Error = "Error";
  var select_appointment_time = "Please select appointment time";
  var select_appointment_date = "Please select appointment date";
  var appointment_will_at = "Appointment will schedule at";
  var Cancel = "Cancel";
  var OK = "OK";
  var Health_Card = "Health Card";
  var intimation = "Your health card information is required to book an appointment. To add or update health card, please press 'Continue' or press 'Pay Now' to pay via a stripe card now. Appointment Fee is CAD 50.00.";
  var Continue = "Continue";
  var Pay_Now = "Pay Now";
  var Confirmed = "Confirmed!";
  var appointment_confirmed = "Your appointment is confirmed";
  var Times = "Times";
  var some_went_wrong = "Some information went wrong please try again";


  void doMakeLangChanges(){
    setState(() {
      Appointment = "ميعاد";
      Time_Standard = "معيار الوقت";
      Times = "مرات";
      Appointment_Time = "وقت الموعد";
      CONFIRM_APPOINTMENT = "تأكيد التعيين";
      Error = "خطأ";
       select_appointment_time = "الرجاء تحديد وقت الموعد";
      select_appointment_date = "الرجاء تحديد تاريخ الموعد";
      appointment_will_at = "سيتم تحديد موعد في";
      OK = "نعم";
      Cancel = "يلغي";
      Health_Card = "بطاقة صحية";
      intimation = "معلومات بطاقتك الصحية مطلوبة لحجز موعد. لإضافة بطاقة صحية أو تحديثها ، يرجى الضغط على متابعة أو الضغط على ادفع الآن للدفع عبر بطاقة مخططة الآن. رسوم التعيين هي 50.00 دولار كندي";
      Continue = "يكمل";
      Pay_Now = "ادفع الآن";
      Confirmed = "مؤكد!";
      appointment_confirmed = "تم تأكيد موعدك";
      some_went_wrong = "حدث خطأ في بعض المعلومات ، يرجى المحاولة مرة أخرى";

    });
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
        title: Text(Appointment,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: "ProductSans",
                color: Constants.hexToColor(Constants.primaryDarkColor))),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 24),
            ListTile(
              leading: Container(
                margin: EdgeInsets.all(2),
                width: circleRadius,
                height: circleRadius,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Constants.hexToColor(Constants.primaryDarkColor),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8.0,
                      offset: Offset(0.0, 5.0),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Center(
                    child: Container(
                      child:
                          Image(image: AssetImage("assets/images/doctor.png")),

                      /// replace your image with the Icon
                    ),
                  ),
                ),
              ),
              title: Text(Constants.appointment.docName,
                  style: TextStyle(
                    fontFamily: "ProductSans",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Constants.hexToColor(
                      Constants.primaryDarkColor,
                    ),
                  )),
              subtitle: Text(Constants.appointment.skills,
                  style: TextStyle(
                    fontFamily: "ProductSans",
                    color: Constants.hexToColor(
                      Constants.primaryDarkColor,
                    ),
                  )),
            ),
            getCalender(),


            Padding(
              padding: EdgeInsets.only(left: 20, top: 16),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(Time_Standard,
                    style: TextStyle(
                      fontFamily: "ProductSans",
                      fontSize: 22,
                      //fontWeight: FontWeight.bold,
                      color: Constants.hexToColor(
                        Constants.primaryDarkColor,
                      ),
                    )),
              ),
            ),

            SizedBox(
              height: 16,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: Times,
                    labelStyle: Theme.of(context)
                        .primaryTextTheme
                        .caption
                        .copyWith(color: Colors.black),
                    border: const OutlineInputBorder(),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      hint: Text(
                        'Select Time Standard',
                        style: TextStyle(fontFamily: "ProductSans"),
                      ),
                      //isExpanded: true,
                      isDense: true,
                      // Reduces the dropdowns height by +/- 50%
                      icon: Icon(Icons.keyboard_arrow_down),
                      value: _selectedTimeStandard,
                      items: _times.map((item) {
                        return DropdownMenuItem(
                          value: item,
                          child: Text(
                            item,
                            style: TextStyle(fontFamily: "ProductSans"),
                          ),
                        );
                      }).toList(),
                      onChanged: (selectedItem) =>
                          setState(() => _selectedTimeStandard = selectedItem),
                    ),
                  )
              ),
            ),


            Padding(
              padding: EdgeInsets.only(left: 20, top: 16),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(Appointment_Time,
                    style: TextStyle(
                      fontFamily: "ProductSans",
                      fontSize: 22,
                      //fontWeight: FontWeight.bold,
                      color: Constants.hexToColor(
                        Constants.primaryDarkColor,
                      ),
                    )),
              ),
            ),
            SizedBox(height: 16),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                height: 200,
                child: GridView.count(
                  // Create a grid with 2 columns. If you change the scrollDirection to
                  // horizontal, this produces 2 rows.
                  crossAxisCount: 4,
                  childAspectRatio: 1.8,
                  // Generate 100 widgets that display their index in the List.
                  children: List.generate(timeObjectList.length, (index) {
                    return Container(
                      height: 40,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            for (int i = 0; i < timeObjectList.length; i++) {
                              if (i == index) {
                                timeObjectList[i].isSelected = true;
                                Constants.appointment.appointmentTime =
                                    timeObjectList[i].time;
                              } else {
                                timeObjectList[i].isSelected = false;
                              }
                            }
                          });
                        },
                        child: Card(
                          elevation: 2,
//                        shape: RoundedRectangleBorder(
//                          side: new BorderSide(color: Colors.grey, width: 1.0),
//                          borderRadius: BorderRadius.circular(6.0),
//                        ),
                          shape: timeObjectList[index].isSelected
                              ? new RoundedRectangleBorder(
                                  side: new BorderSide(
                                      color: Constants.hexToColor(
                                          Constants.primaryDarkColor),
                                      width: 3.0),
                                  borderRadius: BorderRadius.circular(6.0))
                              : new RoundedRectangleBorder(
                                  side: new BorderSide(
                                      color: Colors.grey, width: 1.0),
                                  borderRadius: BorderRadius.circular(6.0)),

                          child: Container(
                            height: 40,
                            width: 110,
                            child: Center(
                              child: Text(time[index],
                                  style: TextStyle(
                                      color: Constants.hexToColor(
                                        Constants.blackColor,
                                      ),
                                      fontSize: 14,
                                      fontFamily: "ProductSans")),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                )),
            SizedBox(height: 24),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: Container(
        child: Padding(
          padding: EdgeInsets.only(bottom: 8, top: 8),
          child: RoundedLoadingButton(
            width: MediaQuery.of(context).size.width - 32,
            animateOnTap: true,
            color: Constants.hexToColor(Constants.primaryDarkColor),
            elevation: 4,
            borderRadius: 10,
            child: Text(CONFIRM_APPOINTMENT,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: "ProductSans")),
            controller: _btnController,
            onPressed: () {

              if(healthCard != null){
                schedualAppointment();
                //askToFillTheCard();
              }else{
                askToFillTheCard();
              }

            },
          ),
        ),
      ),
    );
  }


  DateTime _currentDate = DateTime.now();

  Widget getCalender() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 18.0),
      child: CalendarCarousel<Event>(
        pageScrollPhysics: const NeverScrollableScrollPhysics(),
        isScrollable: false,

        weekdayTextStyle: TextStyle(
          fontFamily: "ProductSans",
          fontSize: 14,
          color: Constants.hexToColor(
            Constants.blackColor,
          ),
        ),
        selectedDayTextStyle: TextStyle(
          fontFamily: "ProductSans",
          color: Constants.hexToColor(
            Constants.whiteColor,
          ),
        ),

        selectedDayButtonColor: Constants.hexToColor(
          Constants.primaryDarkColor,
        ),
        headerTextStyle: TextStyle(
          fontFamily: "ProductSans",
          fontSize: 22,
          color: Constants.hexToColor(
            Constants.primaryDarkColor,
          ),
        ),
        daysTextStyle: TextStyle(
          fontFamily: "ProductSans",
          color: Constants.hexToColor(
            Constants.blackColor,
          ),
        ),
        onDayPressed: (DateTime date, List<Event> events) {
          this.setState(() {
            _currentDate = date;
            Constants.appointment.appointmentDate = _currentDate.toString();
          });
        },
        weekendTextStyle: TextStyle(
          fontFamily: "ProductSans",
          color: Constants.hexToColor(
            Constants.blackColor,
          ),
        ),
        thisMonthDayBorderColor: Colors.grey,

        selectedDayBorderColor: Constants.hexToColor(
          Constants.primaryDarkColor,
        ),

        weekFormat: false,
        height: 410.0,
        selectedDateTime: _currentDate,
        daysHaveCircularBorder: true,

        /// null for not rendering any border, true for circular border, false for rectangular border
      ),
    );
  }

  void schedualAppointment() {
    if (Constants.appointment.appointmentTime.isEmpty) {
      showOtherAlertDialog(Error, select_appointment_time, context);
      return;
    } else if (Constants.appointment.appointmentDate.isEmpty) {
      showOtherAlertDialog(Error, select_appointment_date, context);
      return;
    }
    showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
              title: Text(CONFIRM_APPOINTMENT,
                  style: TextStyle(
                    fontFamily: "ProductSans",
                  )),
              content: Text(
                  appointment_will_at+" " +
                      Constants.appointment.appointmentDate.split(" ").first +
                      " " +
                      Constants.appointment.appointmentTime,
                  style: TextStyle(
                    fontFamily: "ProductSans",
                  )),
              actions: [

                CupertinoDialogAction(
                  child: Text(Cancel,
                      style: TextStyle(
                        fontFamily: "ProductSans",
                      )),
                  onPressed: () {
                    _btnController.reset();
                    Navigator.of(context).pop();
                  },
                ),

                CupertinoDialogAction(
                  child: Text(OK,
                      style: TextStyle(
                        fontFamily: "ProductSans",
                      )),
                  onPressed: () async {
                    Navigator.of(context).pop();
                    bookAppointment();
                  },
                ),


              ],
            ));
  }

  void showOtherAlertDialog(String title, String msg, BuildContext context) {
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
                  child: Text(OK,
                      style: TextStyle(
                        fontFamily: "ProductSans",
                      )),
                  onPressed: () {
                    _btnController.reset();
                    Navigator.of(context).pop();
                  },
                )
              ],
            ));

    ;
  }


  void askToFillTheCard() {

    showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: Text(Health_Card,
              style: TextStyle(
                fontFamily: "ProductSans",
              )),
          content: Text(intimation,
              style: TextStyle(
                fontFamily: "ProductSans",
              )),
          actions: [

            CupertinoDialogAction(
              child: Text(Cancel,
                  style: TextStyle(
                    fontFamily: "ProductSans",
                  )),
              onPressed: () {
                _btnController.reset();
                Navigator.of(context).pop();
              },
            ),

            CupertinoDialogAction(
              child: Text(Continue,
                  style: TextStyle(
                    fontFamily: "ProductSans",
                  )),
              onPressed: () {
                _btnController.reset();
                Navigator.of(context).pop();

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HealthCardScreen(null, showMessage: true),
                    ),
                  );

              },
            ),

            CupertinoDialogAction(
              child: Text(Pay_Now,
                  style: TextStyle(
                    fontFamily: "ProductSans",
                  )),
              onPressed: () {
                Navigator.of(context).pop();

                if(creditCard != null){
                  paymentProcess();
                }else{
                  _btnController.reset();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SaveCardScreen(null, showMessage: true),
                    ),
                  );
                }
              },
            ),

          ],
        ));


  }

  Future<void> bookAppointment() async {
    String url = Utils.baseURL + Utils.BOOK_APPOINTMENT;
    print(url);

    Uri uri = Uri.parse(url);
    http.MultipartRequest request = new http.MultipartRequest('POST', uri);

    String time = Constants.appointment.appointmentTime.split(" ").first;
    var timeFirst = int.parse(time.split(":").first);
    if (timeFirst >= 1 && timeFirst < 9) {
      timeFirst += 12;
      time = timeFirst.toString() + ":" + (time.split(":").last);
    } else {
      time = Constants.appointment.appointmentTime.split(" ").first;
    }

    print(time);

    request.fields['doc_id'] = Constants.appointment.docId;
    request.fields['patient_id'] =
        Utils.user.profile_obj.umeta_obj.id.toString();
    request.fields['province'] = Constants.appointment.province;
    request.fields['symptoms'] = Constants.appointment.symptoms;
    request.fields['how_long_felt'] = Constants.appointment.howLongFelt;
    request.fields['covid'] = "0";
    request.fields['covid_location'] = Constants.appointment.covidLocation;
    request.fields['covid_time_travel'] = Constants.appointment.covidTimeTravel;
    request.fields['sick_note'] = Constants.appointment.sickNote;
    if (Constants.appointment.AudioOrVideo != null &&
        Constants.appointment.AudioOrVideo.isNotEmpty) {
      request.fields['appointment_files'] = "1";
    } else {
      request.fields['appointment_files'] = "0";
    }
    request.fields['file_data[0][type]'] = "image";
    request.fields['additional_details'] =
        Constants.appointment.additionalDetails;
    request.fields['date'] =
        Constants.appointment.appointmentDate.split(" ").first;
    request.fields['time'] = time;
    request.fields['appointment_for'] = Constants.appointment.appointmentFor;
    request.fields['userName'] = Constants.appointment.userName;
    request.fields['userId'] = Constants.appointment.userId;
    request.fields['userName'] = Constants.appointment.userName;
    request.fields['status'] = "0";
    request.fields['time_standard'] = _selectedTimeStandard;

    request.headers['Content-type'] = "application/json";
    request.headers['Authorization'] = "Bearer " + Utils.user.token;

    if (Constants.appointment.AudioOrVideo != null &&
        Constants.appointment.AudioOrVideo.isNotEmpty) {
      String fileName = Constants.appointment.AudioOrVideo.split('/').last;
      String ext = fileName.split(".").last;
      request.files.add(await http.MultipartFile.fromPath(
          'file_data[0][file]', Constants.appointment.AudioOrVideo,
          contentType: new MediaType('image', ext)));
    }

    print(Constants.appointment.appointmentDate.split(" ").first);
    print(time);

    request.send().then((http.StreamedResponse response) async {
      _btnController.reset();
      if (response.statusCode == 200) {
        showOtherAlertDialog(
            Confirmed, appointment_confirmed, context);

        if (Platform.isIOS) {
          getNotificationForIos();
        }


      } else {
        showOtherAlertDialog(
            Error, some_went_wrong, context);
        print(response.toString());
      }
    }).catchError((error) async {
      _btnController.reset();
      showOtherAlertDialog(
          Error, some_went_wrong, context);
      print(error.toString());
    });
  }

  static HealthCardModel healthCard;

  Future<void> getHealthCard() async {
    String url = Utils.baseURL + Utils.HEALTH_CARD;

    print(url);
    Map<String, String> headers = {
      "Content-type": "application/json",
      HttpHeaders.authorizationHeader: "Bearer " + Utils.user.token
    };
    Response response = await get(Uri.parse(url), headers: headers);
    String body = response.body;
    print(body);

    var _healthCard = (json.decode(response.body))["card"];

    if (_healthCard != null) {
      healthCard = new HealthCardModel();
      healthCard.id = _healthCard["id"];
      healthCard.health_card_province = _healthCard["province"];
      healthCard.number = _healthCard["number"];
      healthCard.dob = _healthCard["dob"];
      healthCard.phone = _healthCard["phone"];
      healthCard.address = _healthCard["address"];
      healthCard.postal_code = _healthCard["postal_code"];
      healthCard.sex = _healthCard["sex"];
    }
  }



  static CreditCard creditCard;
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

      if (typeList.isNotEmpty) {
        creditCard = new CreditCard();
        creditCard.card_number = typeList[0]["number"];
        creditCard.card_holder_name = typeList[0]["name"];
        creditCard.expiry_month = typeList[0]["expiry_month"];
        creditCard.expiry_year = typeList[0]["expiry_year"];
        creditCard.card_code = typeList[0]["code"];
        creditCard.id = typeList[0]["id"];
      }

  }

  Future<void> paymentProcess() async {

    PaymentModel paymentModel = new PaymentModel(
      card_id: creditCard.id.toString(),
      amount: "50"
    );

    String url =  Utils.baseURL + Utils.CARD_PAY+ Utils.user.profile_obj.umeta_obj.profile_id.toString();
    print(url);
    String jsonUser = jsonEncode(paymentModel);
    Map<String, String> headers = {
      "Content-type": "application/json",
      HttpHeaders.authorizationHeader: "Bearer " + Utils.user.token
    };
    Response response = await post(Uri.parse(url), headers: headers, body: jsonUser);
    int statusCode = response.statusCode;

    print(jsonUser);
    print(response.body);

    if (statusCode == 200) {
      schedualAppointment();
    }else{
      _btnController.reset();
      showAlertDialog(
          Error, some_went_wrong, context);
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
              child: Text(OK,
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
          if (typeList[i]["title"] == "Booking confirmed") {

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

class TimeObject {
  String time;
  bool isSelected;
  TimeObject(this.time, this.isSelected);

}
