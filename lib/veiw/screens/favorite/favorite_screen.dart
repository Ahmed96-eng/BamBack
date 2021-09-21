import 'package:flutter/material.dart';
import 'package:qattan/controller/cubit/App_cubit.dart';
import 'package:qattan/features/responsive_setup/responsive_builder.dart';
import 'package:qattan/veiw/component_widget/app_bar_widget.dart';
import 'package:qattan/veiw/component_widget/favorite_widget/favorite_item.dart';
import 'package:qattan/veiw/component_widget/navigator.dart';
import 'package:get/get.dart';
import 'package:qattan/veiw/component_widget/no_data_widget.dart';
import 'package:qattan/veiw/screens/home/product_details.dart';

class FavoritScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, sizeConfig) {
      final height = sizeConfig.screenHeight!;
      final width = sizeConfig.screenWidth!;
      return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(height * 0.1),
            child: AppBarWidgets(
              title: "favorite_screen".tr,
              width: width,
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
                    width: width,
                    height: height * 0.5,
                    child: NoDataWidget(
                      width: width * 1.5,
                      height: height * 0.5,
                    )),
              )
            : Container(
                width: width,
                height: height,
                child: ListView.builder(
                  itemCount: AppCubit.get(context).favorites.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.all(width * 0.01),
                      child: FavoriteItem(
                        width: width,
                        height: height * 0.2,
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
    });
  }
}
