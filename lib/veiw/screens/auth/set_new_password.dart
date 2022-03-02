import 'package:flutter/material.dart';
import 'package:qattan/constant.dart';
import 'package:qattan/controller/cubit/Auth_cubit.dart';
import 'package:qattan/veiw/component_widget/common_button.dart';
import 'package:qattan/veiw/component_widget/icon_button_widget.dart';
import 'package:qattan/veiw/component_widget/navigator.dart';
import 'package:qattan/veiw/component_widget/style.dart';
import 'package:qattan/veiw/component_widget/text_form_field_widget.dart';
import 'package:get/get.dart';
import 'package:qattan/veiw/component_widget/text_widget.dart';
import 'package:qattan/veiw/screens/auth/log_in.dart';
import 'package:sizer/sizer.dart';

class SetNewPassword extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final String? phoneNumber;
  SetNewPassword({this.phoneNumber});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        elevation: 0,
        leading: (lang == 'en')
            ? IconButtonWidget(
                icon: (lang == 'ar') ? Icons.arrow_forward : Icons.arrow_back,
                radius: 5.w,
                size: 6.w,
                onpressed: () {
                  back(context);
                },
              )
            : Container(),
        actions: [
          if ((lang == 'ar'))
            IconButtonWidget(
              icon: (lang == 'ar') ? Icons.arrow_forward : Icons.arrow_back,
              radius: 5.w,
              size: 6.w,
              onpressed: () {
                back(context);
              },
            ),
        ],
      ),
      body: Container(
        height: 100.h,
        child: ListView(
          children: [
            Container(
              height: 22.h,
              width: double.infinity,
              decoration: BoxDecoration(
                color: mainColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15.w),
                  bottomRight: Radius.circular(15.w),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(4.w),
                child: Center(
                  child: TextWidget(
                    text: "set_new_password".tr,
                    fontWeight: FontWeight.bold,
                    color: buttonTextColor!,
                    // isSmallText: true,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(4.w),
              child: Container(
                height: 50.h,
                child: Form(
                  key: _formKey,
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextFormFieldWidget(
                        hint: "password_hint".tr,
                        controller: passwordController,
                        keyboardType: TextInputType.text,
                        iconData: Icons.remove_red_eye_rounded,
                        obscurePassword: true,
                        valdiator: (value) {
                          if (value!.isEmpty) {
                            return "enter_this_field_please!".tr;
                          } else if (value.length < 6) {
                            return "enter_the_correct_password_please!".tr;
                          }

                          return null;
                        },
                      ),
                      TextFormFieldWidget(
                        hint: "confirm_hint".tr,
                        controller: confirmPasswordController,
                        keyboardType: TextInputType.text,
                        iconData: Icons.remove_red_eye_rounded,
                        obscurePassword: true,
                        valdiator: (value) {
                          if (value!.isEmpty) {
                            return "enter_this_field_please!".tr;
                          } else if (value != passwordController.text) {
                            return "enter_the_correct_password_please!".tr;
                          } else if (value.length !=
                              passwordController.text.length) {
                            return "enter_the_correct_password_please!".tr;
                          }

                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional.bottomCenter,
              child: CommonButton(
                text: "save_password".tr,
                width: 85.w,
                containerColor: buttonColor,
                textColor: buttonTextColor,
                onTap: () {
                  if (!_formKey.currentState!.validate()) {
                    return;
                  } else {
                    print(phoneNumber);
                    AuthCubit.get(context)
                        .setNewPassword(passwordController.text, phoneNumber!)
                        .then((value) => goToAndFinish(context, LogIn()));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
