import 'dart:io';

import 'package:custom_radio_grouped_button/CustomButtons/ButtonTextStyle.dart';
import 'package:custom_radio_grouped_button/CustomButtons/CustomRadioButton.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../constants.dart';
import 'DoctorsFoundScreen.dart';

class RemainingQuestionScreen extends StatefulWidget {
  RemainingQuestionScreen({Key key}) : super(key: key);

  @override
  _RemainingQuestionScreenState createState() =>
      _RemainingQuestionScreenState();
}

class _RemainingQuestionScreenState extends State<RemainingQuestionScreen> {
  TextEditingController _noteController = TextEditingController();
  TextEditingController _additionalDetilsController = TextEditingController();

  String selectedContactedOptionAs;
  Widget imgContainer;
  Widget imagePlaceHolder;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    imgContainer = Container();
    imagePlaceHolder = Container();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        resizeToAvoidBottomInset: false,
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
            SizedBox(
              height: 24,
            ),
            Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 18),
                  child: Text("Write a sick note",
                      style: TextStyle(
                        fontFamily: "ProductSans",
                        fontSize: 20,
                        color: Constants.hexToColor(
                          Constants.primaryDarkColor,
                        ),
                      )),
                )),
            SizedBox(
              height: 18,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 18),
              child:  TextFormField(textInputAction: TextInputAction.done,
                key: Key('Location'),
                controller: _noteController,
//            validator: (value) =>
//            (value.isEmpty) ? "Please Enter Note" : null,
                decoration: InputDecoration(
                  // prefixIcon: Icon(Icons.person_outline),
                    border: OutlineInputBorder(),
                    hintText: 'I need a sick note',
                    hintStyle: TextStyle(fontFamily: "ProductSans")),
              ),
            ),
            SizedBox(
              height: 24,
            ),
            // Align(
            //     alignment: Alignment.centerLeft,
            //     child: Padding(
            //       padding: EdgeInsets.symmetric(horizontal: 18),
            //       child: Text(
            //         'What method of communication do you\nprefer for your virtual visit',
            //         style: TextStyle(
            //             fontSize: 16,
            //             color: Constants.hexToColor(
            //               Constants.primaryDarkColor,
            //             ),
            //             fontFamily: "ProductSans"),
            //       ),
            //     )),
            // SizedBox(
            //   height: 12,
            // ),
            // Padding(
            //   padding: EdgeInsets.only(left: 12),
            //   child: Align(
            //     alignment: Alignment.center,
            //     child: CustomRadioButton(
            //       spacing: 2,
            //       elevation: 4,
            //       height: 40,
            //       width: MediaQuery.of(context).size.width / 2 - 37,
            //       customShape: RoundedRectangleBorder(
            //           borderRadius: new BorderRadius.circular(6.0)),
            //       enableShape: true,
            //       unSelectedColor: Theme.of(context).canvasColor,
            //       buttonLables: [
            //         'Video Call',
            //         'Audio Call',
            //       ],
            //       buttonValues: [
            //         "VIDEO",
            //         "AUDIO",
            //       ],
            //       buttonTextStyle: ButtonTextStyle(
            //           selectedColor: Colors.white,
            //           unSelectedColor: Colors.black,
            //           textStyle: TextStyle(
            //               fontSize: 16, fontFamily: "ProductSans")),
            //       radioButtonValue: (value) {
            //         print(value);
            //         selectedContactedOptionAs = value;
            //       },
            //       selectedColor:
            //       Constants.hexToColor(Constants.primaryDarkColor),
            //     ),
            //   ),
            // ),
            // SizedBox(
            //   height: 24,
            // ),
            Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Tell us more',
                          style: TextStyle(
                              fontSize: 16,
                              color: Constants.hexToColor(
                                Constants.primaryDarkColor,
                              ),
                              fontFamily: "ProductSans"),
                        ),
                        Text(
                          ' (Optional)',
                          style: TextStyle(
                              fontSize: 10,
                              color: Constants.hexToColor(
                                Constants.primaryDarkColor,
                              ),
                              fontFamily: "ProductSans"),
                        ),
                      ],
                    ),
                  ),
                )),
            SizedBox(
              height: 8,
            ),
            Container(
              height: 100,
              padding: EdgeInsets.symmetric(horizontal: 18),
              child:  TextFormField(textInputAction: TextInputAction.done,
                controller: _additionalDetilsController,
                keyboardType: TextInputType.multiline,
                maxLines: 4,
                key: Key('Location'),

//            validator: (value) =>
//            (value.isEmpty) ? "Please Enter Note" : null,
                decoration: InputDecoration(
                  // prefixIcon: Icon(Icons.person_outline),
                    border: OutlineInputBorder(),
                    hintText: 'Enter Additional Details',
                    hintStyle: TextStyle(fontFamily: "ProductSans")),
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18),
                  child: Text(
                    'Upload image of your physical symptoms /\n Injury',
                    style: TextStyle(
                        fontSize: 16,
                        color: Constants.hexToColor(
                          Constants.primaryDarkColor,
                        ),
                        fontFamily: "ProductSans"),
                  ),
                )),
            SizedBox(
              height: 12,
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: new Container(
                  height: 80,
                  width: 120,
                  margin: EdgeInsets.symmetric(horizontal: 18),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    border: Border.all(
                      color: Colors.grey,
                    ),
                  ),
                  child: Stack(
                    children: [
                      imagePlaceHolder,
                      Align(
                        alignment: Alignment.center,
                        child: InkWell(
                          onTap: () {
                            pickImage();
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(Icons.upload_rounded),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                'Upload Image',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Constants.hexToColor(
                                      Constants.blackColor,
                                    ),
                                    fontFamily: "ProductSans"),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                              padding: EdgeInsets.all(6),
                              child: imgContainer)),
                    ],
                  ),
                )),
          ],
        ),

      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(6)),
          color: Constants.hexToColor(Constants.primaryDarkColor),
        ),
        child: FlatButton(
          onPressed: () {
            Constants.appointment.sickNote = _noteController.text;
            Constants.appointment.additionalDetails =
                _additionalDetilsController.text;

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => DoctorsFoundScreen(),
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
    );
  }

  File _imageFile;

  Future<void> pickImage() async {
    FilePickerResult result = await FilePicker.platform.pickFiles(allowMultiple: false,type: FileType.image);

    File file;
    if(result != null) {
      _imageFile = File(result.files.single.path);
      setState(() {
        imagePlaceHolder = Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Icon(CupertinoIcons.photo_fill, size: 16, color: Constants.hexToColor(Constants.primaryColor),),
          ),
        );
      });
    } else {
      return;
    }
    Constants.appointment.AudioOrVideo = _imageFile.path;
    print(_imageFile);

  }
}




/*

String imageUrl;

    Reference reference = FirebaseStorage.instance.ref().child("Appointments").child("09007860101");

    UploadTask uploadTask =  reference.putFile(_imageFile);

    uploadTask.whenComplete(() async{

      try{
        imageUrl = await reference.getDownloadURL();
      }catch(onError){
        print("Error");
      }

      print(imageUrl);

    });


    setState(() {
      imgContainer = Icon(
        Icons.image,
        size: 20,
        color: Constants.hexToColor(Constants.primaryDarkColor),
      );
    });


 */
