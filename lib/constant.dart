import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qattan/veiw/component_widget/text_widget.dart';
import 'package:sizer/sizer.dart';

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
        fontSize: 9.0.sp);

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
          // contentPadding: EdgeInsets.all(20),
          // insetPadding: EdgeInsets.all(20),
          backgroundColor: mainColorOpacity,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          title: TextWidget(
            text: titlle!, fontWeight: FontWeight.bold,
            // style: TextStyle(
            //     fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
          ),
          content: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
            child: TextWidget(
              text: message!,
              fontWeight: FontWeight.bold,
              isSmallText: true,
            ),
          ),
          actions: <Widget>[
            // ignore: deprecated_member_use
            FlatButton(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
              shape: StadiumBorder(),
              color: Colors.white,
              child: Text(
                labelYes!,
                style: TextStyle(
                    color: Colors.red,
                    fontSize: SizerUtil.deviceType == DeviceType.mobile
                        ? 10.sp
                        : 8.sp),
              ),
              onPressed: onPressYes,
            ),
            // ignore: deprecated_member_use
            FlatButton(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
              shape: StadiumBorder(),
              color: Colors.white,
              child: Text(
                labelNo!,
                style: TextStyle(
                    color: Colors.black54,
                    fontSize: SizerUtil.deviceType == DeviceType.mobile
                        ? 10.sp
                        : 8.sp),
              ),
              onPressed: onPressNo,
            ),
          ],
        ),
      ),
    );
