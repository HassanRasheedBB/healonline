import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class CompletedAppointments extends StatefulWidget {
  CompletedAppointments({Key key}) : super(key: key);

  @override
  _CompletedAppointmentsState createState() => _CompletedAppointmentsState();
}

class _CompletedAppointmentsState extends State<CompletedAppointments> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          Text(
            "Appointments not found",
            style: TextStyle(
              fontFamily: "ProductSans",
              fontSize: 20,
              color: Constants.hexToColor(
                Constants.blackColor,
              ),
            ),
          ),

          SizedBox(height: 12,),

          Container(
            height: 40,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              color: Constants.hexToColor(Constants.primaryDarkColor),
            ),
            child: FlatButton(
              onPressed: () {

              },
              child: Center(
                child: Text('Refresh',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: "ProductSans")),
              ),
            ),
          ),

        ],
      )
    );
  }

}