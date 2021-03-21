import 'dart:convert';
import 'dart:io';

import 'package:HealOnline/Utils.dart';
import 'package:HealOnline/models/UploadItem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants.dart';
import 'fragments/CompletedAppointmets.dart';
import 'fragments/UpcomingAppointments.dart';

class AppointmentDetail extends StatefulWidget {
  AppointmentUI appointment;

  AppointmentDetail(this.appointment, {Key key}) : super(key: key);

  @override
  _AppointmentDetailState createState() => _AppointmentDetailState();
}

class _AppointmentDetailState extends State<AppointmentDetail> {
  List<UploadItem> files = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getFilesFromDB(widget.appointment.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Padding(
            padding: EdgeInsets.only(left: 14),
            child: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Icon(Icons.arrow_back_ios,
                  color: Constants.hexToColor(Constants.whiteColor)),
            )),
        title: Text(
          "Appointment Detail",
          style: TextStyle(
              fontFamily: "ProductSans", fontSize: 22, color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Doctor Name",
                style: TextStyle(
                  fontFamily: "ProductSans",
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Constants.hexToColor(
                    Constants.primaryDarkColor,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Padding(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Text(
                widget.appointment.docName,
                style: TextStyle(
                  fontFamily: "ProductSans",
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                  color: Colors.black38,
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Divider(
                color: Constants.hexToColor(Constants.graySepratorColor),
                height: 1,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Doctor Speciality",
                style: TextStyle(
                  fontFamily: "ProductSans",
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Constants.hexToColor(
                    Constants.primaryDarkColor,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Padding(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Text(
                widget.appointment.docSpeciality,
                style: TextStyle(
                  fontFamily: "ProductSans",
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                  color: Colors.black38,
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Divider(
                color: Constants.hexToColor(Constants.graySepratorColor),
                height: 1,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Appointment Time",
                style: TextStyle(
                  fontFamily: "ProductSans",
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Constants.hexToColor(
                    Constants.primaryDarkColor,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Padding(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Text(
                widget.appointment.appointmentTime,
                style: TextStyle(
                  fontFamily: "ProductSans",
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                  color: Colors.black38,
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Divider(
                color: Constants.hexToColor(Constants.graySepratorColor),
                height: 1,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Appointment Date",
                style: TextStyle(
                  fontFamily: "ProductSans",
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Constants.hexToColor(
                    Constants.primaryDarkColor,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Padding(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Text(
                widget.appointment.appointmentDate,
                style: TextStyle(
                  fontFamily: "ProductSans",
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                  color: Colors.black38,
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Divider(
                color: Constants.hexToColor(Constants.graySepratorColor),
                height: 1,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Symptoms",
                style: TextStyle(
                  fontFamily: "ProductSans",
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Constants.hexToColor(
                    Constants.primaryDarkColor,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Padding(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Text(
                widget.appointment.symptoms,
                style: TextStyle(
                  fontFamily: "ProductSans",
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                  color: Colors.black38,
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Divider(
                color: Constants.hexToColor(Constants.graySepratorColor),
                height: 1,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Sick Note",
                style: TextStyle(
                  fontFamily: "ProductSans",
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Constants.hexToColor(
                    Constants.primaryDarkColor,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Padding(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Text(
                widget.appointment.sick_note,
                style: TextStyle(
                  fontFamily: "ProductSans",
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                  color: Colors.black38,
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Divider(
                color: Constants.hexToColor(Constants.graySepratorColor),
                height: 1,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Additional Details",
                style: TextStyle(
                  fontFamily: "ProductSans",
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Constants.hexToColor(
                    Constants.primaryDarkColor,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Padding(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Container(
                height: 120,
                width: MediaQuery.of(context).size.width,
                child: Text(
                  widget.appointment.additional_details,
                  style: TextStyle(
                    fontFamily: "ProductSans",
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                    color: Colors.black38,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Divider(
                color: Constants.hexToColor(Constants.graySepratorColor),
                height: 1,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Appointment For",
                style: TextStyle(
                  fontFamily: "ProductSans",
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Constants.hexToColor(
                    Constants.primaryDarkColor,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Padding(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Text(
                widget.appointment.appointment_for,
                style: TextStyle(
                  fontFamily: "ProductSans",
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                  color: Colors.black38,
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Divider(
                color: Constants.hexToColor(Constants.graySepratorColor),
                height: 1,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Attachments",
                style: TextStyle(
                  fontFamily: "ProductSans",
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Constants.hexToColor(
                    Constants.primaryDarkColor,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Container(
              height: 200,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: files.length + 1,
                  itemBuilder: (BuildContext context, int index) {
                    return index == files.length
                        ? Center(child: _buildProgressIndicator())
                        : Padding(
                            padding: EdgeInsets.only(top: 4, bottom: 4),
                            child: Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ListTile(
                                    onTap: () {
                                      if (files[index].link != null) {
                                        _launchURL(files[index].link);
                                      }
                                    },
                                    title: Padding(
                                      padding: EdgeInsets.only(top: 8),
                                      child: Text(
                                        files[index].title,
                                        style: TextStyle(
                                          fontFamily: "ProductSans",
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                          color: Constants.hexToColor(
                                              Constants.blackColor),
                                        ),
                                      ),
                                    ),
                                    subtitle: Padding(
                                      padding: EdgeInsets.only(top: 8),
                                      child: Text(
                                        files[index].date.split(" ").first,
                                        style: TextStyle(
                                          fontFamily: "ProductSans",
                                          fontSize: 14,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                    leading: Container(
                                      height: 38,
                                      width: 38,
                                      child: SvgPicture.asset(
                                        "assets/images/images.svg",
                                        color: Constants.hexToColor(
                                            Constants.primaryColor),
                                      ),
                                    ),
                                    trailing: Icon(
                                      Icons.arrow_forward_ios,
                                      color: Constants.hexToColor(
                                          Constants.primaryColor),
                                      size: 16,
                                    ),
                                  ),
                                ],
                              ),
                              //
                            ));
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> getFilesFromDB(int id) async {
    try {
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
        Response response = await get(url, headers: headers);
        String body = response.body;
        print(body);

        List<UploadItem> list = [];

        if (response.statusCode == 200) {
          List<dynamic> appointments = (json.decode(body))["appointments"];

          for (int i = 0; i < appointments.length; i++) {
            if (appointments[i]["id"].toString() == id.toString()) {
              List<dynamic> files = appointments[i]["appointment_files"];
              if (files != null && files.length > 0) {
                for (int i = 0; i < files.length; i++) {
                  UploadItem imgModel = UploadItem(
                      files[i]["type"],
                      files[i]["created_at"],
                      files[i]["name"],
                      files[i]["type"]);
                  list.add(imgModel);
                }
              }
            }
          }
        }

        setState(() {
          isLoading = false;
          files.clear();
          files.addAll(list);
        });
      }
    } catch (e) {}
  }

  Widget _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: isLoading ? 1.0 : 00,
          //opacity:1.0 ,
          child: new CircularProgressIndicator(),
        ),
      ),
    );
  }

  Future<void> _launchURL(String _url) async {
    await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
  }
}
