import 'package:flutter/material.dart';
import 'package:qattan/controller/cubit/App_cubit.dart';
import 'package:qattan/features/responsive_setup/responsive_builder.dart';
import 'package:qattan/veiw/component_widget/app_bar_widget.dart';
import 'package:qattan/veiw/component_widget/loading_progress_indecator.dart';
import 'package:get/get.dart';
import 'package:qattan/veiw/component_widget/no_data_widget.dart';
import 'package:qattan/veiw/component_widget/order_widget/order_item.dart';

class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, sizeConfig) {
      final height = sizeConfig.screenHeight!;
      final width = sizeConfig.screenWidth!;
      return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(height * 0.1),
            child: AppBarWidgets(
              title: "order_screen".tr,
              width: width,
            )),
        // appBar: AppBar(
        //   elevation: 0,
        //   centerTitle: true,
        //   title: Text("order_screen".tr),
        //   leading: (lang == 'en')
        //       ? Padding(
        //           padding: EdgeInsets.all(width * 0.03),
        //           child: IconButtonWidget(
        //             icon:
        //                 (lang == 'ar') ? Icons.arrow_forward : Icons.arrow_back,
        //             radius: width * 0.05,
        //             size: width * 0.05,
        //             onpressed: () {
        //               back(context);
        //             },
        //           ),
        //         )
        //       : Container(),
        //   actions: [
        //     if ((lang == 'ar'))
        //       Padding(
        //         padding: EdgeInsets.all(width * 0.03),
        //         child: IconButtonWidget(
        //           icon: (lang == 'ar') ? Icons.arrow_forward : Icons.arrow_back,
        //           radius: width * 0.05,
        //           size: width * 0.05,
        //           onpressed: () {
        //             back(context);
        //           },
        //         ),
        //       )
        //   ],
        // ),

        body: AppCubit.get(context).ordersModel!.data == null
            ? LoadingProgressIndecator()
            : AppCubit.get(context).ordersModel!.data!.length == 0
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
                      itemCount:
                          AppCubit.get(context).ordersModel!.data!.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.all(width * 0.01),
                          child: Column(
                            children: [
                              OrderItem(
                                width: width,
                                height: height * 0.17,
                                ordersData: AppCubit.get(context)
                                    .ordersModel!
                                    .data![index],
                              ),
                              Divider(
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
      );
    });
  }
}
