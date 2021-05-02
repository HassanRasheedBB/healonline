import 'dart:convert';
import 'dart:io';
import 'package:HealOnline/Utils.dart';
import 'package:HealOnline/models/UploadItem.dart';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants.dart';

class UploadPdfs extends StatefulWidget {
  String appointmentId;
  UploadPdfs(this.appointmentId,{Key key}) : super(key: key);

  @override
  _UploadPdfsState createState() => _UploadPdfsState();
}

class _UploadPdfsState extends State<UploadPdfs> {
  List<UploadItem> pdfs = List();
  bool isLoading = false;
  File _imageFile;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getImagesFromDB();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          uploadPdf();
        },
        child: Icon(Icons.add),
        backgroundColor: Constants.hexToColor(Constants.primaryDarkColor),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: pdfs.length + 1,
        itemBuilder: (BuildContext context, int index) {
          return index == pdfs.length
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
                        if (pdfs[index].link != null) {
                          _launchURL(pdfs[index].link);
                        }
                      },
                      title: Padding(
                        padding: EdgeInsets.only(top: 8),
                        child: Text(
                          pdfs[index].title,
                          style: TextStyle(
                            fontFamily: "ProductSans",
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Constants.hexToColor(Constants.blackColor),
                          ),
                        ),
                      ),
                      subtitle: Padding(
                        padding: EdgeInsets.only(top: 8),
                        child: Text(
                          pdfs[index].date.split(" ").first,
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
                          color: Constants.hexToColor(Constants.primaryColor),
                        ),
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        color: Constants.hexToColor(Constants.primaryColor),
                        size: 16,
                      ),
                    ),
                  ],
                ),
                //
              ));
        },
      ),
    );
  }

  Future<void> getImagesFromDB() async {
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
        Response response = await get(Uri.parse(url), headers: headers);
        String body = response.body;
        print(body);

        List<UploadItem> list = [];

        if (response.statusCode == 200) {
          List<dynamic> appointments = (json.decode(body))["appointments"];

          for (int i = 0; i < appointments.length; i++) {
            if (appointments[i]["id"].toString() == widget.appointmentId) {
              List<dynamic> files = appointments[i]["appointment_files"];
              if (files != null && files.length > 0) {
                for (int i = 0; i < files.length; i++) {
                  if (files[i]["type"] == "pdf") {
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
        }

        setState(() {
          isLoading = false;
          pdfs.clear();
          pdfs.addAll(list);
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
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

  Future<void> uploadPdf() async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
        allowMultiple: false);

    File file;
    if (result != null) {
      file = File(result.files.single.path);
    } else {
      return;
    }

    _imageFile = File(file.path);

    String url = Utils.baseURL +
        Utils.SAVE_PRESCRIPTION +
        widget.appointmentId.toString();
    print(url);

    Uri uri = Uri.parse(url);
    http.MultipartRequest request = new http.MultipartRequest('POST', uri);

    request.fields['prescription[0][type]'] = "pdf";

    request.headers['Content-type'] = "application/json";
    request.headers['Authorization'] = "Bearer " + Utils.user.token;

    String fileName = _imageFile.path.split('/').last;
    String ext = fileName.split(".").last;
    request.files.add(await http.MultipartFile.fromPath(
        'prescription[0][file]', _imageFile.path,
        contentType: new MediaType('pdf', ext)));

    request.send().then((http.StreamedResponse response) async {
      if (response.statusCode == 200) {
        isLoading = false;
        getImagesFromDB();
      } else {
        showAlertDialog(
            "Error", "Some information went wrong please try again", context);
        print(response.toString());
      }
    }).catchError((error) async {
      showAlertDialog(
          "Error", "Some information went wrong please try again", context);
      print(error.toString());
    });

    setState(() {
      isLoading = true;
    });


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
              child: Text("OK",
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

  Future<void> _launchURL(String _url) async {
    await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
  }

}
