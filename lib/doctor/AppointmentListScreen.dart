import 'dart:convert';
import 'dart:io';

import 'package:HealOnline/Utils.dart';
import 'package:HealOnline/VideoCall/call.dart';
import 'package:HealOnline/localization/language/languages.dart';
import 'package:HealOnline/models/Appoitment.dart';
import 'package:HealOnline/patient/fragments/UpcomingAppointments.dart';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart';
import 'package:permission_handler/permission_handler.dart';

import '../constants.dart';
import 'AppointmentDetailScreen.dart';

class AppointmentList extends StatefulWidget {
  AppointmentList({Key key}) : super(key: key);

  @override
  _AppointmentListState createState() => _AppointmentListState();
}

class _AppointmentListState extends State<AppointmentList> {
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAppointments();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _buildList();
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
        } else {
          return Padding(
              padding: EdgeInsets.only(top: 8, bottom: 16, right: 16, left: 16),
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
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AppointmentDetail(appointments[index]),
                          ),
                        );
                      },
                      title: Text(
                        appointments[index].userName,
                        style: TextStyle(
                          fontFamily: "ProductSans",
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Constants.hexToColor(Constants.blackColor),
                        ),
                      ),
                      subtitle: Text(
                        appointments[index].appointmentDate.split(" ").first +" "+appointments[index].appointmentTime,
                        style: TextStyle(
                          fontFamily: "ProductSans",
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      leading: SvgPicture.asset(
                        "assets/images/user_avatar.svg",
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Divider(
                        color:
                        Constants.hexToColor(Constants.graySepratorColor),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: (){
                            getToken(appointments[index].channelName);
                            //onJoin(appointments[index].channelName,appointments[index].videoToken);
                          },
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 16, top: 8),
                            child: Text(
                              Languages.of(context).call,
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
                            height: 20,
                            color: Constants.hexToColor(
                                Constants.graySepratorColor),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 16, top: 8),
                          child: Text(
                            Languages.of(context).cancel,
                            style: TextStyle(
                                fontFamily: "ProductSans",
                                fontSize: 14,
                                color: Colors.grey),
                          ),
                        ),
                      ],
                    )
                  ],
                ),

                //
              ));
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

  List<AppointmentUI> appointments = [];

  Future<void> getAppointments() async {
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
          appointmentUI.id = mainStream[i]["id"];
          appointmentUI.patientId = mainStream[i]["patient_id"];
          appointmentUI.userName = mainStream[i]["user"]["name"];
          appointmentUI.appointmentDate =  mainStream[i]["date"];
          appointmentUI.appointmentTime =  mainStream[i]["time"];
          appointmentUI.channelName = mainStream[i]["channel_name"];
          appointmentUI.videoToken = mainStream[i]["token"];
          appointmentUI.notes = mainStream[i]["notes"];

          appointmentList.add(appointmentUI);
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

  Future<void> getToken(String channelName) async {

    String url = Utils.baseURL + Utils.GET_TOKEN + channelName;
    print(url);
    Map<String, String> headers = {
      "Content-type": "application/json",
      HttpHeaders.authorizationHeader: "Bearer " + Utils.user.token
    };
    Response response = await get(Uri.parse(url), headers: headers);
    String body = response.body;
    print(response.body);

    if(response.statusCode == 200){
      String token = (json.decode(response.body))["token"];
      onJoin(channelName, token);
    }else{

    }

  }

}




/*

Appointment(
            values["province"],
            values["symptoms"],
            values["howLongFelt"],
            values["covidYesNo"],
            values["covidLocation"],
            values["covidTimeTravel"],
            values["sickNote"],
            values["AudioOrVideo"],
            values["additionalDetails"],
            values["isImageAttached"],
            values["doctorPhone"],
            values["appointmentDate"],
            values["appointmentTime"],
            values["docName"],
            values["docSkills"],
            values["appointmentFor"],
            values["userId"],
            values["docId"],
            values["userName"],
          )

 */