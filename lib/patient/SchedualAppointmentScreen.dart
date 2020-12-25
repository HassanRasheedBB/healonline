import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import '../constants.dart';

class SchedualAppointmentScreen extends StatefulWidget {
  SchedualAppointmentScreen({Key key}) : super(key: key);

  @override
  _SchedualAppointmentScreenState createState() =>
      _SchedualAppointmentScreenState();
}

class _SchedualAppointmentScreenState extends State<SchedualAppointmentScreen> {
  final double circleRadius = 70.0;
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
              title: Text("Dr. David Jones",
                  style: TextStyle(
                    fontFamily: "ProductSans",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Constants.hexToColor(
                      Constants.primaryDarkColor,
                    ),
                  )),
              subtitle: Text("Therapist",
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
                  children: List.generate(time.length, (index) {
                    return Container(
                      height: 40,
                      child: Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          side: new BorderSide(color: Colors.blue, width: 1.0),
                          borderRadius: BorderRadius.circular(6.0),
                        ),
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
                    );
                  }),
                )),
            SizedBox(height: 24),


            Container(
              height: 50,
              margin: EdgeInsets.only(right: 16, left: 16, bottom: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Constants.hexToColor(Constants.primaryDarkColor),
              ),
              child: FlatButton(
                onPressed: () {

                },
                child: Center(
                  child: Text('CONFIRM APPOINTMENT',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: "ProductSans")),
                ),
              ),
            ),

          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }

  DateTime _currentDate = DateTime(2020, 12, 31);

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
          this.setState(() => _currentDate = date);
        },
        weekendTextStyle: TextStyle(
          fontFamily: "ProductSans",
          color: Constants.hexToColor(
            Constants.blackColor,
          ),
        ),
        thisMonthDayBorderColor: Constants.hexToColor(
          Constants.primaryDarkColor,
        ),
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
