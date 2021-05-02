//UpcomingAppointments

import 'dart:convert';
import 'dart:io';

import 'package:HealOnline/Utils.dart';
import 'package:HealOnline/VideoCall/call.dart';
import 'package:HealOnline/models/Appoitment.dart';
import 'package:HealOnline/patient/AppointmentDetail.dart';
import 'package:HealOnline/patient/HomePagePatient.dart';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../constants.dart';

class UpcomingAppointments extends StatefulWidget {
  UpcomingAppointments({Key key}) : super(key: key);

  @override
  _UpcomingAppointmentsState createState() => _UpcomingAppointmentsState();
}

class _UpcomingAppointmentsState extends State<UpcomingAppointments> {
  final double circleRadius = 80.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUpcomingAppointments();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _buildList();
  }

  bool isLoading = false;
  List<AppointmentUI> appointments = [];

  Future<void> getUpcomingAppointments() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });

      String url = Utils.baseURL + Utils.GET_APPOINTMNETS;
      print(url);
      Map<String, String> headers = {
        "Content-type": "application/json",
        HttpHeaders.authorizationHeader: "Bearer " + Utils.user.token
      };
      Response response = await get(Uri.parse(url), headers: headers);
      String body = response.body;
      print(response.body);

      List<AppointmentUI> appointmentList = [];

      List mainStream = (json.decode(response.body))["appointments"];
      if(mainStream!= null && mainStream.isNotEmpty ){

        for(int i=0; i<mainStream.length; i++){
          AppointmentUI appointmentUI = new AppointmentUI();
          appointmentUI.docName = mainStream[i]["doctor"]["name"];

          List expStream = mainStream[i]["doctor"]["profile"]["experience"];
          if(expStream != null && expStream.isNotEmpty){
            appointmentUI.docSpeciality = expStream[0]["skills"].toString().split(",").first;
          }
          appointmentUI.id =  mainStream[i]["id"];
          appointmentUI.appointmentDate =  mainStream[i]["date"];
          appointmentUI.appointmentTime =  mainStream[i]["time"];
          appointmentUI.channelName = mainStream[i]["channel_name"];
          appointmentUI.videoToken = mainStream[i]["token"];
          appointmentUI.symptoms = mainStream[i]["symptoms"];
          appointmentUI.sick_note = mainStream[i]["sick_note"];
          appointmentUI.additional_details = mainStream[i]["additional_details"];
          appointmentUI.appointment_for = mainStream[i]["appointment_for"];

          if(!mainStream[i]["today"]) {
            appointmentList.add(appointmentUI);
          }

        }
      }

      setState(() {
        isLoading = false;
        if(appointmentList.isNotEmpty){
          appointments.clear();
        }
        appointments.addAll(appointmentList);
      });
    }
  }

  Widget _buildList() {
    return ListView.builder(

      itemCount: appointments.length + 1, // Add one more item for progress indicator
      padding: EdgeInsets.symmetric(vertical: 8.0),
      itemBuilder: (BuildContext context, int index) {
        if (index == appointments.length) {
          return Center(
            child: _buildProgressIndicator(),
          );
        }
        else {
          return Container(
            margin: EdgeInsets.all(16),
            height: 160,
            child: Material(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Stack(
                alignment: Alignment.topLeft,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 12),
                    child: ListTile(
                      onTap: (){
                        MyHomePageState.openAppointmentDetailScreen(appointments[index]);
                      },
                      isThreeLine: true,
                      leading: Container(
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
                              child: Image(
                                  image: AssetImage("assets/images/doctor.png")),

                              /// replace your image with the Icon
                            ),
                          ),
                        ),
                      ),
                      title: Text('Dr. '+appointments[index].docName,
                          style: TextStyle(
                              color: Constants.hexToColor(
                                Constants.primaryDarkColor,
                              ),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: "ProductSans")),
                      subtitle: Text(appointments[index].docSpeciality == null ? "GP" : appointments[index].docSpeciality,
                          style: TextStyle(
                              color: Constants.hexToColor(
                                Constants.primaryDarkColor,
                              ),
                              fontFamily: "ProductSans")),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 71, left: 112),
                    child: Text(
                      appointments[index].appointmentDate+" - "+appointments[index].appointmentTime,
                      style: TextStyle(
                          fontSize: 12,
                          fontFamily: "ProductSans",
                          color: Constants.hexToColor(
                            Constants.primaryDarkColor,
                          )),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 96, left: 8, right: 8),
                    child: Divider(),
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 112),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: (){
                              onJoin(appointments[index].channelName,appointments[index].videoToken);
                            },
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 16, top: 8),
                              child: Text(
                                "Call",
                                style: TextStyle(
                                    fontFamily: "ProductSans",
                                    fontSize: 16,
                                    color: Colors.grey),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 16, top: 8),
                            child: Container(
                              width: 1,
                              height: 22,
                              color: Constants.hexToColor(
                                  Constants.graySepratorColor),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 16, top: 8),
                            child: Text(
                              "Cancel",
                              style: TextStyle(
                                  fontFamily: "ProductSans",
                                  fontSize: 16,
                                  color: Colors.red),
                            ),
                          ),
                        ],
                      )),
                ],
              ),
            ),
          );
        }
      },

    );
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

  Future<void> onJoin(String channelName, String videoToken) async {
    await _handleCameraAndMic(Permission.camera);
    await _handleCameraAndMic(Permission.microphone);
    // push video page with given channel name
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CallPage(
            channelName: channelName,
            role: ClientRole.Broadcaster,
            token: videoToken
        ),
      ),
    );
  }
  Future<void> _handleCameraAndMic(Permission permission) async {
    final status = await permission.request();
    print(status);
  }

}


class AppointmentUI{
  String docName, docSpeciality, appointmentTime, appointmentDate, videoToken, channelName;
  String userName;
  int id;
  String patientId, gender, weight, height, maritalStatus, bloodGrp, phoneNum, lang;
  int age;
  String notes;
  String symptoms, sick_note, additional_details, appointment_for;
}