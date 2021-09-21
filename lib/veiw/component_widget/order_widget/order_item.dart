import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:qattan/constant.dart';
import 'package:qattan/model/orders_model.dart';
import 'package:qattan/veiw/component_widget/wrap_widget.dart';
import 'package:get/get.dart';

class OrderItem extends StatelessWidget {
  const OrderItem({
    required this.width,
    required this.height,
    this.ordersData,
  });

  final double width;
  final double height;
  final OrdersData? ordersData;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      // decoration: BoxDecoration(
      //     color: Colors.black12,
      //     border: Border.all(),
      //     borderRadius: BorderRadius.circular(width * .02)),
      padding: EdgeInsets.all(width * 0.02),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.shopping_basket,
                size: height * 0.5,
                color: mainColor,
              ),
              SizedBox(
                width: width * 0.03,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    WrapWidget(
                      width: width,
                      height: height,
                      constantTitle: "order_id".tr,
                      title: ordersData!.id!,
                      isOrder: true,
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    WrapWidget(
                      width: width,
                      height: height,
                      constantTitle: "order_total_price".tr,
                      title: "${ordersData!.total!}" + "sar".tr,
                      isOrder: true,
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    WrapWidget(
                      width: width,
                      height: height,
                      constantTitle: "order_date".tr,
                      title: Jiffy(ordersData!.createdAt!).yMMMMEEEEdjm,
                      isOrder: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
          // SizedBox(
          //   height: height * 0.04,
          // ),
        ],
      ),
    );
  }
}
