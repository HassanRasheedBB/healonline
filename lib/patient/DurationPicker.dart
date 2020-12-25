import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class DurationPicker extends StatefulWidget {
  final Function(String) onChange;

  const DurationPicker({Key key, this.onChange}) : super(key: key);
  @override
  _DurationPickerState createState() => _DurationPickerState();
}

class _DurationPickerState extends State<DurationPicker> {
  Widget durationPicker({bool inMinutes = false, bool inYears = false }) {

    return CupertinoPicker(
      scrollController: FixedExtentScrollController(initialItem: 0),
      magnification: 1.1,
      backgroundColor: Constants.hexToColor(Constants.whiteColor),
      onSelectedItemChanged: (x) {
        if (inYears) {
          currentTimeInYr = x.toString();
        }
        else if (inMinutes) {
          currentTimeInMin = x.toString();
        }
        else{
          currentTimeInHour = x.toString();
        }
        setState(() {});
        widget.onChange('$currentTimeInHour Days,  $currentTimeInMin Months, $currentTimeInYr Years');
      },
      children: List.generate(
          inMinutes ? 10 : 10,
              (index) => Text(inMinutes ? '${index}' : '$index' ,
              style: TextStyle(color: Constants.hexToColor(Constants.blackColor),fontFamily: "ProductSans"))),
      itemExtent: 40,
    );
  }

  String currentTimeInHour = '0';
  String currentTimeInMin = '0';
  String currentTimeInYr = '0';
  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: TextStyle(color: Constants.hexToColor(Constants.primaryDarkColor)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            SizedBox(
              height: 8,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Select Duration',
                    style: TextStyle(
                        color:Constants.hexToColor(Constants.primaryDarkColor),
                        fontSize: 20,
                        fontFamily: "ProductSans")),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: Icon(
                    Icons.check,
                    color: Constants.hexToColor(Constants.primaryDarkColor),
                  ),
                )
              ],
            ),


            Padding(
                padding: EdgeInsets.only(bottom: 16),
                child: RichText(
                  text: TextSpan(
                      style: TextStyle(
                          color:Constants.hexToColor(Constants.primaryDarkColor),
                          fontFamily: "ProductSans"),
                      children: [
                        TextSpan(style: TextStyle(color: Color(0xff000000),
                            fontFamily: "ProductSans"),
                          text: 'Selected: ',
                        ),
                        TextSpan(

                            style: const TextStyle(color: Color(0xff000000)),
                            text:
                            '$currentTimeInHour Days,  $currentTimeInMin Months,  $currentTimeInYr Years'),
                        // TextSpan(text: ' $budgetinLakh Lakhs'),
                      ]),
                )),

            SizedBox(
              height: 16,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Days',
                    style: TextStyle(
                        color:Constants.hexToColor(Constants.blackColor),
                        fontSize: 18,
                        fontFamily: "ProductSans")),
                Text('Months',
                    style: TextStyle(
                        color:Constants.hexToColor(Constants.blackColor),
                        fontSize: 18,
                        fontFamily: "ProductSans")),
                Text('Years',
                    style: TextStyle(
                        color:Constants.hexToColor(Constants.blackColor),
                        fontSize: 18,
                        fontFamily: "ProductSans"))
              ],
            ),


            Container(
              color: Constants.hexToColor(Constants.whiteColor),
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Container(
                    color: Constants.hexToColor(Constants.whiteColor),
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.20,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(child: durationPicker()),
                        Expanded(child: durationPicker(inMinutes: true)),
                        Expanded(child: durationPicker(inMinutes: true, inYears: true),)
                      ],
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}