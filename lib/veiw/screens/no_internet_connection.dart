import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qattan/constant.dart';
import 'package:qattan/veiw/component_widget/common_button.dart';
import 'package:get/get.dart';
import 'package:qattan/veiw/component_widget/navigator.dart';
import 'package:qattan/veiw/component_widget/style.dart';
import 'package:qattan/veiw/screens/auth/log_in.dart';
import 'package:qattan/veiw/screens/bottom_nav_bar_layout.dart';
import 'package:qattan/veiw/screens/restart_app.dart';

class NoInternetConnection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "No_internet_connection".tr,
              style: secondLineStyle,
            ),
            CommonButton(
                text: 'check_connection'.tr,
                containerColor: buttonColor,
                width: MediaQuery.of(context).size.width / 2,
                textColor: Colors.white,
                onTap: () {
                  // final result = await InternetAddress.lookup('google.com');

                  // if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
                  // print('connected');
                  showAlertDailog(
                      context: context,
                      titlle: "check_connection".tr,
                      message: "check_message".tr,
                      labelNo: "exit_application".tr,
                      labelYes: "restart".tr,
                      onPressNo: () => exit(0),
                      onPressYes: () async {
                        final result =
                            await InternetAddress.lookup('google.com');

                        if (result.isNotEmpty &&
                            result[0].rawAddress.isNotEmpty) {
                          RestartWidget.restartApp(context).then((value) {
                            if (userId != null)
                              goToAndFinish(context, BotomNavBarLayout());
                            else
                              goToAndFinish(context, LogIn());
                          });
                        }
                      });

                  // RestartWidget.restartApp(context).then((value) {
                  //   if (userId != null)
                  //     goToAndFinish(context, BotomNavBarLayout());
                  //   else
                  //     goToAndFinish(context, LogIn());
                  // });

                  // } else
                  //   showAlertDailog(
                  //     context: context,
                  //     titlle: "exit_application".tr,
                  //     message: "are_you_sure_?".tr,
                  //     labelNo: "no".tr,
                  //     labelYes: "yes".tr,
                  //     onPressNo: () => back(context),
                  //     onPressYes: () => exit(0),
                  //   );
                }),
            // CommonButton(
            //     text: "exit_application".tr,
            //     containerColor: buttonColor,
            //     textColor: Colors.white,
            //     onTap: () {
            // showAlertDailog(
            //   context: context,
            //   titlle: "exit_application".tr,
            //   message: "are_you_sure_?".tr,
            //   labelNo: "no".tr,
            //   labelYes: "yes".tr,
            //   onPressNo: () => back(context),
            //   onPressYes: () => exit(0),
            // );
            //     }),
          ],
        ),
      ),
    );
  }
}
