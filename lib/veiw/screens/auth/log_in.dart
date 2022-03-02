import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qattan/constant.dart';
import 'package:qattan/controller/cached_helper/cached_helper.dart';
import 'package:qattan/controller/cached_helper/key_constant.dart';
import 'package:qattan/controller/cubit/Auth_cubit.dart';
import 'package:qattan/controller/cubit_states/Auth_state.dart';
import 'package:qattan/veiw/component_widget/common_button.dart';
import 'package:qattan/veiw/component_widget/navigator.dart';
import 'package:qattan/veiw/component_widget/text_form_field_widget.dart';
import 'package:qattan/veiw/component_widget/text_widget.dart';
import 'package:qattan/veiw/screens/auth/enter_phone.dart';
import 'package:qattan/veiw/screens/auth/sign_up.dart';
import 'package:get/get.dart';
import 'package:qattan/veiw/screens/bottom_nav_bar_layout.dart';
import 'package:sizer/sizer.dart';

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
      builder: (context, state) => Scaffold(
        // resizeToAvoidBottomInset: false,
        body: Container(
          width: 100.w,
          height: 100.h,
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                Container(
                  height: 38.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: mainColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15.w),
                      bottomRight: Radius.circular(15.w),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(5.w),
                    child: ListView(
                      physics: NeverScrollableScrollPhysics(),
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 2.h,
                        ),
                        Align(
                          alignment: AlignmentDirectional.topEnd,
                          child: CommonButton(
                              text: "sign_up".tr,
                              textColor: Colors.white,
                              width: 30.w,
                              onTap: () {
                                print('Tapped');
                                goTo(context, SignUp());
                              }),
                        ),
                        Align(
                          alignment: AlignmentDirectional.center,
                          child: Container(
                            width: 40.w,
                            height: 15.h,
                            child: Image(
                              image: AssetImage('asset/images/main_logo.png'),
                            ),
                          ),
                        ),

                        TextWidget(
                          text: "sign_in".tr,
                          fontWeight: FontWeight.bold,
                          color: buttonTextColor!,
                          // isSmallText: true,
                        ),
                        SizedBox(
                          height: 1.h,
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
                  height: 3.h,
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
                  child: InkWell(
                    child: Padding(
                      padding: EdgeInsets.all(5.w),
                      child: TextWidget(
                        text: "forgot_password".tr,
                        color: Color(0xffE41A4A),
                        fontWeight: FontWeight.bold,
                        isSmallText: true,
                      ),
                    ),
                    onTap: () {
                      goTo(context, EnterPhone());
                    },
                  ),
                  // child: CommonButton(
                  //   text: "forgot_password".tr,
                  //   width: 40.w,
                  //   textColor: Color(0xffE41A4A),
                  // onTap: () {
                  //   goTo(context, EnterPhone());
                  // },
                  // ),
                ),
                Center(
                  child: CommonButton(
                    text: "sign_in".tr,
                    width: 85.w,
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
                  height: 2.h,
                ),
                Center(
                  child: CommonButton(
                    text: "guest".tr,
                    width: 85.w,
                    containerColor: buttonColor,
                    textColor: buttonTextColor,
                    onTap: () {
                      goTo(context, BotomNavBarLayout());
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
      ),
    );
  }
}
