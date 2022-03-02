import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qattan/controller/cubit/App_cubit.dart';
import 'package:qattan/controller/cubit_states/app_states.dart';
import 'package:qattan/features/responsive_setup/responsive_builder.dart';
import 'package:qattan/model/profile_model.dart';
import 'package:qattan/veiw/component_widget/cached_network_Image_widget.dart';
import 'package:qattan/veiw/component_widget/common_button.dart';
import 'package:qattan/veiw/component_widget/icon_button_widget.dart';
import 'package:qattan/veiw/component_widget/navigator.dart';
import 'package:get/get.dart';
import 'package:qattan/veiw/component_widget/text_widget.dart';
import 'package:qattan/veiw/screens/auth/set_new_password.dart';
import 'package:qattan/veiw/screens/profile/edit_profile_data.dart';
import 'package:sizer/sizer.dart';

import '../../../constant.dart';

class ProfileDataScreen extends StatelessWidget {
  // var nameController = TextEditingController();
  // var locationController = TextEditingController();
  // var phoneController = TextEditingController();
  final ProfileData? profileData;

  ProfileDataScreen({this.profileData});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        // var userModel = AppCubit.get(context).profilModel!.data!;
        // var homeCubit = AppCubit.get(context);
        // nameController.text = userModel.username!;
        // phoneController.text = userModel.phone!;
        // locationController.text = userModel.location!;
        return SafeArea(
          child: Scaffold(
            body: Container(
              height: 100.h,
              width: 100.w,
              child: ListView(
                children: [
                  Container(
                    height: 30.h,
                    child: Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Container(
                            height: 30.h,
                            width: double.infinity,
                            color: Colors.black12,
                          ),
                        ),
                        CircleAvatar(
                            radius: 15.w,
                            child:
                                //  homeCubit.profileImage == null
                                //     ?
                                CircleAvatar(
                              radius: 14.w,
                              child: ClipOval(
                                child: CachedNetworkImageWidget(
                                  // width: width * 0.32,
                                  // height: height * 0.18,
                                  image: "${profileData!.profileImage}",
                                ),
                              ),
                            )
                            // : CircleAvatar(
                            //     backgroundColor: Colors.amber,
                            //     radius: 50,
                            //     backgroundImage:
                            //         FileImage(homeCubit.profileImage),
                            // ),
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
                                back(context);
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
                  PrpfileDataTile(
                    width: 100.w,
                    height: 100.h,
                    title: "name_hint".tr,
                    subTitle: profileData!.username,
                  ),
                  PrpfileDataTile(
                    width: 100.w,
                    height: 100.h,
                    title: "phone_hint".tr,
                    subTitle: profileData!.phone,
                  ),
                  PrpfileDataTile(
                    width: 100.w,
                    height: 100.h,
                    title: "email_hint".tr,
                    subTitle: profileData!.email,
                  ),
                  PrpfileDataTile(
                    width: 100.w,
                    height: 100.h,
                    title: "address_hint".tr,
                    subTitle:
                        "${profileData!.region} - ${profileData!.city} - ${profileData!.location} ",
                  ),
                  SizedBox(
                    height: 2.w,
                  ),
                  Align(
                    alignment: AlignmentDirectional.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.all(4.w),
                      child: Column(
                        children: [
                          CommonButton(
                            text: 'edit_profile'.tr,
                            width: 85.w,
                            containerColor: buttonColor,
                            textColor: buttonTextColor,
                            onTap: () {
                              goTo(context, EditProfileDataScreen());
                            },
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          CommonButton(
                            text: 'change_password'.tr,
                            width: 85.w,
                            containerColor: buttonColor,
                            textColor: buttonTextColor,
                            onTap: () {
                              goTo(context, SetNewPassword());
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class PrpfileDataTile extends StatelessWidget {
  const PrpfileDataTile({
    required this.width,
    this.title,
    this.subTitle,
    this.height,
  });

  final double? width;
  final double? height;
  final String? title;
  final String? subTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(width! * 0.05)),
      padding: EdgeInsets.all(width! * 0.03),
      margin: EdgeInsets.symmetric(
          horizontal: width! * 0.08, vertical: height! * 0.01),
      child: Wrap(
        alignment: WrapAlignment.start,
        crossAxisAlignment: WrapCrossAlignment.start,
        children: [
          TextWidget(
            text: "$title" + " : ",
            isSmallText: true,
            fontWeight: FontWeight.bold,
          ),
          TextWidget(
            text: subTitle!,
            isSmallText: true,
          ),
        ],
      ),
    );
  }
}
