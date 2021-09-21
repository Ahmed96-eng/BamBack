import 'package:flutter/material.dart';
import 'package:qattan/constant.dart';
import 'package:qattan/controller/cubit/Auth_cubit.dart';
import 'package:qattan/features/responsive_setup/responsive_builder.dart';
import 'package:qattan/veiw/component_widget/common_button.dart';
import 'package:qattan/veiw/component_widget/icon_button_widget.dart';
import 'package:qattan/veiw/component_widget/navigator.dart';
import 'package:qattan/veiw/component_widget/style.dart';
import 'package:qattan/veiw/component_widget/text_form_field_widget.dart';
import 'package:get/get.dart';
import 'package:qattan/veiw/screens/auth/log_in.dart';

class SetNewPassword extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final String? phoneNumber;
  SetNewPassword({this.phoneNumber});
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
                    "set_new_password".tr,
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
                  width: width * 0.85,
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
    });
  }
}
