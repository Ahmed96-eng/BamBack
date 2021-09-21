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
import 'package:qattan/veiw/screens/auth/set_new_password.dart';
import 'package:qattan/veiw/screens/profile/edit_profile_data.dart';

import '../../../constant.dart';

class ProfileDataScreen extends StatelessWidget {
  // var nameController = TextEditingController();
  // var locationController = TextEditingController();
  // var phoneController = TextEditingController();
  final ProfileData? profileData;

  ProfileDataScreen({this.profileData});
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, sizeConfig) {
      final height = sizeConfig.screenHeight!;
      final width = sizeConfig.screenWidth!;
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
                height: height - 30,
                width: width,
                child: ListView(
                  children: [
                    Container(
                      height: height * 0.3,
                      child: Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          Align(
                            alignment: AlignmentDirectional.topCenter,
                            child: Container(
                              height: height * 0.4,
                              width: double.infinity,
                              color: Colors.black12,
                            ),
                          ),
                          CircleAvatar(
                              radius: width * 0.15,
                              child:
                                  //  homeCubit.profileImage == null
                                  //     ?
                                  CircleAvatar(
                                radius: width * 0.14,
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
                              padding: EdgeInsets.all(width * 0.02),
                              child: IconButtonWidget(
                                icon: (lang == 'ar')
                                    ? Icons.arrow_forward
                                    : Icons.arrow_back,
                                radius: width * 0.05,
                                size: width * 0.05,
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
                      height: 12,
                    ),
                    PrpfileDataTile(
                      width: width,
                      height: height,
                      title: "name_hint".tr,
                      subTitle: profileData!.username,
                    ),
                    PrpfileDataTile(
                      width: width,
                      height: height,
                      title: "phone_hint".tr,
                      subTitle: profileData!.phone,
                    ),
                    PrpfileDataTile(
                      width: width,
                      height: height,
                      title: "email_hint".tr,
                      subTitle: profileData!.email,
                    ),
                    PrpfileDataTile(
                      width: width,
                      height: height,
                      title: "address_hint".tr,
                      subTitle:
                          "${profileData!.region} - ${profileData!.city} - ${profileData!.location} ",
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Align(
                      alignment: AlignmentDirectional.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.all(width * 0.04),
                        child: Column(
                          children: [
                            CommonButton(
                              text: 'edit_profile'.tr,
                              width: width * 0.85,
                              containerColor: buttonColor,
                              textColor: buttonTextColor,
                              onTap: () {
                                goTo(context, EditProfileDataScreen());
                              },
                            ),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            CommonButton(
                              text: 'change_password'.tr,
                              width: width * 0.85,
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
                      height: height * 0.01,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    });
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
      padding: EdgeInsets.all(width! * 0.02),
      margin: EdgeInsets.symmetric(
          horizontal: width! * 0.08, vertical: height! * 0.01),
      child: Wrap(
        alignment: WrapAlignment.start,
        crossAxisAlignment: WrapCrossAlignment.start,
        children: [
          Text("$title" + " : "),
          Text(subTitle!),
        ],
      ),
    );
  }
}
