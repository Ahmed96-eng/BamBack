import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qattan/constant.dart';
import 'package:qattan/controller/cubit/App_cubit.dart';
import 'package:qattan/controller/cubit_states/app_states.dart';
import 'package:qattan/features/responsive_setup/responsive_builder.dart';
import 'package:qattan/veiw/component_widget/cached_network_Image_widget.dart';
import 'package:qattan/veiw/component_widget/common_button.dart';
import 'package:qattan/veiw/component_widget/icon_button_widget.dart';
import 'package:qattan/veiw/component_widget/navigator.dart';
import 'package:qattan/veiw/component_widget/style.dart';
import 'package:qattan/veiw/component_widget/text_form_field_widget.dart';
import 'package:get/get.dart';
import 'package:qattan/veiw/screens/bottom_nav_bar_layout.dart';

class EditProfileDataScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  var userNameController = TextEditingController();
  var locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, sizeConfig) {
      final height = sizeConfig.screenHeight!;
      final width = sizeConfig.screenWidth!;
      return BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          var userModel = AppCubit.get(context).profilModel!.data!;
          var homeCubit = AppCubit.get(context);
          // userNameController.text = userModel.username!;
          // locationController.text = userModel.location!;

          return WillPopScope(
            onWillPop: () {
              AppCubit.get(context).currentIndex = 0;
              return goToAndFinish(context, BotomNavBarLayout());
              // return back(context);
            },
            child: SafeArea(
              child: Scaffold(
                // appBar: AppBar(
                //   centerTitle: true,
                //   title: Text("edit_profile".tr),
                //   // backgroundColor: Colors.transparent,
                //   // actions: [
                //   //   TextButton(
                //   //     onPressed: () {
                //   //       // if (homeCubit.profileImage != null) {
                //   //       //   homeCubit.updateUserWithUploadProfileImage(
                //   //       //       name: nameController.text,
                //   //       //       phone: phoneController.text,
                //   //       //       bio: bioController.text);
                //   //       //   print("profile image is ---> ");
                //   //       //   // if (state is GetUserSuccessState) back(context);
                //   //       // } else if (homeCubit.coverImage != null) {
                //   //       //   homeCubit.updateUserWithUploadCoverImage(
                //   //       //       name: nameController.text,
                //   //       //       phone: phoneController.text,
                //   //       //       bio: bioController.text);
                //   //       //   print("cover image is ---> ");
                //   //       //   // if (state is GetUserSuccessState) back(context);
                //   //       // } else {
                //   //       //   homeCubit.updateUser(
                //   //       //       name: nameController.text,
                //   //       //       phone: phoneController.text,
                //   //       //       bio: bioController.text);
                //   //       //   // if (state is GetUserSuccessState) back(context);
                //   //       // }
                //   //     },
                //   //     child: Text(
                //   //       "Update",
                //   //       style: TextStyle(
                //   //         color: Colors.white,
                //   //         fontSize: 18,
                //   //         fontWeight: FontWeight.bold,
                //   //       ),
                //   //     ),
                //   //     // child: ConditionalBuilder(
                //   //     //   condition: state is! UpdateUserLoadingState,
                //   //     //   builder: (context) => Text(
                //   //     //     "Update",
                //   //     //     style: TextStyle(
                //   //     //       color: Colors.white,
                //   //     //       fontSize: 18,
                //   //     //       fontWeight: FontWeight.bold,
                //   //     //     ),
                //   //     //   ),
                //   //     //   fallback: (context) => Center(
                //   //     //       child: Padding(
                //   //     //     padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                //   //     //     child: CircularProgressIndicator(
                //   //     //       color: Colors.red,
                //   //     //       strokeWidth: 3,
                //   //     //     ),
                //   //     //   )),
                //   //     // ),
                //   //   ),
                //   //   SizedBox(
                //   //     width: 5,
                //   //   )
                //   // ],
                // ),
                body: SingleChildScrollView(
                  child: Container(
                    height: height - 30,
                    width: width,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: height * 0.3,
                            child: Stack(
                              alignment: AlignmentDirectional.center,
                              children: [
                                Align(
                                  alignment: AlignmentDirectional.topCenter,
                                  child: Container(
                                    height: height / 3,
                                    width: double.infinity,
                                    color: Colors.black12,
                                  ),
                                ),
                                Stack(
                                  alignment: AlignmentDirectional.bottomEnd,
                                  children: [
                                    CircleAvatar(
                                      radius: width * 0.15,
                                      child: homeCubit.profileImage == null
                                          ? CircleAvatar(
                                              radius: width * 0.14,
                                              child: ClipOval(
                                                  child:
                                                      CachedNetworkImageWidget(
                                                width: width * 0.32,
                                                height: height * 0.18,
                                                image: homeCubit.profilModel!
                                                    .data!.profileImage,
                                              )),
                                            )
                                          : CircleAvatar(
                                              backgroundColor: Colors.amber,
                                              radius: height * 0.09,
                                              backgroundImage: FileImage(
                                                  homeCubit.profileImage!),
                                            ),
                                    ),
                                    IconButtonWidget(
                                      icon: Icons.camera_alt_rounded,
                                      radius: width * 0.05,
                                      size: width * 0.05,
                                      onpressed: () {
                                        homeCubit.getProfileImage(context,
                                            height: height * 0.08,
                                            width: width * 0.85);
                                      },
                                    ),
                                  ],
                                ),
                                Align(
                                  alignment: (lang == 'en')
                                      ? AlignmentDirectional.topStart
                                      : AlignmentDirectional.topEnd,
                                  child: Padding(
                                    padding: EdgeInsets.all(width * 0.02),
                                    child: IconButtonWidget(
                                      icon: (lang == 'ar')
                                          ? Icons.arrow_forward
                                          : Icons.arrow_back,
                                      radius: width * 0.05,
                                      size: width * 0.05,
                                      onpressed: () {
                                        // back(context);
                                        AppCubit.get(context).currentIndex = 0;
                                        goToAndFinish(
                                            context, BotomNavBarLayout());
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          if (state is UpdateProfileLoadingState)
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: LinearProgressIndicator(
                                color: mainColor,
                                minHeight: 8,
                              ),
                            ),
                          SizedBox(
                            height: height * 0.02,
                          ),

                          Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: width * 0.02),
                            child: Row(
                              children: [
                                Text(
                                  "name_hint".tr + " : ",
                                  style: thirdLineStyle,
                                ),
                                Expanded(
                                  child: TextFormFieldWidget(
                                    // hint: "name_hint".tr,
                                    hint: userModel.username!,
                                    controller: userNameController,
                                    keyboardType: TextInputType.text,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: width * 0.02),
                            child: Row(
                              children: [
                                Text(
                                  "my_location".tr + " : ",
                                  style: thirdLineStyle,
                                ),
                                Expanded(
                                  child: TextFormFieldWidget(
                                    // hint: "address_hint".tr,
                                    hint: userModel.location,
                                    controller: locationController,
                                    keyboardType: TextInputType.text,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Spacer(),
                          SizedBox(
                            height: height * 0.02,
                          ),

                          Align(
                            alignment: AlignmentDirectional.bottomCenter,
                            child: CommonButton(
                              text: 'edit_profile'.tr,
                              width: width * 0.85,
                              containerColor: buttonColor,
                              textColor: buttonTextColor,
                              onTap: () {
                                AppCubit.get(context)
                                    .updateProfile(
                                        imageFile: homeCubit.profileImage,
                                        userName:
                                            userNameController.text.isEmpty
                                                ? userModel.username
                                                : userNameController.text,
                                        location:
                                            locationController.text.isEmpty
                                                ? userModel.location
                                                : locationController.text)
                                    .then((value) {
                                  if (state is UpdateProfileSuccessState &&
                                      homeCubit.profileImage != null)
                                    goToAndFinish(context, BotomNavBarLayout());
                                  AppCubit.get(context).currentIndex = 0;
                                });
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
                ),
              ),
            ),
          );
        },
      );
    });
  }
}
