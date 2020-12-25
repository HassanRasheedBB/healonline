import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_svg/svg.dart';
import 'package:healonline/patient/RemainingQuestionsScreen.dart';
import '../constants.dart';

class CovidScreen extends StatefulWidget {
  CovidScreen({Key key}) : super(key: key);

  @override
  _CovidScreenState createState() => _CovidScreenState();
}


class _CovidScreenState extends State<CovidScreen> {

  int _radioValue = 0;
  TextEditingController _countryController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  String time = '';
  Widget timePlusCountry = Container();

  var months = [
    "",
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _dateController.text = time;
  }



  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;

      switch (_radioValue) {
        case 0:
          {
            timePlusCountry = Container();
            break;
          }
        case 1:
          {
            timePlusCountry = Align(
              alignment: Alignment.topLeft,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 18),
                child: Column(
                  children: [
                    SizedBox(
                      height: 18,
                    ),
                    TextFormField(
                      key: Key('Location'),
                      controller: _countryController,
                      validator: (value) =>
                      (value.isEmpty) ? "Please Enter Location" : null,
                      decoration: InputDecoration(
                        // prefixIcon: Icon(Icons.person_outline),
                          border: OutlineInputBorder(),
                          hintText: 'Location',
                          hintStyle: TextStyle(fontFamily: "ProductSans")),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      cursorColor: Colors.transparent,
                      key: Key('Travel Date'),
                      readOnly: true,
                      controller: _dateController,
                      validator: (value) =>
                      (value.isEmpty) ? "Please Enter Travel Date" : null,
                      decoration: InputDecoration(
                        //prefixIcon: Icon(Icons.person_outline),
                          border: OutlineInputBorder(),
                          suffixIcon: InkWell(
                            onTap: (){
                              DatePicker.showDatePicker(context,
                                  showTitleActions: true,
                                  minTime: DateTime(2020, 1, 1),
                                  maxTime: DateTime.now(),
                                  onChanged: (date) {
                                    _dateController.text = date.year.toString()+" "+months[date.month].toString()+" "+date.day.toString();
                                  }, onConfirm: (date) {
                                    _dateController.text = date.year.toString()+" "+months[date.month].toString()+" "+date.day.toString();
                                  }, currentTime: DateTime.now(), locale: LocaleType.en);
                            },
                            child: Icon(CupertinoIcons.calendar,
                                color:Constants.hexToColor(Constants.primaryDarkColor)),
                          ),
                          hintText: 'Travel Time',
                          hintStyle: TextStyle(fontFamily: "ProductSans")),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text("$time"),
                  ],
                ),
              ),
            );
            break;
          }
      }
    });
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
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
        title: Text("Questions",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: "ProductSans",
                color: Constants.hexToColor(Constants.primaryDarkColor))),
      ),
      body: Column(

        children: [
          Container(

            height: MediaQuery.of(context).size.height - 140,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 24,),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left:18),
                    child: Text("Have you recently been to a\naffected with COVID 19?",
                        style: TextStyle(
                          fontFamily: "ProductSans",
                          fontSize: 20,
                          color: Constants.hexToColor(
                            Constants.primaryDarkColor,
                          ),
                        )),
                  ),
                ),
                SizedBox(height: 8,),

                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left:6),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        new Radio(
                          value: 1,
                          groupValue: _radioValue,
                          onChanged: _handleRadioValueChange,
                        ),
                        new Text(
                          'Yes',
                          style: new TextStyle(fontSize: 16.0),
                        ),
                        new Radio(
                          value: 0,
                          groupValue: _radioValue,
                          onChanged: _handleRadioValueChange,
                        ),
                        new Text(
                          'No',
                          style: new TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                timePlusCountry



              ],
            ),
          ),

          Container(
            margin: EdgeInsets.symmetric(horizontal: 12),
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Constants.hexToColor(Constants.primaryDarkColor),
            ),
            child: FlatButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RemainingQuestionScreen(),
                  ),
                );
              },
              child: Center(
                child: Text('CONTINUE',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: "ProductSans")),
              ),
            ),
          ),

        ],
      ),
//      floatingActionButton: FloatingActionButton(
//        onPressed: _showCustomTimePicker,
//        tooltip: 'Increment',
//        child: Icon(Icons.add),
//      ),
    );
  }
}



/*

 Align(
                  alignment: Alignment.topCenter,
                  child: InkWell(
                    onTap: (){
                      _showCustomTimePicker();
                    },
                    child: Text(
                        '$time',
                        style: TextStyle(
                          fontFamily: "ProductSans",
                          fontSize: 16,
                          color: Constants.hexToColor(
                            Constants.blackColor,
                          ),
                        )
                    ),
                  ),
                ),
 */