import 'dart:convert';
import 'dart:io';

import 'package:HealOnline/Utils.dart';
import 'package:HealOnline/localization/language/languages.dart';
import 'package:HealOnline/models/Appoitment.dart';
import 'package:HealOnline/models/UpdateAppointmentModel.dart';
import 'package:HealOnline/models/appointment_notes.dart';
import 'package:HealOnline/patient/fragments/UpcomingAppointments.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart';

import '../constants.dart';
import 'DoctorNotesScreen.dart';

class AppointmentDetail extends StatefulWidget {
  AppointmentUI user;

  AppointmentDetail(this.user, {Key key}) : super(key: key);

  @override
  _AppointmentDetailState createState() => _AppointmentDetailState(this.user);
}

class _AppointmentDetailState extends State<AppointmentDetail> {
  AppointmentUI user;
  TextEditingController notesController = TextEditingController();

  _AppointmentDetailState(this.user);

  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notesController.text = user.notes != null ? user.notes : "";
    getUser(widget.user.patientId);
  }

  var userGender = ["Male", "Female", "Other"];

  @override
  Widget build(BuildContext context) {
    //print(user.gender);
    return Scaffold(
      appBar: AppBar(
        elevation: 8,
        backgroundColor: Constants.hexToColor(Constants.whiteColor),
        leading: Padding(
            padding: EdgeInsets.all(19),
            child: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Icon(Icons.arrow_back_ios,
                  color: Constants.hexToColor(Constants.blackColor)),
            )),
        title: Text(Languages.of(context).appointment_detail,
            style: TextStyle(
                fontSize: 20,
                fontFamily: "ProductSans",
                color: Constants.hexToColor(Constants.blackColor))),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 36),
            Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundColor: Constants.hexToColor(
                      Constants.primaryDarkColor,
                    ),
                    radius: 40,
                    child: CircleAvatar(
                      radius: 38,
                      child: Image(
                        image: AssetImage(
                          "assets/images/user_avatar.png",
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    user.userName,
                    style: TextStyle(
                      fontFamily: "ProductSans",
                      fontSize: 16,
                      color: Constants.hexToColor(
                        Constants.primaryDarkColor,
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        user.gender != null ? user.gender : "-",
                        style: TextStyle(
                          fontFamily: "ProductSans",
                          fontSize: 15,
                          color: Constants.hexToColor(
                            Constants.blackColor,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Container(width: 1, height: 14, color: Colors.black26),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        user.age != null ? user.age.toString() + " Y" : "",
                        style: TextStyle(
                          fontFamily: "ProductSans",
                          fontSize: 15,
                          color: Constants.hexToColor(
                            Constants.blackColor,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Container(width: 1, height: 14, color: Colors.black26),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        user.lang != null ? user.lang.toString() : "",
                        style: TextStyle(
                          fontFamily: "ProductSans",
                          fontSize: 15,
                          color: Constants.hexToColor(
                            Constants.blackColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    height: 270,
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  Languages.of(context).weight,
                                  style: TextStyle(
                                    fontFamily: "ProductSans",
                                    fontSize: 15,
                                    color: Constants.hexToColor(
                                      Constants.primaryDarkColor,
                                    ),
                                  ),
                                ),
                                Text(
                                  user.weight != null
                                      ? user.weight + " lbps"
                                      : "-",
                                  style: TextStyle(
                                    fontFamily: "ProductSans",
                                    fontSize: 15,
                                    color: Constants.hexToColor(
                                      Constants.blackColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  Languages.of(context).height,
                                  style: TextStyle(
                                    fontFamily: "ProductSans",
                                    fontSize: 15,
                                    color: Constants.hexToColor(
                                      Constants.primaryDarkColor,
                                    ),
                                  ),
                                ),
                                Text(
                                  user.height != null
                                      ? user.height + " inches"
                                      : "-",
                                  style: TextStyle(
                                    fontFamily: "ProductSans",
                                    fontSize: 15,
                                    color: Constants.hexToColor(
                                      Constants.blackColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  Languages.of(context).marital_status,
                                  style: TextStyle(
                                    fontFamily: "ProductSans",
                                    fontSize: 15,
                                    color: Constants.hexToColor(
                                      Constants.primaryDarkColor,
                                    ),
                                  ),
                                ),
                                Text(
                                  user.maritalStatus != null
                                      ? user.maritalStatus
                                      : "-",
                                  style: TextStyle(
                                    fontFamily: "ProductSans",
                                    fontSize: 15,
                                    color: Constants.hexToColor(
                                      Constants.blackColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  Languages.of(context).blood_grp,
                                  style: TextStyle(
                                    fontFamily: "ProductSans",
                                    fontSize: 15,
                                    color: Constants.hexToColor(
                                      Constants.primaryDarkColor,
                                    ),
                                  ),
                                ),
                                Text(
                                  user.bloodGrp != null ? user.bloodGrp : "-",
                                  style: TextStyle(
                                    fontFamily: "ProductSans",
                                    fontSize: 15,
                                    color: Constants.hexToColor(
                                      Constants.blackColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  Languages.of(context).email_address_hint,
                                  style: TextStyle(
                                    fontFamily: "ProductSans",
                                    fontSize: 15,
                                    color: Constants.hexToColor(
                                      Constants.primaryDarkColor,
                                    ),
                                  ),
                                ),
                                Text(
                                  Utils.user.profile_obj.umeta_obj.user_email,
                                  style: TextStyle(
                                    fontFamily: "ProductSans",
                                    fontSize: 15,
                                    color: Constants.hexToColor(
                                      Constants.blackColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  Languages.of(context).phone_number,
                                  style: TextStyle(
                                    fontFamily: "ProductSans",
                                    fontSize: 15,
                                    color: Constants.hexToColor(
                                      Constants.primaryDarkColor,
                                    ),
                                  ),
                                ),
                                Text(
                                  user.phoneNum != null ? user.phoneNum : "-",
                                  style: TextStyle(
                                    fontFamily: "ProductSans",
                                    fontSize: 15,
                                    color: Constants.hexToColor(
                                      Constants.blackColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 12,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 22.0),
                    height: 70,
                    width: MediaQuery.of(context).size.width,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DoctorNotesScreen(user.id.toString()),
                          ),
                        );
                      },
                      child: Card(
                        elevation: 4,
                       margin: EdgeInsets.zero,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              Languages.of(context).appointment_presc,
                              style: TextStyle(
                                fontFamily: "ProductSans",
                                fontSize: 16,
                                color: Constants.hexToColor(
                                  Constants.primaryDarkColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 8),

                  Card(
                    elevation: 4,
                    margin: EdgeInsets.symmetric(horizontal: 22),
                    child: ExpansionTile(
                      tilePadding: EdgeInsets.only(left: 16.0, right: 16, top: 4),
                      childrenPadding: EdgeInsets.all(8),
                      title: Text(
                        Languages.of(context).notes,
                        style: TextStyle(
                          fontFamily: "ProductSans",
                          fontSize: 16,

                          color: Constants.hexToColor(
                            Constants.primaryDarkColor,
                          ),
                        ),
                      ),
                      children: <Widget>[
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Container(
                            padding: EdgeInsets.zero,
                            height: 100,
                            child:  TextFormField(textInputAction: TextInputAction.done,
                              style: TextStyle(
                                color: Colors.grey
                              ),
                              controller: notesController,
                              keyboardType: TextInputType.multiline,
                              maxLines: 4,
                              decoration: InputDecoration(
                                // prefixIcon: Icon(Icons.person_outline),
                                  border: OutlineInputBorder(),
                                  hintText: Languages.of(context).notes,
                                  hintStyle: TextStyle(fontFamily: "ProductSans")),
                            ),
                          ),
                        ),

                        SizedBox(height: 8,),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 40,
                          child: RaisedButton(
                            color: Constants.hexToColor(Constants.primaryColor),
                            onPressed: (){
                              updateNotes();
                            },
                            child: Text(Languages.of(context).update_notes, style: TextStyle(color: Colors.white),),
                          ),
                        ),

                      ],
                    ),
                  ),


                  SizedBox(height: 20),
                  InkWell(
                    onTap: (){

                      showAppointmentDateAndTime();

                    },
                    child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 20.0),
                        height: 54,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Constants.hexToColor(
                                Constants.primaryDarkColor,
                              ),
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            Languages.of(context).next_appointment,
                            style: TextStyle(
                              fontFamily: "ProductSans",
                              fontSize: 18,
                              color: Constants.hexToColor(
                                Constants.primaryDarkColor,
                              ),
                            ),
                          ),
                        )),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> getUser(String patientId) async {
    String url =
        Utils.baseURL + Utils.GET_PATIENT_WITH_ID + patientId.toString();
    print(url);
    Map<String, String> headers = {
      "Content-type": "application/json",
      HttpHeaders.authorizationHeader: "Bearer " + Utils.user.token
    };
    Response response = await get(Uri.parse(url), headers: headers);
    String body = response.body;
    print(response.body);

    if (response.statusCode == 200) {
      var mainStream = (json.decode(response.body))["patient"]["profile"];
      if (mainStream != null) {
        setState(() {
          user.age = mainStream["age"];
          user.weight = mainStream["weight"];
          user.height = mainStream["height"];
          user.maritalStatus = mainStream["martial_status"];
          user.bloodGrp = mainStream["blood_group"];
          user.phoneNum = mainStream["mobile"];
          user.lang = mainStream["language"];
          if (mainStream["gender"] != null) {
            if (mainStream["gender"] == "male") {
              user.gender = userGender[0];
            } else {
              user.gender = userGender[1];
            }
          }
        });
      }
    }
  }


  var periods = ["am", "pm"];

  void showAppointmentDateAndTime() {

    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            height: 300,
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                SizedBox(
                  height: 24,
                ),

                Text(
                  Languages.of(context).select_next_schedual,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: Constants.hexToColor(Constants.primaryDarkColor)
                  ),
                ),

                SizedBox(
                  height: 16,
                ),

                 TextFormField(
                  textInputAction: TextInputAction.done,
                  onTap: () async {
                    final DateTime picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2025),
                    );

                    setState(() {
                      dateController.text = picked.toLocal().toString().split(' ')[0];
                    });
                  },
                  readOnly: true,
                  key: Key('Date'),
                  controller: dateController,
                  decoration: InputDecoration(
                    //prefixIcon: Icon(Icons.person_outline),
                    //suffixIcon: Icon(Icons.arrow_forward_ios, size: 8,),
                      border: OutlineInputBorder(),
                      hintText: Languages.of(context).appointment_date,
                      hintStyle: TextStyle(fontFamily: "ProductSans")),
                ),

                SizedBox(
                  height: 10,
                ),

                 TextFormField(textInputAction: TextInputAction.done,
                  onTap: () async {

                    final selectedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                    );

                    setState(() {
                      timeController.text = selectedTime.hour.toString()+":"+selectedTime.minute.toString()+" "+periods[selectedTime.period.index];
                    });

                  },
                  readOnly: true,
                  key: Key('Time'),
                  controller: timeController,
                  decoration: InputDecoration(
                    //prefixIcon: Icon(Icons.person_outline),
                    //suffixIcon: Icon(Icons.arrow_forward_ios, size: 8,),
                      border: OutlineInputBorder(),
                      hintText: Languages.of(context).appointment_time,
                      hintStyle: TextStyle(fontFamily: "ProductSans")),
                ),


                SizedBox(
                  height: 24,
                ),

                Container(
                  padding: EdgeInsets.only(bottom: 8),
                  height: 48,
                  width: MediaQuery.of(context).size.width-16,
                  child: RaisedButton(
                    onPressed: (){

                      updateAppointment();
                    },
                    child: Text(Languages.of(context).submit,),
                    textColor: Colors.white,
                    color: Constants.hexToColor(Constants.primaryDarkColor),
                  ),
                ),


              ],
            ),
          );
        });

  }

  Future<void> updateAppointment() async {

    if(dateController.text == "" || timeController.text == ""){
          showAlertDialog(Languages.of(context).error_string, Languages.of(context).require_both_time_and_date, context);
          return;
    }else{
      Navigator.pop(context);
      UpdateAppointment updateAppointment = new UpdateAppointment(
        date: dateController.text, status: "2", time: timeController.text
      );
      String url = Utils.baseURL + Utils.UPDATE_APPOINTMENT+ user.id.toString();
      print (url);

      String jsonUser = jsonEncode(updateAppointment);
      Map<String, String> headers = {
        "Content-type": "application/json",
        HttpHeaders.authorizationHeader: "Bearer " + Utils.user.token
      };
      Response response = await post(Uri.parse(url), headers: headers, body: jsonUser);
      int statusCode = response.statusCode;


      print(jsonUser);
      print(response.body);

      if (statusCode == 200) {
        showAlertDialog(Languages.of(context).success, Languages.of(context).appointment_updated, context);

      } else {
        showAlertDialog(
            Languages.of(context).error_string, Languages.of(context).something_went_wrong, context);
      }


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
              child: Text(Languages.of(context).ok,
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

  Future<void> updateNotes() async {
    //notesController

    AppointmentNotes appointmentNotes = new AppointmentNotes(notes: notesController.text.toString());
    String url = Utils.baseURL + Utils.UPDATE_NOTES+user.id.toString();
    String jsonUser = jsonEncode(appointmentNotes);
    Map<String, String> headers = {
      "Content-type": "application/json",
      HttpHeaders.authorizationHeader: "Bearer " + Utils.user.token
    };
    Response response = await post(Uri.parse(url), headers: headers, body: jsonUser);
    int statusCode = response.statusCode;

    print(url);
    print(jsonUser);
    print(response.body);

    if (statusCode == 200){
      showAlertDialog(Languages.of(context).success, Languages.of(context).notes_updated, context);
    }else{
      showAlertDialog(Languages.of(context).error_string, Languages.of(context).something_went_wrong, context);
    }


  }


}
