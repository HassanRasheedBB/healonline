import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart' as firebase_database;

import 'package:file_picker/file_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:healonline/models/UploadItem.dart';

import '../../constants.dart';

class UploadImages extends StatefulWidget {
  UploadImages({Key key}) : super(key: key);

  @override
  _UploadImagesState createState() => _UploadImagesState();
}

class _UploadImagesState extends State<UploadImages> {
  List<UploadItem> images = List();
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
                      onTap: () {},
                      title: Padding(
                        padding: EdgeInsets.only(top: 8),
                        child: Text(
                          images[index].title,
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

  void getImagesFromDB() {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });

      String type;
      List<UploadItem> imageList = List();
      final databaseReference = FirebaseDatabase.instance.reference();

      databaseReference
          .child("uploads")
          .child("09007860101")
          .once()
          .then((DataSnapshot snapshot) {
        Map<dynamic, dynamic> values = snapshot.value;
        if (values != null) {
          values.forEach((key, value) {
            type = value["type"];
            if(type == "img") {
              imageList.add(new UploadItem(
                  value["title"], value["date"], value["link"], value["type"]));
            }
          });
        }

        setState(() {
          isLoading = false;
          images.clear();
          images.addAll(imageList);
        });
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

  Future<void> uploadImage() async {
    File file = await FilePicker.getFile(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png'],
    );

    _imageFile = File(file.path);
    String imageUrl;

    setState(() {
      isLoading = true;
    });

    final mainReference =
    firebase_database.FirebaseDatabase.instance.reference();
    String key = mainReference.child("uploads").child("09007860101").push().key;

    Reference reference = FirebaseStorage.instance
        .ref()
        .child("Uploads")
        .child("09007860101")
        .child(key);
    UploadTask uploadTask = reference.putFile(_imageFile);

    uploadTask.whenComplete(() async {
      try {
        imageUrl = await reference.getDownloadURL();
        addInDB(key, imageUrl);
      } catch (onError) {
        showOtherAlertDialog(
            "Error", 'Something went wrong on uploading', context);
      }
      print(imageUrl);
    });
  }

  void addInDB(String key, String imageUrl) {
    final mainReference =
    firebase_database.FirebaseDatabase.instance.reference();
    String title = "Prescription # " + (images.length + 1).toString();
    String date = DateTime.now().toLocal().toString();
    UploadItem item = new UploadItem(title, date, imageUrl, "img");
    String key = mainReference.child("uploads").child("09007860101").push().key;

    try {
      mainReference
          .child("uploads")
          .child("09007860101")
          .child(key)
          .set(item.toJson())
          .then((value) {
        setState(() {
          isLoading = false;
          images.add(UploadItem(title, date, imageUrl, "img"));
        });
      });
    } on FirebaseAuthException catch (e) {
      setState(() {
        isLoading = false;
      });
      showOtherAlertDialog(
          "Error", 'Something went wrong please try again', context);
    }
  }

  void showOtherAlertDialog(String title, String msg, BuildContext context) {
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

    ;
  }

}
