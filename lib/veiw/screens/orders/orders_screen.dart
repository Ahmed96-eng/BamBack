import 'package:flutter/material.dart';
import 'package:qattan/controller/cubit/App_cubit.dart';
import 'package:qattan/veiw/component_widget/app_bar_widget.dart';
import 'package:qattan/veiw/component_widget/loading_progress_indecator.dart';
import 'package:get/get.dart';
import 'package:qattan/veiw/component_widget/no_data_widget.dart';
import 'package:qattan/veiw/component_widget/order_widget/order_item.dart';
import 'package:sizer/sizer.dart';

class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(8.h),
          child: AppBarWidgets(
            title: "order_screen".tr,
            width: 100.w,
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
                    height: 50.h,
                    child: NoDataWidget(
                      width: 150.w,
                      height: 50.h,
                    ),
                  ),
                )
              : Container(
                  width: 100.w,
                  height: 100.h,
                  child: ListView.builder(
                    itemCount: AppCubit.get(context).ordersModel!.data!.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.all(1.w),
                        child: Column(
                          children: [
                            OrderItem(
                              width: 100.w,
                              height: 17.h,
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
  }
}
