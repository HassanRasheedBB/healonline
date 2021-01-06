import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:healonline/models/RegisterDoctor.dart';

import '../constants.dart';
import 'PhysicianInformtion.dart';
import 'SchedualAppointmentScreen.dart';

class DoctorsFoundScreen extends StatefulWidget {
  DoctorsFoundScreen({Key key}) : super(key: key);

  @override
  _DoctorsFoundScreenState createState() => _DoctorsFoundScreenState();
}

class _DoctorsFoundScreenState extends State<DoctorsFoundScreen> {
  final double circleRadius = 70.0;
  int listCount = 3;
  var speciallity = ["GP", "Medicine", "Therapist"];

  bool selected = false;
  bool selected2 = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDoctors();
  }

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
        title: Text("Select Physician",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: "ProductSans",
                color: Constants.hexToColor(Constants.primaryDarkColor))),
      ),
      body: _buildList(),

      bottomNavigationBar:  Container(
        height: 50,
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(6)),
          color: Constants.hexToColor(Constants.primaryDarkColor),
        ),
        child: FlatButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => SchedualAppointmentScreen(),
              ),
            );
          },
          child: Center(
            child: Text('CONFIRM',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: "ProductSans")),
          ),
        ),
      ),
    );
  }

  List<RegisterUser> users = List();
  bool isLoading = false;

  void getDoctors() {

    if (!isLoading) {
      setState(() {
        isLoading = true;
      });

      List<RegisterUser> _users = List();
      final databaseReference = FirebaseDatabase.instance.reference();
      databaseReference
          .child("users")
          .child("health provider")
          .once()
          .then((DataSnapshot snapshot) {
        //print('Data : ${snapshot.value}');

        Map<dynamic, dynamic> values = snapshot.value;
        values.forEach((key, values) {
          //print(key+" , "+values["lName"]);
          _users.add(new RegisterUser(
              values["userType"],
              values["fname"],
              values["lName"],
              values["dob"],
              values["gender"],
              values["lanuage"],
              values["email"],
              values["contact_number"],
              values["password"],
              values["confirm_password"],
              values["pharmacy"],
              values["pharmacyPhone"],
              values["pharmacyCell"],
              values["healthCardProvince"],
              values["helthCardNo"],
              values["insuranceProvider"],
              values["insurancePolicyNumber"],
              values["appointmentTimes"],
              values["appointmentDays"],
              values["rating"],
              values["location"],
              values["skills"],
              values["patientsCount"],
              values["appointmentsCount"],
              values["PMDC"],
              values["experience"],
              values["reviewerName"],
              values["reviwerComment"],
              values["reviewerRating"],
              values["reviewTimeAgo"]));
        });

        setState(() {
          isLoading = false;
          users.addAll(_users);
        });
      });
    }
  }

  RegisterUser selectedDoctor;

  Widget _buildList() {
    return ListView.builder(

      itemCount: users.length + 1, // Add one more item for progress indicator
      padding: EdgeInsets.symmetric(vertical: 8.0),
      itemBuilder: (BuildContext context, int index) {

        if (index == users.length) {
          return Center(
            child: _buildProgressIndicator(),
          );
        }
        else{
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: InkWell(

              onTap: (){
                setState(() {
                  //users[index].selected = true;
                  for(int i=0; i<users.length; i++){
                    if(i == index){
                      users[i].selected = true;
                      Constants.appointment.doctorPhone =  users[i].contact_number;
                      Constants.appointment.docName =  "Dr. "+users[i].fname+" "+users[i].lName;
                      Constants.appointment.docSkills =  users[i].skills;
                    }else{
                      users[i].selected = false;
                    }
                  }
                });
              },

              child: Material(
                elevation: 8,

                shape: users[index].selected
                    ? new RoundedRectangleBorder(
                    side: new BorderSide(color: Constants.hexToColor(Constants.primaryDarkColor), width: 1.5),
                    borderRadius: BorderRadius.circular(12.0))
                    : new RoundedRectangleBorder(
                    side: new BorderSide(color: Colors.white, width: 1.5),
                    borderRadius: BorderRadius.circular(12.0)),

                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 220,
                  child: Stack(
                    alignment: Alignment.topLeft,
                    children: [
                      Container(
                        margin: EdgeInsets.all(12),
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
                      Padding(
                        padding: EdgeInsets.only(left: 95, top: 24),
                        child: Text("Dr. "+users[index].fname+" "+users[index].lName,
                            style: TextStyle(
                              fontFamily: "ProductSans",
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Constants.hexToColor(
                                Constants.primaryDarkColor,
                              ),
                            )),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 95, top: 48),
                        child: Text("Available today at "+users[index].appointmentTimes.split(" ").first+"\n"+
                            users[index].appointmentTimes.split(" ").last,
                            style: TextStyle(
                              fontFamily: "ProductSans",
                              fontSize: 16,
                              //fontWeight: FontWeight.bold,
                              color: Constants.hexToColor(
                                Constants.primaryColor,
                              ),
                            )),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 20, top: 86),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(
                                CupertinoIcons.location,
                                size: 18,
                                color: Constants.hexToColor(
                                  Constants.primaryDarkColor,
                                ),
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text(users[index].location,
                                  style: TextStyle(
                                    fontFamily: "ProductSans",
                                    fontSize: 14,
                                    //fontWeight: FontWeight.bold,
                                    color: Constants.hexToColor(
                                      Constants.primaryDarkColor,
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 12, top: 124),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            height: 40,
                            width: MediaQuery.of(context).size.width - 120,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: speciallity.length,
                              itemBuilder: (ctx, index) {
                                return Card(
                                  elevation: 2,
                                  shape: RoundedRectangleBorder(
                                    side: new BorderSide(
                                        color: Constants.hexToColor(Constants.primaryDarkColor), width: 1.0),
                                    borderRadius: BorderRadius.circular(6.0),
                                  ),
                                  child: Container(
                                    height: 40,
                                    width: 110,
                                    child: Center(
                                      child: Text(speciallity[index],
                                          style: TextStyle(
                                              color: Constants.hexToColor(
                                                Constants.primaryDarkColor,
                                              ),
                                              fontSize: 14,
                                              fontFamily: "ProductSans")),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 20, bottom: 18),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: InkWell(
                            onTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PhysicianInformtion(),
                                ),
                              );
                            },
                            child: Text("View Details",
                                style: TextStyle(
                                  fontFamily: "ProductSans",
                                  fontSize: 18,
                                  //fontWeight: FontWeight.bold,
                                  color: Constants.hexToColor(
                                    Constants.primaryColor,
                                  ),
                                )),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 78, top: 184),
                        child: Text("Language: "+users[index].lanuage,
                            style: TextStyle(
                              fontFamily: "ProductSans",
                              fontSize: 12,
                              //fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            )),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 95, top: 88),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              CupertinoIcons.star_fill,
                              size: 16,
                              color: Constants.hexToColor(
                                Constants.primaryDarkColor,
                              ),
                            ),
                            SizedBox(width: 4,),
                            Padding(
                              padding: EdgeInsets.only(top:4),
                              child: Text(users[index].rating,
                                  style: TextStyle(
                                    fontFamily: "ProductSans",
                                    fontSize: 16,
                                    //fontWeight: FontWeight.bold,
                                    color: Constants.hexToColor(
                                      Constants.primaryDarkColor,
                                    ),
                                  )),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
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

}

/*



Padding(
                   padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                   child: InkWell(

                     onTap: (){
                       setState(() {
                         selected = true;
                         selected2 = false;
                       });
                     },

                     child: Material(
                       elevation: 8,

                       shape: selected
                           ? new RoundedRectangleBorder(
                           side: new BorderSide(color: Colors.blue, width: 1.5),
                           borderRadius: BorderRadius.circular(12.0))
                           : new RoundedRectangleBorder(
                           side: new BorderSide(color: Colors.white, width: 1.5),
                           borderRadius: BorderRadius.circular(12.0)),

                       child: Container(
                         width: MediaQuery.of(context).size.width,
                         height: 220,
                         child: Stack(
                           alignment: Alignment.topLeft,
                           children: [
                             Container(
                               margin: EdgeInsets.all(12),
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
                             Padding(
                               padding: EdgeInsets.only(left: 95, top: 24),
                               child: Text("Dr. David Jones",
                                   style: TextStyle(
                                     fontFamily: "ProductSans",
                                     fontSize: 18,
                                     fontWeight: FontWeight.bold,
                                     color: Constants.hexToColor(
                                       Constants.primaryDarkColor,
                                     ),
                                   )),
                             ),
                             Padding(
                               padding: EdgeInsets.only(left: 95, top: 48),
                               child: Text("Available today at 11:00\nAM",
                                   style: TextStyle(
                                     fontFamily: "ProductSans",
                                     fontSize: 16,
                                     //fontWeight: FontWeight.bold,
                                     color: Constants.hexToColor(
                                       Constants.primaryColor,
                                     ),
                                   )),
                             ),
                             Padding(
                               padding: EdgeInsets.only(right: 20, top: 86),
                               child: Align(
                                 alignment: Alignment.topRight,
                                 child: Row(
                                   crossAxisAlignment: CrossAxisAlignment.center,
                                   mainAxisAlignment: MainAxisAlignment.end,
                                   children: [
                                     Icon(
                                       CupertinoIcons.location,
                                       size: 18,
                                       color: Constants.hexToColor(
                                         Constants.primaryDarkColor,
                                       ),
                                     ),
                                     SizedBox(
                                       width: 4,
                                     ),
                                     Text("Ontario",
                                         style: TextStyle(
                                           fontFamily: "ProductSans",
                                           fontSize: 14,
                                           //fontWeight: FontWeight.bold,
                                           color: Constants.hexToColor(
                                             Constants.primaryDarkColor,
                                           ),
                                         )),
                                   ],
                                 ),
                               ),
                             ),
                             Padding(
                               padding: EdgeInsets.only(right: 12, top: 124),
                               child: Align(
                                 alignment: Alignment.topRight,
                                 child: Container(
                                   height: 40,
                                   width: MediaQuery.of(context).size.width - 120,
                                   child: ListView.builder(
                                     scrollDirection: Axis.horizontal,
                                     shrinkWrap: true,
                                     itemCount: speciallity.length,
                                     itemBuilder: (ctx, index) {
                                       return Card(
                                         elevation: 2,
                                         shape: RoundedRectangleBorder(
                                           side: new BorderSide(
                                               color: Colors.blue, width: 1.0),
                                           borderRadius: BorderRadius.circular(6.0),
                                         ),
                                         child: Container(
                                           height: 40,
                                           width: 110,
                                           child: Center(
                                             child: Text(speciallity[index],
                                                 style: TextStyle(
                                                     color: Constants.hexToColor(
                                                       Constants.primaryDarkColor,
                                                     ),
                                                     fontSize: 14,
                                                     fontFamily: "ProductSans")),
                                           ),
                                         ),
                                       );
                                     },
                                   ),
                                 ),
                               ),
                             ),
                             Padding(
                               padding: EdgeInsets.only(right: 20, bottom: 18),
                               child: Align(
                                 alignment: Alignment.bottomRight,
                                 child: InkWell(
                                   onTap: (){
                                     Navigator.push(
                                       context,
                                       MaterialPageRoute(
                                         builder: (context) => PhysicianInformtion(),
                                       ),
                                     );
                                   },
                                   child: Text("View Details",
                                       style: TextStyle(
                                         fontFamily: "ProductSans",
                                         fontSize: 18,
                                         //fontWeight: FontWeight.bold,
                                         color: Constants.hexToColor(
                                           Constants.primaryColor,
                                         ),
                                       )),
                                 ),
                               ),
                             ),
                             Padding(
                               padding: EdgeInsets.only(left: 78, top: 184),
                               child: Text("Language: English",
                                   style: TextStyle(
                                     fontFamily: "ProductSans",
                                     fontSize: 12,
                                     //fontWeight: FontWeight.bold,
                                     color: Colors.grey,
                                   )),
                             ),
                             Padding(
                               padding: EdgeInsets.only(left: 95, top: 88),
                               child: Row(
                                 mainAxisAlignment: MainAxisAlignment.start,
                                 crossAxisAlignment: CrossAxisAlignment.center,
                                 children: [
                                   Icon(
                                     CupertinoIcons.star_fill,
                                     size: 16,
                                     color: Constants.hexToColor(
                                       Constants.primaryDarkColor,
                                     ),
                                   ),
                                   SizedBox(width: 4,),
                                   Padding(
                                     padding: EdgeInsets.only(top:4),
                                     child: Text("4.5",
                                         style: TextStyle(
                                           fontFamily: "ProductSans",
                                           fontSize: 16,
                                           //fontWeight: FontWeight.bold,
                                           color: Constants.hexToColor(
                                             Constants.primaryDarkColor,
                                           ),
                                         )),
                                   )
                                 ],
                               ),
                             ),
                           ],
                         ),
                       ),
                     ),
                   ),
                 ),

                 Padding(
                   padding: EdgeInsets.only(right: 16, left:16),
                   child: InkWell(

                     onTap: (){
                       setState(() {
                         selected2 = true;
                         selected = false;
                       });
                     },

                     child: Material(
                       elevation: 8,

                       shape: selected2
                           ? new RoundedRectangleBorder(
                           side: new BorderSide(color: Colors.blue, width: 1.5),
                           borderRadius: BorderRadius.circular(12.0))
                           : new RoundedRectangleBorder(
                           side: new BorderSide(color: Colors.white, width: 1.5),
                           borderRadius: BorderRadius.circular(12.0)),

                       child: Container(
                         width: MediaQuery.of(context).size.width,
                         height: 220,
                         child: Stack(
                           alignment: Alignment.topLeft,
                           children: [
                             Container(
                               margin: EdgeInsets.all(12),
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
                             Padding(
                               padding: EdgeInsets.only(left: 95, top: 24),
                               child: Text("Dr. Liz Haynes",
                                   style: TextStyle(
                                     fontFamily: "ProductSans",
                                     fontSize: 18,
                                     fontWeight: FontWeight.bold,
                                     color: Constants.hexToColor(
                                       Constants.primaryDarkColor,
                                     ),
                                   )),
                             ),
                             Padding(
                               padding: EdgeInsets.only(left: 95, top: 48),
                               child: Text("Available today at 09:00\nAM",
                                   style: TextStyle(
                                     fontFamily: "ProductSans",
                                     fontSize: 16,
                                     //fontWeight: FontWeight.bold,
                                     color: Constants.hexToColor(
                                       Constants.primaryColor,
                                     ),
                                   )),
                             ),
                             Padding(
                               padding: EdgeInsets.only(right: 20, top: 86),
                               child: Align(
                                 alignment: Alignment.topRight,
                                 child: Row(
                                   crossAxisAlignment: CrossAxisAlignment.center,
                                   mainAxisAlignment: MainAxisAlignment.end,
                                   children: [
                                     Icon(
                                       CupertinoIcons.location,
                                       size: 18,
                                       color: Constants.hexToColor(
                                         Constants.primaryDarkColor,
                                       ),
                                     ),
                                     SizedBox(
                                       width: 4,
                                     ),
                                     Text("Ontario",
                                         style: TextStyle(
                                           fontFamily: "ProductSans",
                                           fontSize: 14,
                                           //fontWeight: FontWeight.bold,
                                           color: Constants.hexToColor(
                                             Constants.primaryDarkColor,
                                           ),
                                         )),
                                   ],
                                 ),
                               ),
                             ),
                             Padding(
                               padding: EdgeInsets.only(right: 12, top: 124),
                               child: Align(
                                 alignment: Alignment.topRight,
                                 child: Container(
                                   height: 40,
                                   width: MediaQuery.of(context).size.width - 120,
                                   child: ListView.builder(
                                     scrollDirection: Axis.horizontal,
                                     shrinkWrap: true,
                                     itemCount: speciallity.length,
                                     itemBuilder: (ctx, index) {
                                       return Card(
                                         elevation: 2,
                                         shape: RoundedRectangleBorder(
                                           side: new BorderSide(
                                               color: Colors.blue, width: 1.0),
                                           borderRadius: BorderRadius.circular(6.0),
                                         ),
                                         child: Container(
                                           height: 40,
                                           width: 110,
                                           child: Center(
                                             child: Text(speciallity[index],
                                                 style: TextStyle(
                                                     color: Constants.hexToColor(
                                                       Constants.primaryDarkColor,
                                                     ),
                                                     fontSize: 14,
                                                     fontFamily: "ProductSans")),
                                           ),
                                         ),
                                       );
                                     },
                                   ),
                                 ),
                               ),
                             ),
                             Padding(
                               padding: EdgeInsets.only(right: 20, bottom: 18),
                               child: Align(
                                 alignment: Alignment.bottomRight,
                                 child: InkWell(
                                   onTap: (){
                                     Navigator.push(
                                       context,
                                       MaterialPageRoute(
                                         builder: (context) => PhysicianInformtion(),
                                       ),
                                     );
                                   },
                                   child: Text("View Details",
                                       style: TextStyle(
                                         fontFamily: "ProductSans",
                                         fontSize: 18,
                                         //fontWeight: FontWeight.bold,
                                         color: Constants.hexToColor(
                                           Constants.primaryColor,
                                         ),
                                       )),
                                 ),
                               ),
                             ),
                             Padding(
                               padding: EdgeInsets.only(left: 78, top: 184),
                               child: Text("Language: English",
                                   style: TextStyle(
                                     fontFamily: "ProductSans",
                                     fontSize: 12,
                                     //fontWeight: FontWeight.bold,
                                     color: Colors.grey,
                                   )),
                             ),
                             Padding(
                               padding: EdgeInsets.only(left: 95, top: 88),
                               child: Row(
                                 mainAxisAlignment: MainAxisAlignment.start,
                                 crossAxisAlignment: CrossAxisAlignment.center,
                                 children: [
                                   Icon(
                                     CupertinoIcons.star_fill,
                                     size: 16,
                                     color: Constants.hexToColor(
                                       Constants.primaryDarkColor,
                                     ),
                                   ),
                                   SizedBox(width: 4,),
                                   Padding(
                                     padding: EdgeInsets.only(top:4),
                                     child: Text("5.0",
                                         style: TextStyle(
                                           fontFamily: "ProductSans",
                                           fontSize: 16,
                                           //fontWeight: FontWeight.bold,
                                           color: Constants.hexToColor(
                                             Constants.primaryDarkColor,
                                           ),
                                         )),
                                   )
                                 ],
                               ),
                             ),
                           ],
                         ),
                       ),
                     ),
                   ),
                 )


 */
