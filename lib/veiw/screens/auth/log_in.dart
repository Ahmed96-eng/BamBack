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
import 'package:qattan/veiw/screens/auth/enter_phone.dart';
import 'package:qattan/veiw/screens/auth/sign_up.dart';
import 'package:get/get.dart';
import 'package:qattan/veiw/screens/bottom_nav_bar_layout.dart';

class LogIn extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AutLoginSuccessState) {
          CachedHelper.setData(
                  key: loginTokenId,
                  value: state.authModelModel!.data!.id.toString())
              .then((value) => goToAndFinish(context, BotomNavBarLayout()));
        }
        if (state is AuthLoginErrorState) {
          showFlutterToast(message: 'login_error'.tr);
        }
      },
      builder: (context, state) =>
          ResponsiveBuilder(builder: (context, sizeConfig) {
        final height = sizeConfig.screenHeight!;
        final width = sizeConfig.screenWidth!;
        return Scaffold(
          // resizeToAvoidBottomInset: false,
          body: Container(
            width: width,
            height: height,
            child: Form(
              key: formKey,
              child: ListView(
                children: [
                  Container(
                    height: height * 0.38,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: mainColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(35),
                        bottomRight: Radius.circular(35),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: ListView(
                        physics: NeverScrollableScrollPhysics(),
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: height * 0.02,
                          ),
                          Align(
                            alignment: AlignmentDirectional.topEnd,
                            child: CommonButton(
                                text: "sign_up".tr,
                                textColor: Colors.white,
                                width: width * 0.25,
                                onTap: () {
                                  print('Tapped');
                                  goTo(context, SignUp());
                                }),
                          ),
                          Align(
                            alignment: AlignmentDirectional.center,
                            child: Container(
                              width: width * 0.4,
                              height: height * 0.15,
                              child: Image(
                                image: AssetImage('asset/images/main_logo.png'),
                              ),
                            ),
                          ),

                          Text(
                            "sign_in".tr,
                            style: firstLineStyle,
                          ),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          // Text(
                          //     "Lorem ipsum dolor sit amet, consectetur adipiscing elit.Integer maximus accumsan erat id facilisis."),
                          // SizedBox(
                          //   height: height * 0.02,
                          // ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  TextFormFieldWidget(
                    hint: 'name_hint'.tr,
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
                    hint: "password_hint".tr,
                    controller: passwordController,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    iconData: AuthCubit.get(context).showPassword
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    onTap: () =>
                        AuthCubit.get(context).changeshowPassword(context),
                    obscurePassword: AuthCubit.get(context).showPassword,
                    valdiator: (value) {
                      if (value!.isEmpty) {
                        return "enter_this_field_please!".tr;
                      } else if (value.length < 6) {
                        return "enter_the_correct_password_please!".tr;
                      }

                      return null;
                    },
                  ),
                  Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: CommonButton(
                      text: "forgot_password".tr,
                      width: width * 0.4,
                      textColor: Color(0xffE41A4A),
                      onTap: () {
                        goTo(context, EnterPhone());
                      },
                    ),
                  ),
                  Center(
                    child: CommonButton(
                      text: "sign_in".tr,
                      width: width * 0.85,
                      containerColor: buttonColor,
                      textColor: buttonTextColor,
                      onTap: () async {
                        print(userNameController.text);
                        print(passwordController.text);
                        if (!formKey.currentState!.validate()) {
                          return;
                        } else {
                          AuthCubit.get(context)
                              .logIn(
                            username: userNameController.text,
                            password: passwordController.text,
                          )
                              .then((value) {
                            // CachedHelper.getData(key: loginTokenId);
                            // AuthCubit.get(context).getCachesData(loginTokenId);
                            // AuthCubit.get(context).refresh();
                          });
                        }

                        // goTo(context, BotomNavBarLayout());
                      },
                    ),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
