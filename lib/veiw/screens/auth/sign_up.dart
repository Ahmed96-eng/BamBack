import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qattan/constant.dart';
import 'package:qattan/controller/cached_helper/cached_helper.dart';
import 'package:qattan/controller/cached_helper/key_constant.dart';
import 'package:qattan/controller/cubit/Auth_cubit.dart';
import 'package:qattan/controller/cubit_states/Auth_state.dart';
import 'package:qattan/veiw/component_widget/common_button.dart';
import 'package:qattan/veiw/component_widget/navigator.dart';
import 'package:qattan/veiw/component_widget/style.dart';
import 'package:qattan/veiw/component_widget/text_form_field_widget.dart';
import 'package:qattan/veiw/component_widget/text_widget.dart';
import 'package:qattan/veiw/screens/auth/log_in.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../bottom_nav_bar_layout.dart';

class SignUp extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
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
        if (state is AuthRegisterErrorState) {
          Future.delayed(Duration(seconds: 0))
              .then((value) => showFlutterToast(message: 'register_error'.tr));
        }
      },
      builder: (context, state) => Scaffold(
        // resizeToAvoidBottomInset: false,
        body: Container(
          width: 100.w,
          height: 100.h,
          child: ListView(
            children: [
              Container(
                height: 32.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: mainColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15.w),
                    bottomRight: Radius.circular(15.w),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 2.h,
                      ),
                      Align(
                        alignment: AlignmentDirectional.topEnd,
                        child: CommonButton(
                            text: "sign_in".tr,
                            textColor: Colors.white,
                            width: 30.w,
                            onTap: () {
                              print('Tapped');
                              goTo(context, LogIn());
                            }),
                      ),
                      Spacer(),
                      TextWidget(
                        text: "sign_up".tr,
                        fontWeight: FontWeight.bold,
                        color: buttonTextColor!,
                        // isSmallText: true,
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      TextWidget(
                        text: "sign_up_text".tr,
                        fontWeight: FontWeight.bold,
                        color: buttonTextColor!,
                        isSmallText: true,
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                    ],
                  ),
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
                          hint: "name_hint".tr,
                          controller: userNameController,
                          keyboardType: TextInputType.text,
                          valdiator: (value) {
                            if (value!.isEmpty) {
                              return "enter_this_field_please!".tr;
                            }

                            return null;
                          },
                        ),
                        TextFormFieldWidget(
                          hint: "email_hint".tr,
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          valdiator: (value) {
                            if (value!.isEmpty) {
                              return "enter_this_field_please!".tr;
                            } else if (!value.contains('@')) {
                              return "enter_the_correct_email_please!".tr;
                            }

                            return null;
                          },
                        ),
                        TextFormFieldWidget(
                          hint: "password_hint".tr,
                          controller: passwordController,
                          keyboardType: TextInputType.text,
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
                          width: 100.w,
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
                                  textInputAction: TextInputAction.done,
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
                          height: 2.h,
                        ),

                        // CommonButton(
                        //   text: 'SIGN IN',
                        //   width: 85.w,
                        //   containerColor: Color(0xff126881),
                        //   textColor: Color(0xffF6F6F7),
                        //   onTap: () {},
                        // ),
                        // SizedBox(
                        //   height: height * 0.02,
                        // ),
                        // Text("Or Sign in with social media"),
                        // SizedBox(
                        //   height: height * 0.02,
                        // ),
                        // CommonButton(
                        //   text: 'CONTINUE WITH GOOGLE',
                        //   imageSource: 'asset/images/google_icon.png',
                        //   width: 85.w,
                        //   containerColor: Colors.grey[200],
                        //   textColor: Colors.black,
                        //   onTap: () {},
                        // ),
                        // SizedBox(
                        //   height: height * 0.015,
                        // ),
                        // CommonButton(
                        //   text: 'CONTINUE WITH FACEBOOK',
                        //   imageSource: 'asset/images/facebook_icon.png',
                        //   width: 85.w,
                        //   containerColor: Color(0xff123881),
                        //   textColor: Colors.white,
                        //   onTap: () {},
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
              Center(
                child: CommonButton(
                  text: 'continue'.tr,
                  width: 85.w,
                  containerColor: buttonColor,
                  textColor: Colors.white,
                  onTap: () {
                    if (!_formKey.currentState!.validate()) {
                      return;
                    } else {
                      AuthCubit.get(context).register(
                        username: userNameController.text,
                        email: emailController.text,
                        password: passwordController.text,
                        city: cityController.text,
                        location: locationController.text,
                        phone: phoneController.text,
                        region: regionController.text,
                      );
                      // goTo(
                      //   context,
                      //   ContinueSignUp(
                      //     userName: userNameController.text,
                      //     email: emailController.text,
                      //     password: passwordController.text,
                      //     confirmPassword: confirmPasswordController.text,
                      //   ),
                      // );
                    }
                  },
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
