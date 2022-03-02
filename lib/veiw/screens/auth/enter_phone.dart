import 'package:flutter/material.dart';
import 'package:qattan/constant.dart';
import 'package:qattan/controller/cubit/Auth_cubit.dart';
import 'package:qattan/veiw/component_widget/common_button.dart';
import 'package:qattan/veiw/component_widget/icon_button_widget.dart';
import 'package:qattan/veiw/component_widget/navigator.dart';
import 'package:qattan/veiw/component_widget/style.dart';
import 'package:qattan/veiw/component_widget/text_form_field_widget.dart';
import 'package:qattan/veiw/component_widget/text_widget.dart';
import 'package:qattan/veiw/screens/auth/forgot_password.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class EnterPhone extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController phoneController = TextEditingController();
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
        width: 100.w,
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
                    text: "enter_phone_txt".tr,
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextFormFieldWidget(
                        hint: "phone_hint".tr,
                        keyboardType: TextInputType.phone,
                        controller: phoneController,
                        valdiator: (value) {
                          String pattern =
                              r'^(009665|9665|\+9665|05|5)(5|0|3|6|4|9|1|8|7)([0-9]{7})$';
                          RegExp regex = new RegExp(pattern);
                          if (value!.length == 0) {
                            return "enter_the_phone_number_please!".tr;
                            // } else if (!regex.hasMatch(value)) {
                            //   return "enter_the_correct_phone_number_please!"
                            //       .tr;
                            // } else if (value.isEmpty) {
                            //   return "enter_this_field_please!".tr;
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
                text: "send".tr,
                width: 85.w,
                containerColor: buttonColor,
                textColor: buttonTextColor,
                onTap: () {
                  if (!_formKey.currentState!.validate()) {
                    return;
                  } else {
                    AuthCubit.get(context)
                        .sendSMS(phoneController.text)
                        .then((value) => goTo(
                            context,
                            ForgotPassword(
                              phoneNumber: phoneController.text,
                            )));
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
