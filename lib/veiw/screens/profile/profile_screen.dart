import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:jiffy/jiffy.dart';
import 'package:qattan/constant.dart';
import 'package:qattan/controller/cached_helper/cached_helper.dart';
import 'package:qattan/controller/cached_helper/key_constant.dart';
import 'package:qattan/controller/cubit/App_cubit.dart';
import 'package:qattan/controller/cubit_states/app_states.dart';
import 'package:qattan/controller/language_helper/language_controller.dart';
import 'package:qattan/features/responsive_setup/responsive_builder.dart';
import 'package:qattan/veiw/component_widget/cached_network_Image_widget.dart';
import 'package:qattan/veiw/component_widget/icon_button_widget.dart';
import 'package:qattan/veiw/component_widget/loading_progress_indecator.dart';
import 'package:qattan/veiw/component_widget/navigator.dart';
import 'package:qattan/veiw/screens/auth/log_in.dart';
import 'package:qattan/veiw/screens/favorite/favorite_screen.dart';
import 'package:get/get.dart';
import 'package:qattan/veiw/screens/orders/orders_screen.dart';
import 'package:qattan/veiw/screens/profile/profile_data.dart';

class ProfilScreen extends StatelessWidget {
  final bool? showBack;

  ProfilScreen({this.showBack = false});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          var profileData = AppCubit.get(context).profilModel?.data!;
          return ResponsiveBuilder(
            builder: (context, sizeConfig) {
              final height = sizeConfig.screenHeight!;
              final width = sizeConfig.screenWidth!;
              return userId == null
                  ? showFlutterToast(message: "refresh".tr)
                  : (profileData == null)
                      ? LoadingProgressIndecator()
                      : Scaffold(
                          body: Container(
                            width: width,
                            height: height,
                            child: Stack(
                              children: [
                                Container(
                                  width: width,
                                  height: height * 0.35,
                                  color: Colors.grey[200],
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: height * 0.08,
                                      ),
                                      CircleAvatar(
                                        radius: width * 0.11,
                                        child: CircleAvatar(
                                          radius: width * 0.1,
                                          child: ClipOval(
                                            child: CachedNetworkImageWidget(
                                              // width: width * 0.2,
                                              // height: height * 0.11,
                                              image: profileData.profileImage,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: height * 0.01,
                                      ),
                                      Text("${profileData.username}"),
                                      SizedBox(
                                        height: height * 0.01,
                                      ),
                                      Text("${profileData.email}"),
                                      SizedBox(
                                        height: height * 0.01,
                                      ),
                                    ],
                                  ),
                                ),
                                Align(
                                  alignment: AlignmentDirectional.bottomCenter,
                                  child: Container(
                                    width: width,
                                    height: height * 0.61,
                                    // color: Colors.amber[100],
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          ProfileItem(
                                            height: height,
                                            width: width,
                                            iconSelect: true,
                                            icon: Icons.person,
                                            // image: 'asset/images/Profil_Icon.png',
                                            title: "my_account".tr,
                                            onTap: () {
                                              goTo(
                                                  context,
                                                  ProfileDataScreen(
                                                    profileData: profileData,
                                                  ));
                                            },
                                          ),
                                          ProfileItem(
                                            height: height,
                                            width: width,
                                            iconSelect: true,
                                            icon: Icons.shopping_basket,
                                            // image: 'asset/images/list order_Icon.png',
                                            title: "my_orders".tr,
                                            onTap: () async {
                                              await Jiffy.locale(
                                                  CachedHelper.getData(
                                                      key: languageKey));
                                              AppCubit.get(context)
                                                  .getOrders()
                                                  .then((value) => goTo(
                                                      context, OrdersScreen()));
                                            },
                                          ),
                                          ProfileItem(
                                            height: height,
                                            width: width,
                                            iconSelect: true,
                                            icon: Icons.favorite_border,
                                            // image: 'asset/images/love_Icon 3.png',
                                            title: "my_favorites".tr,
                                            onTap: () {
                                              goTo(context, FavoritScreen());
                                            },
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: ProfileItem(
                                                  height: height,
                                                  width: width - width * 0.02,
                                                  iconSelect: true,
                                                  icon: Icons.settings,
                                                  // image: 'asset/images/settings.png',
                                                  title: "log_out".tr,
                                                  onTap: () {
                                                    showAlertDailog(
                                                      context: context,
                                                      titlle: "log_out".tr,
                                                      message:
                                                          "are_you_sure_?".tr,
                                                      labelNo: "no".tr,
                                                      labelYes: "yes".tr,
                                                      onPressNo: () =>
                                                          back(context),
                                                      onPressYes: () {
                                                        CachedHelper.removeData(
                                                            key: loginTokenId);
                                                        userId = '';
                                                        // back(context);
                                                        AppCubit.get(context)
                                                            .currentIndex = 0;
                                                        goToAndFinish(
                                                            context, LogIn());
                                                      },
                                                    );
                                                  },
                                                ),
                                              ),
                                              Expanded(
                                                child: GetBuilder<
                                                    LanguageController>(
                                                  init: LanguageController(),
                                                  builder: (controller) => Card(
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            horizontal:
                                                                width * 0.04,
                                                            vertical:
                                                                height * 0.01),
                                                    child: Padding(
                                                      padding: EdgeInsets.all(
                                                          width * 0.018),
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                            Icons.language,
                                                            size:
                                                                height * 0.045,
                                                            color: mainColor,
                                                          ),
                                                          SizedBox(
                                                            width: width * 0.04,
                                                          ),
                                                          DropdownButton(
                                                            underline:
                                                                SizedBox(),
                                                            icon: SizedBox(),
                                                            // icon: Icon(
                                                            //   Icons.language,
                                                            //   size: height * 0.045,
                                                            //   color: mainColor,
                                                            // ),
                                                            items: [
                                                              DropdownMenuItem(
                                                                child: Text(
                                                                    "EN".tr),
                                                                value: 'en',
                                                              ),
                                                              DropdownMenuItem(
                                                                child: Text(
                                                                    "AR".tr),
                                                                value: 'ar',
                                                              ),
                                                            ],
                                                            value: controller
                                                                .localLanguage,
                                                            onChanged: (String?
                                                                value) {
                                                              controller
                                                                  .toggleLanguge(
                                                                      value!);
                                                              Get.updateLocale(
                                                                  Locale(
                                                                      value));
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                if (AppCubit.get(context).currentIndex == 0)
                                  Padding(
                                    padding:
                                        EdgeInsets.only(top: height * 0.04),
                                    child: Align(
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
                                  ),
                              ],
                            ),
                          ),
                        );
            },
          );
        });
  }
}

class ProfileItem extends StatelessWidget {
  const ProfileItem({
    required this.height,
    required this.width,
    this.image,
    required this.title,
    this.onTap,
    this.icon,
    this.iconSelect = false,
  });

  final double height;
  final double width;
  final String? image;
  final String title;
  final bool? iconSelect;
  final IconData? icon;

  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        margin: EdgeInsets.symmetric(
            horizontal: width * 0.04, vertical: height * 0.01),
        child: Padding(
          padding: EdgeInsets.all(width * 0.01),
          child: ListTile(
            leading: iconSelect!
                ? Icon(
                    icon,
                    size: height * 0.045,
                    color: mainColor,
                  )
                : Image.asset(
                    image!,
                    fit: BoxFit.fill,
                    height: height * 0.035,
                    width: width * 0.07,
                  ),
            // leading: Image.asset(
            //   image,
            //   fit: BoxFit.fill,
            //   height: height * 0.035,
            //   width: width * 0.07,
            // ),
            title: Text(title),
          ),
        ),
      ),
    );
  }
}
