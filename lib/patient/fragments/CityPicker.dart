import 'package:HealOnline/patient/EditProfileScreen.dart';
import 'package:HealOnline/patient/HealthCardScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants.dart';
import '../AddAddressScreen.dart';
import 'SelectSymptomScreen.dart';

class CityPicker extends StatefulWidget {
  String title;
  bool valueRequiredOnBackScreen;

  CityPicker(this.title, this.valueRequiredOnBackScreen, {Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState(title, valueRequiredOnBackScreen);
}

class _HomePageState extends State<CityPicker> {

  int  selectedRadio = 0;
  String title;
  bool valueRequiredOnBackScreen;

  _HomePageState(this.title, this.valueRequiredOnBackScreen);

  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }

  var cities = [
    "Northwest Territories",
    "Newfoundland and Labrador",
    "Nunavut",
    "Manitoba",
    "Ontario",
    "Saskatchewan",
    "Quebec",
    "Nova Scotia",
    "New Brunswick",
    "Alberta",
    "British Columbia",
    "Prince Edward Island",
    "Yukon"
  ];


  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 18),
          Container(
            height: 40,
            width: 40,
            child: SvgPicture.asset(
              "assets/images/location_pin.svg",
            ),
          ),
          SizedBox(height: 16),
          Text(
            "Select Your $title",
            style: TextStyle(
              fontFamily: "ProductSans",
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Constants.hexToColor(
                Constants.primaryDarkColor,
              ),
            ),
          ),
          SizedBox(height: 8),
          Text(
            "Choose Your province so we can offer the\nservices that suit you",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: "ProductSans",
              fontSize: 16,
              color: Constants.hexToColor(
                Constants.primaryDarkColor,
              ),
            ),
          ),
          SizedBox(height: 16),
          Container(
            height: 380 ,
            child: ListView.separated(
              itemCount: cities.length,
              itemBuilder: (context, index) {
                return ListTile(
                  trailing:   Radio(
                    value: (index+1),
                    groupValue: selectedRadio,
                    activeColor: Constants.hexToColor(
                      Constants.primaryColor,
                    ),
                    onChanged: (val) {
                      print("Radio $val");
                      Constants.appointment.province = cities[val-1];
                      setSelectedRadio(val);
                    },
                  ),
                  title: Text(
                    cities[index],
                    style: TextStyle(
                      fontFamily: "ProductSans",
                      fontSize: 16,
                      color: Constants.hexToColor(
                        Constants.blackColor,
                      ),
                    ),
                  ),
                  onTap: (){
                    setSelectedRadio(index+1);
                  },
                );
              },
              separatorBuilder: (context, index) {
                return Divider();
              },
            ),
          ),
          SizedBox(height: 8),
          Container(
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              color: Constants.hexToColor(Constants.primaryDarkColor),
            ),
            child: FlatButton(
              onPressed: () {
//                Navigator.of(context).pop();
              if(valueRequiredOnBackScreen){
                if(title == "City"){
                  AddAddressScreenState.updateCity(cities[selectedRadio  - 1]);

                }else{
                  AddAddressScreenState.updateProvince(cities[selectedRadio  - 1]);
                  EditProfileScreenState.updateProvince(cities[selectedRadio  - 1]);
                  HealthCardScreenState.updateProvince(cities[selectedRadio  - 1]);
                }

                Navigator.of(context).pop();
              }else{
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SelectSypmtomScreen(),
                  ),
                );
              }
              },
              child: Center(
                child: Text('SELECT',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: "ProductSans")),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
