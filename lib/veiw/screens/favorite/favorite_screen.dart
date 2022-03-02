import 'package:flutter/material.dart';
import 'package:qattan/controller/cubit/App_cubit.dart';
import 'package:qattan/features/responsive_setup/responsive_builder.dart';
import 'package:qattan/veiw/component_widget/app_bar_widget.dart';
import 'package:qattan/veiw/component_widget/favorite_widget/favorite_item.dart';
import 'package:qattan/veiw/component_widget/navigator.dart';
import 'package:get/get.dart';
import 'package:qattan/veiw/component_widget/no_data_widget.dart';
import 'package:qattan/veiw/screens/home/product_details.dart';
import 'package:sizer/sizer.dart';

class FavoritScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(8.h),
          child: AppBarWidgets(
            title: "favorite_screen".tr,
            width: 100.w,
          )),
      // appBar: AppBar(
      //   elevation: 0,
      //   centerTitle: true,
      //   title: Text("favorite_screen".tr),
      //   leading: (lang == 'en')
      //       ? Padding(
      //           padding: EdgeInsets.all(width * 0.03),
      //           child: IconButtonWidget(
      //             icon: (CachedHelper.getData(key: languageKey) == 'ar')
      //                 ? Icons.arrow_forward
      //                 : Icons.arrow_back,
      //             radius: width * 0.05,
      //             size: width * 0.05,
      //             onpressed: () {
      //               back(context);
      //             },
      //           ),
      //         )
      //       : Container(),
      //   actions: [
      //     if ((CachedHelper.getData(key: languageKey) == 'ar'))
      //       Padding(
      //         padding: EdgeInsets.all(width * 0.03),
      //         child: IconButtonWidget(
      //           icon: (CachedHelper.getData(key: languageKey) == 'ar')
      //               ? Icons.arrow_forward
      //               : Icons.arrow_back,
      //           radius: width * 0.05,
      //           size: width * 0.05,
      //           onpressed: () {
      //             back(context);
      //           },
      //         ),
      //       )
      //   ],
      // ),
      body: AppCubit.get(context).favorites.length == 0
          ? Align(
              alignment: AlignmentDirectional.center,
              child: Container(
                  width: 100.w,
                  height: 50.h,
                  child: NoDataWidget(
                    width: 150.w,
                    height: 50.h,
                  )),
            )
          : Container(
              width: 100.w,
              height: 100.h,
              child: ListView.builder(
                itemCount: AppCubit.get(context).favorites.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.all(1.w),
                    child: FavoriteItem(
                      width: 100.w,
                      height: 20.h,
                      favoriteModel: AppCubit.get(context).favorites[index],
                      onTap: () {
                        AppCubit.get(context)
                            .getHomeProductDetails(AppCubit.get(context)
                                .favorites[index]
                                .favId
                                .toString())
                            .then((value) {
                          print(',,,,,,,,,,,,,,,,,,,,,');

                          goTo(context, ProductDetails());
                        });
                      },
                    ),
                  );
                },
              ),
            ),
    );
  }
}
