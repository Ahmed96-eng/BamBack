import 'package:flutter/material.dart';
import 'package:qattan/constant.dart';

import 'package:qattan/controller/cubit/Auth_cubit.dart';
import 'package:qattan/features/responsive_setup/responsive_builder.dart';
import 'package:qattan/veiw/component_widget/common_button.dart';
import 'package:qattan/veiw/component_widget/icon_button_widget.dart';
import 'package:qattan/veiw/component_widget/navigator.dart';
import 'package:qattan/veiw/component_widget/style.dart';
import 'package:qattan/veiw/component_widget/text_form_field_widget.dart';
import 'package:qattan/veiw/screens/auth/forgot_password.dart';
import 'package:get/get.dart';

class EnterPhone extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, sizeConfig) {
      final height = sizeConfig.screenHeight!;
      final width = sizeConfig.screenWidth!;
      return Scaffold(
        appBar: AppBar(
          backgroundColor: mainColor,
          elevation: 0,
          leading: (lang == 'en')
              ? IconButtonWidget(
                  icon: (lang == 'ar') ? Icons.arrow_forward : Icons.arrow_back,
                  radius: width * 0.05,
                  size: width * 0.06,
                  onpressed: () {
                    back(context);
                  },
                )
              : Container(),
          actions: [
            if ((lang == 'ar'))
              IconButtonWidget(
                icon: (lang == 'ar') ? Icons.arrow_forward : Icons.arrow_back,
                radius: width * 0.05,
                size: width * 0.06,
                onpressed: () {
                  back(context);
                },
              ),
          ],
        ),
        body: Container(
          width: width,
          height: height,
          child: ListView(
            children: [
              Container(
                height: height * 0.22,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: mainColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(width * 0.1),
                    bottomRight: Radius.circular(width * 0.1),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(width * 0.04),
                  child: Center(
                      child: Text(
                    "enter_phone_txt".tr,
                    style: firstLineStyle,
                  )),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(width * 0.04),
                child: Container(
                  height: height * 0.48,
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
                  width: width * 0.85,
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
    });
  }
}
