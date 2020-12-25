import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class PatientNotifications extends StatefulWidget {
  PatientNotifications({Key key}) : super(key: key);

  @override
  _PatientNotificationsState createState() => _PatientNotificationsState();
}

class _PatientNotificationsState extends State<PatientNotifications> {

  final List<String> appointmentStatus = <String>[
    'New Appointment',
    'Appointment Cancelled',
    'Appointment Updated',
    'New Appointment',
    'Appointment Cancelled',
    'Appointment Updated',
  ];

  final List<String> appointmentStatusIcon = <String>[
    "assets/images/check.png",
    "assets/images/close.png",
    "assets/images/check.png",
    "assets/images/check.png",
    "assets/images/close.png",
    "assets/images/check.png",
  ];

  final List<String> appointmentDesc = <String>[
    'New Appointment is scheduled at 2020-02-30 03:00 PM with Dr. William James',
    'You hve cancelled an appointment with Dr. Robert Hudson',
    'Your Next Appointment schedule changed to 2020-02-30 02:00 PM with Dr. Hazel Grayson',
    'New Appointment is scheduled at 2020-02-30 05:00 PM with Dr. Miles Hunter',
    'You hve cancelled an appointment with Dr. John William',
    'Your Next Appointment schedule changed to 2020-02-30 06:00 PM with Dr. Miles Jackson',
  ];

  final List<String> appointmentTimeAgo = <String>[
    '1 minute left',
    '4 minutes ago',
    '10 minutes left',
    '23 minutes left',
    '4 hours ago',
    '6 hours left',
  ];


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        elevation: 8,
        backgroundColor: Constants.hexToColor(Constants.whiteColor),
        title: Padding(
          padding: EdgeInsets.only(left:8),
          child: Text(
            "Notifications",
            style: TextStyle(
              fontFamily: "ProductSans",
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Constants.hexToColor(
                Constants.primaryDarkColor,
              ),
            ),
          ),
        )
      ),
      body:ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: appointmentStatus.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
              padding: EdgeInsets.only(top: 8, bottom: 8),
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      onTap: () {},
                      title: Padding(
                        padding: EdgeInsets.only(top: 8),
                        child: Text(
                          appointmentStatus[index],
                          style: TextStyle(
                            fontFamily: "ProductSans",
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Constants.hexToColor(Constants.blackColor),
                          ),
                        ),
                      ),
                      subtitle: Padding(
                        padding: EdgeInsets.only(top: 8),
                        child: Text(
                          appointmentDesc[index],
                          style: TextStyle(
                            fontFamily: "ProductSans",
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      leading: CircleAvatar(
                        radius: 23,
                        backgroundColor:
                        Constants.hexToColor(Constants.primaryDarkColor),
                        child: CircleAvatar(
                          radius: 19,
                          backgroundColor:
                          Constants.hexToColor(Constants.whiteColor),
                          child: Padding(
                            padding: EdgeInsets.all(9),
                            child: Image(
                              image: AssetImage(appointmentStatusIcon[index],),
                              color: Constants.hexToColor(Constants.primaryColor),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 16, top: 8, right: 8),
                        child: Text(
                          appointmentTimeAgo[index],
                          style: TextStyle(
                              fontFamily: "ProductSans",
                              fontSize: 14,
                              color: Colors.grey),
                        ),
                      ),
                    )
                  ],
                ),
                //
              ));
        },
      ),
    );
  }

}