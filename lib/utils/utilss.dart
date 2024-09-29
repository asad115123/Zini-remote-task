
import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../resources/res/colors.dart';


class Utils{


  static void fieldFocusChange(
    BuildContext context,
    FocusNode current,
    FocusNode nextFocus)
  {
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
}

  static  toastmessage(String mesg){
    Fluttertoast.showToast(msg: mesg,
        backgroundColor: Colors.pink,
        textColor: Colors.blue,
        toastLength: Toast.LENGTH_LONG
    );
  }

  static void flushbarErrormesg(String message,BuildContext context){
    showFlushbar(
        context: context,
        flushbar: Flushbar(
          margin: EdgeInsets.symmetric(horizontal: 10),
          icon: Icon(Icons.done,size: 26,color: WhiteColor,),
         flushbarPosition: FlushbarPosition.TOP,
         message: message,
         backgroundColor: blueColor,
         duration: Duration(seconds: 3),
        )..show(context)
    );
  }

  static void flushbarErrormesg1(String message,BuildContext context){
    showFlushbar(
        context: context,
        flushbar: Flushbar(
          margin: EdgeInsets.symmetric(horizontal: 10),
          icon: Icon(Icons.done,size: 26,color: WhiteColor,),
          flushbarPosition: FlushbarPosition.TOP,
          message: message,
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        )..show(context)
    );
  }



}