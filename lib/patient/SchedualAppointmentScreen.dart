import 'dart:convert';
import 'dart:io';

import 'package:HealOnline/Utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:http/http.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../constants.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:intl/intl.dart';

class SchedualAppointmentScreen extends StatefulWidget {
  SchedualAppointmentScreen({Key key}) : super(key: key);

  @override
  _SchedualAppointmentScreenState createState() =>
      _SchedualAppointmentScreenState();
}

class _SchedualAppointmentScreenState extends State<SchedualAppointmentScreen> {
  final double circleRadius = 70.0;
  final RoundedLoadingButtonController _btnController =
      new RoundedLoadingButtonController();
  List<TimeObject> timeObjectList = List();

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
  void initState() {
    // TODO: implement initState
    super.initState();
    Constants.appointment.appointmentDate = DateTime.now().toString();
    for (int i = 0; i < time.length; i++) {
      timeObjectList.add(TimeObject(time[i], false));
    }
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
        title: Text("Appointment",
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
              padding: EdgeInsets.only(left: 20),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text("Appointment Time",
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
                height: 180,
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
            child: Text('CONFIRM APPOINTMENT',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: "ProductSans")),
            controller: _btnController,
            onPressed: () {
              schedualAppointment();
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
        height: 400.0,
        selectedDateTime: _currentDate,
        daysHaveCircularBorder: true,

        /// null for not rendering any border, true for circular border, false for rectangular border
      ),
    );
  }

  void schedualAppointment() {
    if(Constants.appointment.appointmentTime.isEmpty){
      showOtherAlertDialog("Error", "Please select appointment time", context);
      return;
    }else if(Constants.appointment.appointmentDate.isEmpty){
      showOtherAlertDialog("Error", "Please select appointment date", context);
      return;
    }
    showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
              title: Text("Confirm Appointment",
                  style: TextStyle(
                    fontFamily: "ProductSans",
                  )),
              content: Text(
                  "Appointment will schedule at " +
                      Constants.appointment.appointmentDate.split(" ").first +
                      " " +
                      Constants.appointment.appointmentTime,
                  style: TextStyle(
                    fontFamily: "ProductSans",
                  )),
              actions: [
                CupertinoDialogAction(
                  child: Text("OK",
                      style: TextStyle(
                        fontFamily: "ProductSans",
                      )),
                  onPressed: () async {
                    Navigator.of(context).pop();
                    bookAppointment();
                  },
                ),
                CupertinoDialogAction(
                  child: Text("Cancel",
                      style: TextStyle(
                        fontFamily: "ProductSans",
                      )),
                  onPressed: () {
                    _btnController.reset();
                    Navigator.of(context).pop();
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
                  child: Text("OK",
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

  Future<void> bookAppointment() async {

    String url = Utils.baseURL + Utils.BOOK_APPOINTMENT;
    print(url);

    Uri uri = Uri.parse(url);
    http.MultipartRequest request = new http.MultipartRequest('POST', uri);

    String time = Constants.appointment.appointmentTime.split(" ").first;
    var timeFirst = int.parse(time.split(":").first);
    if(timeFirst >= 1 && timeFirst < 9){
      timeFirst+= 12;
      time = timeFirst.toString()+":"+(time.split(":").last);
    }else{
      time = Constants.appointment.appointmentTime.split(" ").first;
    }

    print(time);

    request.fields['doc_id'] = Constants.appointment.docId;
    request.fields['patient_id'] = Utils.user.profile_obj.umeta_obj.id.toString();
    request.fields['province'] = Constants.appointment.province;
    request.fields['symptoms'] = Constants.appointment.symptoms;
    request.fields['how_long_felt'] = Constants.appointment.howLongFelt;
    request.fields['covid'] = "0";
    request.fields['covid_location'] = Constants.appointment.covidLocation;
    request.fields['covid_time_travel'] = Constants.appointment.covidTimeTravel;
    request.fields['sick_note'] = Constants.appointment.sickNote;
    if(Constants.appointment.AudioOrVideo != null && Constants.appointment.AudioOrVideo.isNotEmpty){
      request.fields['appointment_files'] = "1";
    }
    else{
      request.fields['appointment_files'] = "0";
    }
    request.fields['file_data[0][type]'] = "image";
    request.fields['additional_details'] =
        Constants.appointment.additionalDetails;
    request.fields['date'] = Constants.appointment.appointmentDate.split(" ").first;
    request.fields['time'] = time;
    request.fields['appointment_for'] = Constants.appointment.appointmentFor;
    request.fields['userName'] = Constants.appointment.userName;
    request.fields['userId'] = Constants.appointment.userId;
    request.fields['userName'] = Constants.appointment.userName;
    request.fields['status'] = "0";

    request.headers['Content-type'] = "application/json";
    request.headers['Authorization'] = "Bearer " + Utils.user.token;


    if(Constants.appointment.AudioOrVideo != null && Constants.appointment.AudioOrVideo.isNotEmpty){
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
        showOtherAlertDialog("Confirmed!", "Your appointment is confirmed", context);
      } else {
        showOtherAlertDialog("Error", "Some information went wrong please try again", context);
        print(response.toString());
      }
    }).catchError((error) async {
      _btnController.reset();
      showOtherAlertDialog("Error", "Some information went wrong please try again", context);
      print(error.toString());
    });
  }
}

class TimeObject {
  String time;
  bool isSelected;

  TimeObject(this.time, this.isSelected);
}

/*

customDayBuilder: (   /// you can provide your own build function to make custom day containers
            bool isSelectable,
            int index,
            bool isSelectedDay,
            bool isToday,
            bool isPrevMonthDay,
            TextStyle textStyle,
            bool isNextMonthDay,
            bool isThisMonthDay,
            DateTime day,
            ) {
          /// If you return null, [CalendarCarousel] will build container for current [day] with default function.
          /// This way you can build custom containers for specific days only, leaving rest as default.

          // Example: every 15th of month, we have a flight, we can place an icon in the container like that:
          if (day.day == 15) {
            return Center(
              child: Icon(Icons.local_airport),
            );
          } else {
            return null;
          }
        },

 */
