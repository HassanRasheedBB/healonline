import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

import '../constants.dart';

class DoctorNotesScreen extends StatefulWidget {
  DoctorNotesScreen({Key key}) : super(key: key);

  @override
  _DoctorNotesScreenState createState() => _DoctorNotesScreenState();
}

class _DoctorNotesScreenState extends State<DoctorNotesScreen> {
  final List<String> dates = <String>[
    '24-01-2020',
    '01-02-2020',
    '15-02-2020',
    '23-03-2020',
    '27-04-2020',
    '15-02-2020',
    '23-03-2020',
    '15-02-2020',
    '23-03-2020',
  ];

  final List<String> images = <String>[
    'Prescription # 1',
    'Prescription # 2',
    'Prescription # 3',
    'Prescription # 4',
    'Prescription # 5',
    'Prescription # 6',
    'Prescription # 7',
    'Prescription # 8',
    'Prescription # 9',
  ];

  final List<String> docs = <String>[
    'Document # 01',
    'Document # 02',
    'Document # 03',
    'Document # 04',
    'Document # 05',
    'Document # 06',
    'Document # 07',
    'Document # 08',
    'Document # 09',
  ];

  final List<String> pdfs = <String>[
    'PDF # 01',
    'PDF # 02',
    'PDF # 03',
    'PDF # 04',
    'PDF # 05',
    'PDF # 06',
    'PDF # 07',
    'PDF # 08',
    'PDF # 09',
  ];





  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(

      length: 3,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Add your onPressed code here!
          },
          child: Icon(Icons.add),
          backgroundColor: Constants.hexToColor(Constants.primaryDarkColor),
        ),
        appBar: AppBar(
          leading: Container(

              padding: EdgeInsets.only(left: 8),
              child: InkWell(
                onTap: (){
                  Navigator.of(context).pop();
                },
                child: Icon(Icons.arrow_back_ios, color: Constants.hexToColor(Constants.blackColor),size: 22,),
              )
          ),
          backgroundColor: Constants.hexToColor(Constants.whiteColor),
          bottom: TabBar(
            indicatorColor: Constants.hexToColor(Constants.primaryDarkColor),
            tabs: [
              Tab(
                icon: Padding(
                  padding: EdgeInsets.all(10),
                  child: SvgPicture.asset("assets/images/image.svg",
                      color: Constants.hexToColor(Constants.primaryDarkColor)),
                ),
              ),
              Tab(
                icon: Padding(
                  padding: EdgeInsets.all(10),
                  child: SvgPicture.asset("assets/images/doc_file.svg",
                      color: Constants.hexToColor(Constants.primaryDarkColor)),
                ),
              ),
              Tab(
                icon: Padding(
                  padding: EdgeInsets.all(10),
                  child: SvgPicture.asset("assets/images/pdf_file.svg",
                      color: Constants.hexToColor(Constants.primaryDarkColor)),
                ),
              ),
            ],
          ),
          title: Text(
            "Doctor Notes",
            style: TextStyle(
              fontFamily: "ProductSans",
              fontSize: 20,
              color: Constants.hexToColor(
                Constants.blackColor,
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: dates.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
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
                            onTap: () {},
                            title: Padding(
                              padding: EdgeInsets.only(top: 8),
                              child: Text(
                                images[index],
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
                                dates[index],
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
                              color:
                                  Constants.hexToColor(Constants.primaryColor),
                              size: 16,
                            ),
                          ),
                        ],
                      ),
                      //
                    ));
              },
            ),
            ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: dates.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
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
                            onTap: () {},
                            title: Padding(
                              padding: EdgeInsets.only(top: 8),
                              child: Text(
                                docs[index],
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
                                dates[index],
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
                                "assets/images/doc_files.svg",
                                color: Constants.hexToColor(
                                    Constants.primaryColor),
                              ),
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              color:
                              Constants.hexToColor(Constants.primaryColor),
                              size: 16,
                            ),
                          ),
                        ],
                      ),
                      //
                    ));
              },
            ),
            ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: dates.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
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
                            onTap: () {},
                            title: Padding(
                              padding: EdgeInsets.only(top: 8),
                              child: Text(
                                pdfs[index],
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
                                dates[index],
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
                                "assets/images/pdf_acrobat.svg",
                                color: Constants.hexToColor(
                                    Constants.primaryColor),
                              ),
                            ),
                            trailing: Icon(
                              Icons.arrow_forward_ios,
                              color:
                              Constants.hexToColor(Constants.primaryColor),
                              size: 16,
                            ),
                          ),
                        ],
                      ),
                      //
                    ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
