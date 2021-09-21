import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

String? userId;
String? lang;
double totalAmount = 0.0;
int cartID = 0;

Color? mainColor = Color(0xff7BCFE9);
Color? mainColorOpacity = Colors.cyan.withOpacity(0.3);
Color? secondColor = Colors.grey[400];
Color? buttonColor = Color(0xff126881);
Color? buttonTextColor = Colors.white;

checkInternetConnection() async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      print('connected');
    }
  } on SocketException catch (_) {
    print('not connected');
  }
}

showFlutterToast({
  String? message,
  Color? backgroundColor = Colors.black38,
}) =>
    Fluttertoast.showToast(
        msg: message!,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: backgroundColor,
        textColor: Colors.white,
        fontSize: 16.0);

showAlertDailog(
        {BuildContext? context,
        String? titlle,
        String? message,
        String? labelNo,
        String? labelYes,
        required VoidCallback? onPressNo,
        required VoidCallback? onPressYes}) =>
    showDialog(
      context: context!,
      builder: (ctx) => Container(
        // decoration: BoxDecoration(
        //   gradient: maingradient(),
        // ),
        child: AlertDialog(
          backgroundColor: mainColorOpacity,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: new Text(
            titlle!,
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
          ),
          content: new Text(
            message!,
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white, fontSize: 18),
          ),
          actions: <Widget>[
            // ignore: deprecated_member_use
            FlatButton(
              shape: StadiumBorder(),
              color: Colors.white,
              child: Text(
                labelYes!,
                style: TextStyle(color: Colors.red, fontSize: 16),
              ),
              onPressed: onPressYes,
            ),
            // ignore: deprecated_member_use
            FlatButton(
              shape: StadiumBorder(),
              color: Colors.white,
              child: Text(
                labelNo!,
                style: TextStyle(color: Colors.black54, fontSize: 16),
              ),
              onPressed: onPressNo,
            ),
          ],
        ),
      ),
    );
