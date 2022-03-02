import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:qattan/constant.dart';
import 'package:qattan/controller/cached_helper/cached_helper.dart';
import 'package:qattan/controller/cached_helper/key_constant.dart';
import 'package:qattan/controller/cubit/App_cubit.dart';
import 'package:qattan/controller/cubit_states/app_states.dart';
import 'package:qattan/controller/language_helper/language_controller.dart';
import 'package:qattan/veiw/component_widget/navigator.dart';
import 'package:sizer/sizer.dart';

class BotomNavBarLayout extends StatefulWidget {
  @override
  _BotomNavBarLayoutState createState() => _BotomNavBarLayoutState();
}

class _BotomNavBarLayoutState extends State<BotomNavBarLayout> {
  @override
  void initState() {
    setState(() {
      // AppCubit.get(context).getCategory();
      // AppCubit.get(context).getPopularProducts();
      // AppCubit.get(context).getOffersProducts();
      AppCubit.get(context).getProfile();
      AppCubit.get(context).getAllCarts();
      AppCubit.get(context).getAllFavorites();
      userId = CachedHelper.getData(key: loginTokenId);
      print("-----------------> $userId");
      // totalAmount = CachedHelper.getData(key: totalPriceKey);
      // CachedHelper.prefs!.reload();
      // totalPrice = CachedHelper.getData(key: totalPriceKey);
      print("The Total Cached 3 Price IS -->  $totalAmount");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Get.put(LanguageController());
    CachedHelper.getData(key: loginTokenId);
    print("userId After Auth is $userId ");

    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        // AppCubit.get(context).homeModel.data!.length;
        return WillPopScope(
          onWillPop: () {
            if (AppCubit.get(context).currentIndex == 0) {
              return showAlertDailog(
                context: context,
                titlle: "exit_application".tr,
                message: "are_you_sure_?".tr,
                labelNo: "no".tr,
                labelYes: "yes".tr,
                onPressNo: () => back(context),
                onPressYes: () => exit(0),
              );
            }
            AppCubit.get(context).filterExpand = false;
            AppCubit.get(context).categoryExpand = false;
            return AppCubit.get(context).willPopScop(context);
          },
          child: Scaffold(
            body: AppCubit.get(context)
                .screens[AppCubit.get(context).currentIndex],
            bottomNavigationBar: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
              child: Stack(
                children: [
                  Container(
                    height: 7.h,
                    // margin: EdgeInsets.only(
                    //     top: 3.h, left: 5.w, right: 5.w, bottom: 2.h),
                    decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(10.h)),
                  ),
                  BottomNavigationBar(
                    // enableFeedback: true,
                    type: BottomNavigationBarType.fixed,
                    currentIndex: AppCubit.get(context).currentIndex,
                    onTap: (value) {
                      AppCubit.get(context)
                          .changeBottomnavBarIndex(value, context);
                      if (value == 2) {
                        AppCubit.get(context).changeCategoryExpand(context);
                      }
                      if (value == 3) {
                        AppCubit.get(context).changeFilterExpand(context);
                      }
                    },
                    elevation: 0,
                    showSelectedLabels: false,
                    showUnselectedLabels: false,
                    backgroundColor: Colors.transparent,
                    selectedItemColor: mainColor,
                    unselectedItemColor: secondColor,
                    items: [
                      BottomNavigationBarItem(
                        icon: IconWidget(
                          icon: Icons.home,
                        ),
                        label: "",
                      ),
                      BottomNavigationBarItem(
                        icon: Stack(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          alignment: AlignmentDirectional.topStart,
                          children: [
                            IconWidget(
                              icon: Icons.notifications,
                            ),
                            CircleAvatar(
                              radius: 1.w,
                              backgroundColor: Colors.red,
                            )
                          ],
                        ),
                        label: "",
                      ),
                      BottomNavigationBarItem(
                        icon: IconWidget(
                          icon: Icons.category,
                        ),
                        label: "",
                      ),
                      BottomNavigationBarItem(
                        icon: IconWidget(
                          icon: Icons.filter_list,
                        ),
                        label: "",
                      ),
                      if (userId != null)
                        BottomNavigationBarItem(
                          icon: IconWidget(
                            icon: Icons.person,
                          ),
                          // icon: Image.asset(
                          //   'asset/images/Profil_Icon.png',
                          //   fit: BoxFit.fill,
                          //   height: 4.h,
                          //   color: AppCubit.get(context).current_index == 2
                          //       ? Color(0xff7BCFE9)
                          //       : null,

                          //   // width: 50,
                          // ),
                          label: "",
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },

      // PersistentTabView(
      //   context,
      //   controller: AppCubit.get(context).controller,
      //   screens: AppCubit.get(context).screens,
      //   hideNavigationBar: AppCubit.get(context).controller.index == 0
      //       ? false
      //       : AppCubit.get(context).controller.index == 1
      //           ? false
      //           : AppCubit.get(context).controller.index == 2
      //               ? false
      //               : true,

      //   items: [
      //     PersistentBottomNavBarItem(
      //       // icon: Image.asset(
      //       //   'asset/images/Home_button.png',
      //       //   fit: BoxFit.fill,
      //       //   height: height * 0.02,
      //       //   color: AppCubit.get(context).current_index == 0
      //       //       ? Color(0xff7BCFE9)
      //       //       : null,
      //       //   // width: 50,
      //       // ),

      // iconSize: height * 0.05,
      // icon: Icon(Icons.home),
      //       activeColorPrimary: Color(0xff7BCFE9),
      //       inactiveColorPrimary: Colors.grey[400],
      //     ),
      //     PersistentBottomNavBarItem(
      //       iconSize: height * 0.05,
      //       icon: Icon(Icons.notifications),
      //       activeColorPrimary: Color(0xff7BCFE9),
      //       inactiveColorPrimary: Colors.grey[400],
      //       // icon: Image.asset(
      //       //   'asset/images/Notification_button.png',
      //       //   fit: BoxFit.fill,
      //       //   height: height * 0.02,
      //       //   color: AppCubit.get(context).current_index == 1
      //       //       ? Color(0xff7BCFE9)
      //       //       : null,
      //       // ),
      //       // activeColorPrimary: CupertinoColors.activeBlue,
      //       // inactiveColorPrimary: CupertinoColors.systemGrey,
      //     ),
      //     PersistentBottomNavBarItem(
      //       iconSize: height * 0.05,
      //       icon: Icon(Icons.person),
      //       activeColorPrimary: Color(0xff7BCFE9),
      //       inactiveColorPrimary: Colors.grey[400],
      //       // icon: Image.asset(
      //       //   'asset/images/Profil_Icon.png',
      //       //   fit: BoxFit.fill,
      //       //   height: height * 0.02,
      //       //   color: AppCubit.get(context).current_index == 2
      //       //       ? Color(0xff7BCFE9)
      //       //       : null,
      //       // ),
      //       // activeColorPrimary: CupertinoColors.activeBlue,
      //       // inactiveColorPrimary: CupertinoColors.systemGrey,
      //     ),
      //   ],
      //   onItemSelected: (value) {
      //     AppCubit.get(context).changeBottomnavBarIndex(value);
      //   },
      //   confineInSafeArea: true,
      //   backgroundColor: Colors.white,
      //   handleAndroidBackButtonPress: true,
      //   resizeToAvoidBottomInset: true,
      //   stateManagement: true,
      //   hideNavigationBarWhenKeyboardShows:
      //       true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      //   decoration: NavBarDecoration(
      //     borderRadius: BorderRadius.circular(10.0),
      //     colorBehindNavBar: Colors.transparent,
      //   ),
      //   popAllScreensOnTapOfSelectedTab: true,
      //   popActionScreens: PopActionScreensType.all,
      //   itemAnimationProperties: ItemAnimationProperties(
      //     // Navigation Bar's items animation properties.
      //     duration: Duration(milliseconds: 200),
      //     curve: Curves.ease,
      //   ),
      //   screenTransitionAnimation: ScreenTransitionAnimation(
      //     // Screen transition animation on change of selected tab.
      //     animateTabTransition: true,
      //     curve: Curves.ease,
      //     duration: Duration(milliseconds: 200),
      //   ),
      //   navBarStyle: NavBarStyle
      //       .style6, // Choose the nav bar style with this property.
      // ),
    );
  }
}

class IconWidget extends StatelessWidget {
  const IconWidget({
    Key? key,
    this.icon,
  }) : super(key: key);
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      size: SizerUtil.deviceType == DeviceType.mobile ? 7.w : 5.w,
    );
  }
}
