import 'dart:io';
import 'package:HealOnline/models/UploadItem.dart';
import 'package:HealOnline/patient/fragments/UploadDocsScreen.dart';
import 'package:HealOnline/patient/fragments/UploadImages.dart';
import 'package:HealOnline/patient/fragments/UploadPdfs.dart';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

import '../constants.dart';

class DoctorNotesScreen extends StatefulWidget {
  String appointmentId;
  DoctorNotesScreen(this.appointmentId, {Key key}) : super(key: key);

  @override
  _DoctorNotesScreenState createState() => _DoctorNotesScreenState();
}

class _DoctorNotesScreenState extends State<DoctorNotesScreen>
    with SingleTickerProviderStateMixin {
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

  final List<String> dummyImages = <String>[
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

  final List<String> dummyDocs = <String>[
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

  final List<String> dummyPdfs = <String>[
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

  TabController _tabController;
  List<UploadItem> images = List();
  bool isLoading = false;
  int _currentIndex = 0;
  List<UploadItem> docs = List();
  List<UploadItem> pdfs = List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          leading: Container(
              padding: EdgeInsets.only(left: 8),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Constants.hexToColor(Constants.blackColor),
                  size: 22,
                ),
              )),
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
         // controller: _tabController,
          children: [
            UploadImages(widget.appointmentId),
            UploadDocs(widget.appointmentId),
            UploadPdfs(widget.appointmentId),
          ],
        ),
      ),
    );
  }


}
