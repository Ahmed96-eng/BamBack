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
import 'package:qattan/veiw/component_widget/text_widget.dart';
import 'package:qattan/veiw/screens/bottom_nav_bar_layout.dart';
import 'package:sizer/sizer.dart';

class EditProfileDataScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  var userNameController = TextEditingController();
  var locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                  height: 100.h,
                  width: 100.w,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 30.h,
                          child: Stack(
                            alignment: AlignmentDirectional.center,
                            children: [
                              Align(
                                alignment: AlignmentDirectional.topCenter,
                                child: Container(
                                  height: 35.h,
                                  width: double.infinity,
                                  color: Colors.black12,
                                ),
                              ),
                              Stack(
                                alignment: AlignmentDirectional.bottomEnd,
                                children: [
                                  CircleAvatar(
                                    radius: 15.w,
                                    child: homeCubit.profileImage == null
                                        ? CircleAvatar(
                                            radius: 14.w,
                                            child: ClipOval(
                                                child: CachedNetworkImageWidget(
                                              // width: width * 0.32,
                                              // height: height * 0.18,
                                              image: homeCubit.profilModel!
                                                  .data!.profileImage,
                                            )),
                                          )
                                        : CircleAvatar(
                                            backgroundColor: Colors.amber,
                                            radius: 9.h,
                                            backgroundImage: FileImage(
                                                homeCubit.profileImage!),
                                          ),
                                  ),
                                  IconButtonWidget(
                                    icon: Icons.camera_alt_rounded,
                                    radius: 5.w,
                                    size: 5.w,
                                    onpressed: () {
                                      homeCubit.getProfileImage(context,
                                          height: 5.h, width: 85.w);
                                    },
                                  ),
                                ],
                              ),
                              Align(
                                alignment: (lang == 'en')
                                    ? AlignmentDirectional.topStart
                                    : AlignmentDirectional.topEnd,
                                child: Padding(
                                  padding: EdgeInsets.all(2.w),
                                  child: IconButtonWidget(
                                    icon: (lang == 'ar')
                                        ? Icons.arrow_forward
                                        : Icons.arrow_back,
                                    radius: 5.w,
                                    size: 5.w,
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
                          height: 2.h,
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
                          height: 2.h,
                        ),

                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 2.w),
                          child: Row(
                            children: [
                              TextWidget(
                                fontWeight: FontWeight.bold,
                                isSmallText: true,
                                text: "name_hint".tr + " : ",
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
                          padding: EdgeInsets.symmetric(horizontal: 2.w),
                          child: Row(
                            children: [
                              TextWidget(
                                fontWeight: FontWeight.bold,
                                isSmallText: true,
                                text: "my_location".tr + " : ",
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
                          height: 2.h,
                        ),

                        Align(
                          alignment: AlignmentDirectional.bottomCenter,
                          child: CommonButton(
                            text: 'edit_profile'.tr,
                            width: 85.w,
                            containerColor: buttonColor,
                            textColor: buttonTextColor,
                            onTap: () {
                              AppCubit.get(context)
                                  .updateProfile(
                                      imageFile: homeCubit.profileImage,
                                      userName: userNameController.text.isEmpty
                                          ? userModel.username
                                          : userNameController.text,
                                      location: locationController.text.isEmpty
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
                          height: 2.h,
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
  }
}
