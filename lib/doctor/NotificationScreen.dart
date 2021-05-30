import 'package:HealOnline/localization/locale_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

class NotificationScreen extends StatefulWidget {
  NotificationScreen({Key key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
   List<String> appointmentStatus = <String>[
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

   List<String> appointmentDesc = <String>[
    'New Appointment is scheduled at 2020-02-30 03:00 PM with William James',
    'You hve cancelled an appointment with Robert Hudson',
    'Your Next Appointment schedule changed to 2020-02-30 02:00 PM with Hazel Grayson',
    'New Appointment is scheduled at 2020-02-30 05:00 PM with Miles Hunter',
    'You hve cancelled an appointment with John William',
    'Your Next Appointment schedule changed to 2020-02-30 06:00 PM with Miles Jackson',
  ];

   List<String> appointmentTimeAgo = <String>[
    '1 minute ago',
    '4 minutes ago',
    '10 minutes ago',
    '23 minutes ago',
    '4 hours ago',
    '1 day ago',
  ];





  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocale();
  }

  String savedCode;

  getLocale() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String languageCode = _prefs.getString(prefSelectedLanguageCode);

    if (languageCode != null) {
      savedCode = languageCode;
      //changeLanguage(context, "en", false);

      if (savedCode == "ar") {
        doMakeLangChanges();
      }
    }
  }



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: appointmentStatus.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
            padding: EdgeInsets.only(top: 8, bottom: 16),
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
    );
  }

  void doMakeLangChanges() {
    setState(() {


      appointmentStatus = <String>[
        'موعد جديد',
        'تم إلغاء الموعد',
        'تم تحديث الموعد',
        'موعد جديد',
        'تم إلغاء الموعد',
        'تم تحديث الموعد',
      ];

      appointmentDesc = <String>[
        'تم تحديد موعد جديد في 2020-02-30 03:00 مساءً مع الدكتور ويليام جيمس',
        'لقد ألغيت موعدًا مع دكتور روبرت هدسون',
        'تم تغيير جدول موعدك التالي إلى 2020-02-30 02:00 مساءً مع الدكتورة هازل جرايسون',
        'تم تحديد موعد جديد في 2020-02-30 05:00 مساءً مع الدكتور مايلز هنتر',
        'لقد ألغيت موعدًا مع دكتور جون ويليام',
        'تم تغيير جدول موعدك التالي إلى 2020-02-30 06:00 مساءً مع دكتور مايلز جاكسون',
      ];

      appointmentTimeAgo = <String>[
        '1 دقيقة متبقية',
        'منذ 4 دقيقة',
        '10 دقائق متبقية',
        'بقي 23 دقيقة',
        'قبل 4 ساعات',
        '6 ساعات متبقية',
      ];



    });
  }
}
