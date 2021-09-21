import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:qattan/constant.dart';
import 'package:qattan/controller/cubit/Auth_cubit.dart';
import 'package:qattan/features/responsive_setup/responsive_builder.dart';
import 'package:qattan/veiw/component_widget/common_button.dart';
import 'package:qattan/veiw/component_widget/icon_button_widget.dart';
import 'package:qattan/veiw/component_widget/navigator.dart';
import 'package:qattan/veiw/component_widget/style.dart';
import 'package:qattan/veiw/screens/auth/set_new_password.dart';
import 'package:get/get.dart';

class ForgotPassword extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController pinCodeController = TextEditingController();
  final String? phoneNumber;
  ForgotPassword({this.phoneNumber});

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
          child: SingleChildScrollView(
            child: Column(
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
                      "forgot_password_txt".tr,
                      style: firstLineStyle,
                    )),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(width * 0.04),
                  child: Container(
                    height: height * 0.6,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: height * 0.35,
                            // margin: EdgeInsets.all(width * 0.01),
                            child: PinCodeTextField(
                              appContext: context,
                              length: 4,
                              obscureText: true,
                              keyboardType: TextInputType.text,
                              animationType: AnimationType.fade,
                              pinTheme: PinTheme(
                                  // shape: PinCodeFieldShape.box,

                                  borderRadius: BorderRadius.circular(5),
                                  borderWidth: 0,
                                  fieldHeight: 50,
                                  fieldWidth: 50,
                                  activeColor: Colors.grey[100],
                                  inactiveFillColor: Colors.grey[200],
                                  activeFillColor: Colors.grey[200],
                                  selectedColor: Colors.amber),
                              animationDuration: Duration(milliseconds: 300),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "enter_this_field_please!".tr;
                                }

                                return null;
                              },
                              enableActiveFill: true,
                              controller: pinCodeController,
                              onCompleted: (v) {
                                print("Completed");
                              },
                              onChanged: (value) {
                                print(value);
                                // setState(() {
                                //   currentText = value;
                                // });
                              },
                              beforeTextPaste: (text) {
                                print("Allowing to paste $text");
                                //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                                //but you can show anything you want here, like your pop up saying wrong paste format or etc
                                return true;
                              },
                            ),
                          ),
                          SizedBox(
                            height: height * 0.03,
                          ),
                          Text("forgot_password_phone_txt".tr),
                          Text("002002020020"),
                          SizedBox(
                            height: height * 0.04,
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                          //     Text("This code will expire on"),
                          //     SizedBox(
                          //       width: width * 0.01,
                          //     ),
                          //     Text("5 minutes"),
                          //   ],
                          // ),
                          Align(
                            alignment: AlignmentDirectional.bottomCenter,
                            child: CommonButton(
                              text: "verify_code".tr,
                              width: width * 0.85,
                              containerColor: buttonColor,
                              textColor: buttonTextColor,
                              onTap: () {
                                if (!_formKey.currentState!.validate()) {
                                  return;
                                } else {
                                  print(phoneNumber);
                                  AuthCubit.get(context)
                                      .sendOTP(
                                          pinCodeController.text, phoneNumber!)
                                      .then((value) => goTo(
                                          context,
                                          SetNewPassword(
                                            phoneNumber: phoneNumber!,
                                          )));
                                }
                              },
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional.bottomCenter,
                            child: CommonButton(
                              text: "resend_code".tr,
                              width: width * 0.85,
                              containerColor: secondColor,
                              textColor: buttonTextColor,
                              onTap: () {},
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
