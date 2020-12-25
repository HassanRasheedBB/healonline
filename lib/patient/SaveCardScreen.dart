import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../constants.dart';

class SaveCardScreen extends StatefulWidget {
  SaveCardScreen({Key key}) : super(key: key);

  @override
  _SaveCardScreenState createState() => _SaveCardScreenState();
}

class _SaveCardScreenState extends State<SaveCardScreen> {

  TextEditingController _cardNumberController = TextEditingController();
  TextEditingController _cardHolderNameController = TextEditingController();
  TextEditingController _cardExpiryController = TextEditingController();
  TextEditingController _cardSecurityCodeController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
       title: Text("Add Card",
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
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [

               Container(
                 width: MediaQuery.of(context).size.width,
                 height: 300,

                 child:  Padding(
                   padding: EdgeInsets.symmetric(horizontal: 16),
                   child: SvgPicture.asset(
                     "assets/images/credit_card.svg",
                     fit: BoxFit.fill,
                   ),
                 ),
               ),

               Padding(
                 padding: EdgeInsets.symmetric(horizontal: 18),
                 child: TextFormField(
                   key: Key('Username'),
                   controller: _cardNumberController,
                   validator: (value) =>
                   (value.isEmpty) ? "Please Enter Card Number" : null,
                   decoration: InputDecoration(
                       prefixIcon: Icon(Icons.person_outline),
                       border: OutlineInputBorder(),
                       hintText: 'Card Number*',
                       hintStyle: TextStyle(fontFamily: "ProductSans")),
                 ),
               ),

               SizedBox(
                 height:16,
               ),


               Padding(
                 padding: EdgeInsets.symmetric(horizontal: 18),
                 child: TextFormField(
                   key: Key('Username'),
                   controller: _cardHolderNameController,
                   validator: (value) =>
                   (value.isEmpty) ? "Please Enter Card Number" : null,
                   decoration: InputDecoration(
                       prefixIcon: Icon(CupertinoIcons.creditcard),
                       border: OutlineInputBorder(),
                       hintText: 'Card Holder Name*',
                       hintStyle: TextStyle(fontFamily: "ProductSans")),
                 ),
               ),

               SizedBox(
                 height:16,
               ),

               Padding(
                 padding: EdgeInsets.symmetric(horizontal: 18),
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                   children: [
                     Container(
                       width: MediaQuery.of(context).size.width  / 2 - 22,
                       child: TextFormField(
                         key: Key('Username'),
                         controller: _cardExpiryController,
                         validator: (value) =>
                         (value.isEmpty) ? "Please Enter Expiry Date" : null,
                         decoration: InputDecoration(
                             prefixIcon: Icon(CupertinoIcons.calendar),
                             border: OutlineInputBorder(),
                             hintText: 'Expiry*',
                             hintStyle: TextStyle(fontFamily: "ProductSans")),
                       ),
                     ),

                     SizedBox(width: 8,),

                     Container(
                       width: MediaQuery.of(context).size.width  / 2 - 22,
                       child: TextFormField(
                         key: Key('Username'),
                         controller: _cardSecurityCodeController,
                         validator: (value) =>
                         (value.isEmpty) ? "Please Enter Security Code" : null,
                         decoration: InputDecoration(
                             prefixIcon: Icon(Icons.security),
                             border: OutlineInputBorder(),
                             hintText: 'Code*',
                             hintStyle: TextStyle(fontFamily: "ProductSans")),
                       ),
                     )
                   ],
                 ),
               ),


             ],
           ),
         ),

         Container(
           margin: EdgeInsets.symmetric(horizontal: 16),
           height: 50,
           decoration: BoxDecoration(
             borderRadius: BorderRadius.all(Radius.circular(10)),
             color: Constants.hexToColor(Constants.primaryDarkColor),
           ),
           child: FlatButton(
             onPressed: () {


             },
             child: Center(
               child: Text('SAVE',
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