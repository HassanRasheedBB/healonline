import 'dart:convert';
import 'dart:io';
import 'package:HealOnline/Utils.dart';
import 'package:HealOnline/models/UploadItem.dart';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:http/http.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../../constants.dart';

class UploadImages extends StatefulWidget {
  String appointmentId;

  UploadImages(this.appointmentId, {Key key}) : super(key: key);

  @override
  _UploadImagesState createState() => _UploadImagesState();
}

class _UploadImagesState extends State<UploadImages> {
  List<UploadItem> images = [];
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
        onPressed: () {
          uploadImage();
        },
        child: Icon(Icons.add),
        backgroundColor: Constants.hexToColor(Constants.primaryDarkColor),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: images.length + 1,
        itemBuilder: (BuildContext context, int index) {
          return index == images.length
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
                            if (images[index].link != null) {
                              _launchURL(images[index].link);
                            }
                          },
                          title: Padding(
                            padding: EdgeInsets.only(top: 8),
                            child: Text(
                              images[index].title,
                              style: TextStyle(
                                fontFamily: "ProductSans",
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color:
                                    Constants.hexToColor(Constants.blackColor),
                              ),
                            ),
                          ),
                          subtitle: Padding(
                            padding: EdgeInsets.only(top: 8),
                            child: Text(
                              images[index].date.split(" ").first,
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
                              color:
                                  Constants.hexToColor(Constants.primaryColor),
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
        Response response = await get(url, headers: headers);
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
                  if (files[i]["type"] == "image") {
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
          images.clear();
          images.addAll(list);
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

  void uploadImage() async {
    FilePickerResult result = await FilePicker.platform
        .pickFiles(allowMultiple: false, type: FileType.image);

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

    request.fields['prescription[0][type]'] = "image";

    request.headers['Content-type'] = "application/json";
    request.headers['Authorization'] = "Bearer " + Utils.user.token;

    String fileName = _imageFile.path.split('/').last;
    String ext = fileName.split(".").last;
    request.files.add(await http.MultipartFile.fromPath(
        'prescription[0][file]', _imageFile.path,
        contentType: new MediaType('image', ext)));

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
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WebViewExample(_url),
      ),
    );
  }
}

class WebViewExample extends StatefulWidget {
  String url;

  WebViewExample(this.url);

  @override
  WebViewExampleState createState() => WebViewExampleState();
}

class WebViewExampleState extends State<WebViewExample> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("File"),
        ),
        body: WebviewScaffold(
          allowFileURLs: true,
          supportMultipleWindows: true,
          withLocalStorage: true,

          url: widget.url,
          withZoom: true,
        ));
  }
}
