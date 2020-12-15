import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants.dart';

class AllPatientListScreen extends StatefulWidget {
  AllPatientListScreen({Key key}) : super(key: key);

  @override
  _AllPatientListScreenState createState() => _AllPatientListScreenState();
}

class _AllPatientListScreenState extends State<AllPatientListScreen> {
  final List<String> patientsName = <String>[
    'John William',
    'Harper Jackson',
    'Hazel Grayson',
    'Robert Hudson',
    'Miles Hunter',
    'Miles Jackson',
    'William James',
  ];
  final List<String> patientsLocation = <String>[
    'Ontario',
    'Bancroft',
    'Iroquois Falls',
    'Ottawa',
    'Sarnia-Clearwater',
    'Toronto',
    'Chambly',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: patientsName.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  leading: SvgPicture.asset(
                    "assets/images/user_avatar.svg",
                  ),
                  title: Text(
                    patientsName[index],
                    style: TextStyle(
                      fontFamily: "ProductSans",
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Constants.hexToColor(Constants.blackColor),
                    ),
                  ),
                  subtitle: Text(
                    patientsLocation[index],
                    style: TextStyle(
                      fontFamily: "ProductSans",
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Constants.hexToColor(Constants.graySepratorColor),),
                ),
              ),
            );
          }),
    );
  }
}
