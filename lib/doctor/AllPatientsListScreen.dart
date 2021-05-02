import 'dart:convert';
import 'dart:io';

import 'package:HealOnline/Utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart';

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

  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPatients();
  }

  @override
  Widget build(BuildContext context) {
    return _buildList();
  }

  List<dynamic> patientsList = [];

  Future<void> getPatients() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });

      String url = Utils.baseURL + Utils.GET_PATIENTS;
      print(url);
      Map<String, String> headers = {
        "Content-type": "application/json",
        HttpHeaders.authorizationHeader: "Bearer " + Utils.user.token
      };

      Response response = await get(Uri.parse(url), headers: headers);
      String body = response.body;
      print(response.body);

      if (response.statusCode == 200) {
        if (response.body != null) {
          List patientList = (json.decode(response.body))["patients"];
          setState(() {
            isLoading = false;
            if (patientList.isNotEmpty) {
              patientsList.clear();
            }
            patientsList.addAll(patientList);
          });
        }
      } else {
        setState(() {
          patientsList.clear();
        });
      }
    }
  }

  Widget _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: isLoading ? 1.0 : 00,
          child: new CircularProgressIndicator(),
        ),
      ),
    );
  }

  Widget _buildList() {
    return ListView.builder(
      itemCount: patientsList.length + 1,
      // Add one more item for progress indicator
      padding: EdgeInsets.symmetric(vertical: 8.0),
      itemBuilder: (BuildContext context, int index) {
        if (index == patientsList.length) {
          return Center(
            child: _buildProgressIndicator(),
          );
        } else {
          return Container(
            height: 100,
            width: MediaQuery.of(context).size.width - 16,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Material(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 8,
              child: ListTile(
                title: Text(
                  patientsList[index]["name"],
                  style: TextStyle(
                    fontFamily: "ProductSans",
                    fontSize: 18,
                  ),
                ),
                subtitle: Text(
                  patientsList[index]["email"],
                  style: TextStyle(
                    fontFamily: "ProductSans",
                    fontSize: 14,
                  ),
                ),
                leading: SvgPicture.asset(
                  "assets/images/user_avatar.svg",
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
