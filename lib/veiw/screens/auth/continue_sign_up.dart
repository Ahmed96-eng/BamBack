import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qattan/constant.dart';
import 'package:qattan/controller/cached_helper/cached_helper.dart';
import 'package:qattan/controller/cached_helper/key_constant.dart';
import 'package:qattan/controller/cubit/Auth_cubit.dart';
import 'package:qattan/controller/cubit_states/Auth_state.dart';
import 'package:qattan/features/responsive_setup/responsive_builder.dart';
import 'package:qattan/veiw/component_widget/common_button.dart';
import 'package:qattan/veiw/component_widget/navigator.dart';
import 'package:qattan/veiw/component_widget/style.dart';
import 'package:qattan/veiw/component_widget/text_form_field_widget.dart';
import 'package:get/get.dart';
import 'package:qattan/veiw/screens/bottom_nav_bar_layout.dart';

class ContinueSignUp extends StatelessWidget {
  final String? userName;
  final String? email;
  final String? password;
  final String? confirmPassword;

  ContinueSignUp({
    this.userName,
    this.email,
    this.password,
    this.confirmPassword,
  });
  final _formKey = GlobalKey<FormState>();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController regionController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthRegisterSuccessState) {
          print('userIdRegister is');
          print(state.authModelModel!.data!.id.toString());
          CachedHelper.setData(
                  key: loginTokenId,
                  value: state.authModelModel!.data!.id.toString())
              .then(
            (value) => goToAndFinish(context, BotomNavBarLayout()),
          );
        }
        //  else {
        //   showFlutterToast(message: 'register_error'.tr);
        // }
      },
      builder: (context, state) =>
          ResponsiveBuilder(builder: (context, sizeConfig) {
        final height = sizeConfig.screenHeight!;
        final width = sizeConfig.screenWidth!;
        return Scaffold(
          body: Container(
            width: width,
            height: height,
            child: ListView(
              children: [
                Container(
                  height: height * 0.35,
                  width: double.infinity,
                  alignment: AlignmentDirectional.center,
                  decoration: BoxDecoration(
                    color: mainColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(35),
                      bottomRight: Radius.circular(35),
                    ),
                  ),
                  child: Text(
                    "continue_sign_up".tr,
                    style: firstLineStyle,
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Container(
                    margin: EdgeInsets.all(16),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          TextFormFieldWidget(
                            hint: "phone_hint".tr,
                            controller: phoneController,
                            keyboardType: TextInputType.phone,
                            valdiator: (value) {
                              String pattern =
                                  r'^(009665|9665|\+9665|05|5)(5|0|3|6|4|9|1|8|7)([0-9]{7})$';
                              RegExp regex = new RegExp(pattern);
                              if (value!.length == 0) {
                                return "enter_the_phone_number_please!".tr;
                                // } else if (!regex.hasMatch(value)) {
                                //   return "enter_the_correct_phone_number_please!"
                                //       .tr;
                              } else if (value.isEmpty) {
                                return "enter_this_field_please!".tr;
                              }
                              return null;
                            },
                          ),
                          TextFormFieldWidget(
                            hint: "address_hint".tr,
                            controller: locationController,
                            keyboardType: TextInputType.text,
                            valdiator: (value) {
                              if (value!.isEmpty) {
                                return "enter_this_field_please!".tr;
                              }

                              return null;
                            },
                          ),
                          Container(
                            width: width,
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextFormFieldWidget(
                                    hint: "city_hint".tr,
                                    keyboardType: TextInputType.text,
                                    controller: cityController,
                                    valdiator: (value) {
                                      if (value!.isEmpty) {
                                        return "enter_this_field_please!".tr;
                                      }

                                      return null;
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: TextFormFieldWidget(
                                    hint: "region_hint".tr,
                                    keyboardType: TextInputType.text,
                                    controller: regionController,
                                    valdiator: (value) {
                                      if (value!.isEmpty) {
                                        return "enter_this_field_please!".tr;
                                      }

                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Center(
                  child: CommonButton(
                    text: "sign_up".tr,
                    width: width * 0.85,
                    containerColor: buttonColor,
                    textColor: buttonTextColor,
                    onTap: () {
                      print(userName);
                      print(email);
                      print(password);
                      print(confirmPassword);
                      print(cityController.text);
                      print(locationController.text);
                      print(phoneController.text);
                      print(regionController.text);

                      if (!_formKey.currentState!.validate()) {
                        return;
                      } else {
                        AuthCubit.get(context)
                            .register(
                          username: userName,
                          email: email,
                          password: password,
                          city: cityController.text,
                          location: locationController.text,
                          phone: phoneController.text,
                          region: regionController.text,
                        )
                            .catchError((error) {
                          print(error);
                          showFlutterToast(message: 'register_error'.tr);
                        });
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
