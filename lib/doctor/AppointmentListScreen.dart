import 'package:HealOnline/models/Appoitment.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants.dart';
import 'AppointmentDetailScreen.dart';

class AppointmentList extends StatefulWidget {
  AppointmentList({Key key}) : super(key: key);

  @override
  _AppointmentListState createState() => _AppointmentListState();
}

class _AppointmentListState extends State<AppointmentList> {
  bool isLoading = false;
  List<Appointment> users = List();

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
      itemCount: users.length + 1, // Add one more item for progress indicator
      padding: EdgeInsets.symmetric(vertical: 8.0),
      itemBuilder: (BuildContext context, int index) {
        if (index == users.length) {
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
                            builder: (context) => AppointmentDetail(users[index]),
                          ),
                        );
                      },
                      title: Text(
                        users[index].userName,
                        style: TextStyle(
                          fontFamily: "ProductSans",
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Constants.hexToColor(Constants.blackColor),
                        ),
                      ),
                      subtitle: Text(
                        users[index].appointmentDate.split(" ").first +" "+users[index].appointmentTime,
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
                        Padding(
                          padding: EdgeInsets.only(bottom: 16, top: 8),
                          child: Text(
                            "Next Appointment",
                            style: TextStyle(
                                fontFamily: "ProductSans",
                                fontSize: 14,
                                color: Colors.grey),
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
                            "Cancel",
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

  void getAppointments() {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });

      List<Appointment> _users = List();
      final databaseReference = FirebaseDatabase.instance.reference();

      databaseReference
          .child("appointments")
          .child("09007860101")
          .once()
          .then((DataSnapshot snapshot) {
        Map<dynamic, dynamic> values = snapshot.value;
        values.forEach((key, value) {
          print(value);

          _users.add(new Appointment(
            value["province"],
            value["symptoms"],
            value["howLongFelt"],
            value["covidYesNo"],
            value["covidLocation"],
            value["covidTimeTravel"],
            value["sickNote"],
            value["AudioOrVideo"],
            value["additionalDetails"],
            value["isImageAttached"],
            value["doctorPhone"],
            value["appointmentDate"],
            value["appointmentTime"],
            value["docName"],
            value["docSkills"],
            value["appointmentFor"],
            value["userId"],
            value["docId"],
            value["userName"],
            value["age"],
            value["weight"],
            value["height"],
            value["maritalStatus"],
            value["bloodGroup"],
            value["history"],
            value["gender"],
            value["userEmail"]
          ));

          setState(() {
            isLoading = false;
            users.addAll(_users);
          });

        });
      });
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