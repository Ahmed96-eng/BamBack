import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qattan/constant.dart';
import 'package:qattan/controller/cubit/App_cubit.dart';
import 'package:qattan/controller/cubit_states/app_states.dart';
import 'package:qattan/features/responsive_setup/responsive_builder.dart';
import 'package:get/get.dart';
import 'package:qattan/veiw/component_widget/loading_progress_indecator.dart';
import 'package:qattan/veiw/component_widget/navigator.dart';
import 'package:qattan/veiw/component_widget/no_data_widget.dart';
import 'package:qattan/veiw/component_widget/notification_widget.dart/notification_item.dart';
import 'package:qattan/veiw/screens/home/product_details.dart';

class NotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, sizeConfig) {
      final height = sizeConfig.screenHeight!;
      final width = sizeConfig.screenWidth!;
      var productOffers = AppCubit.get(context).offersProductModel?.data;

      return BlocConsumer<AppCubit, AppState>(
          listener: (context, state) {},
          builder: (context, state) {
            return RefreshIndicator(
              color: mainColor,
              onRefresh: () async {
                AppCubit.get(context).getOffersProducts();
              },
              child: SafeArea(
                child: Scaffold(
                  appBar: AppBar(
                    elevation: 0,
                    centerTitle: true,
                    title: Text("notification_screen".tr),
                    leading: Container(),
                    // leading: (lang == 'en')
                    //     ? Padding(
                    //         padding: EdgeInsets.all(width * 0.03),
                    //         child: IconButtonWidget(
                    //           icon: (lang == 'ar')
                    //               ? Icons.arrow_forward
                    //               : Icons.arrow_back,
                    //           radius: width * 0.05,
                    //           size: width * 0.05,
                    //           onpressed: () {
                    //             back(context);
                    //           },
                    //         ),
                    //       )
                    //     : Container(),
                    // actions: [
                    //   if ((lang == 'ar'))
                    //     Padding(
                    //       padding: EdgeInsets.all(width * 0.03),
                    //       child: IconButtonWidget(
                    //         icon: (lang == 'ar')
                    //             ? Icons.arrow_forward
                    //             : Icons.arrow_back,
                    //         radius: width * 0.05,
                    //         size: width * 0.05,
                    //         onpressed: () {
                    //           back(context);
                    //         },
                    //       ),
                    //     )
                    // ],
                  ),
                  body: (productOffers == null)
                      ? LoadingProgressIndecator()
                      : AppCubit.get(context).offersNotification.length == 0
                          ? Align(
                              alignment: AlignmentDirectional.center,
                              child: Container(
                                height: height * 0.5,
                                child: NoDataWidget(
                                  width: width * 1.5,
                                  height: height * 0.5,
                                ),
                              ),
                            )
                          : Container(
                              width: width,
                              height: height,
                              child: ListView.builder(
                                itemCount: productOffers.length,
                                itemBuilder: (context, index) {
                                  DateTime now = DateTime.now();
                                  var productDateTime =
                                      productOffers[index].createdAt;
                                  DateTime t = DateTime.parse(productDateTime!)
                                      .add(Duration(days: 1));
                                  // print(now);
                                  // print("t");
                                  // print(t);
                                  // print('old');
                                  // print(productDateTime);
                                  // print(';;;;;;;;;;');
                                  return now.isAfter(t)
                                      ? Container()
                                      : Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding:
                                                  EdgeInsets.all(width * 0.01),
                                              child: NotificationItem(
                                                width: width,
                                                height: height * 0.2,
                                                offersProductData:
                                                    productOffers[index],
                                                onTap: () {
                                                  AppCubit.get(context)
                                                      .getHomeProductDetails(
                                                          productOffers[index]
                                                              .id
                                                              .toString())
                                                      .then((value) {
                                                    print(
                                                        ',,,,,,,,,,,,,,,,,,,,,');
                                                    print(value);
                                                    goTo(context,
                                                        ProductDetails());
                                                  });
                                                },
                                              ),
                                            ),
                                            Divider(),
                                          ],
                                        );
                                },
                              ),
                            ),
                ),
              ),
            );
          });
    });
  }
}
