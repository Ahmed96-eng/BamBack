import 'package:flutter/material.dart';
import 'package:qattan/constant.dart';
import 'package:qattan/model/offers_products_model.dart';
import 'package:qattan/veiw/component_widget/cached_network_Image_widget.dart';
import 'package:get/get.dart';
import 'package:qattan/veiw/component_widget/style.dart';
import 'package:qattan/veiw/component_widget/text_widget.dart';
import 'package:sizer/sizer.dart';

class SaleDiscountItem extends StatelessWidget {
  SaleDiscountItem({
    required this.width,
    required this.height,
    this.offersProductData,
    this.onTap,
  });

  final double width;
  final double height;
  final GestureTapCallback? onTap;
  final OffersProductData? offersProductData;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width, height: height,
        // width: width * 0.32,
        // height: height * 0.2,
        // color: Colors.red,
        child: Stack(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.topEnd,
              children: [
                Container(
                  width: width,
                  height: height * 0.3,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(width * .02),
                  ),
                  child: GridTile(
                    child: CachedNetworkImageWidget(
                      borderRadius: BorderRadius.circular(width * .02),
                      image: offersProductData!.productImage,
                    ),
                    footer: Container(
                      width: width,
                      height: height * 0.08,
                      padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                      decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.circular(width * 0.02),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextWidget(
                            text: '${offersProductData!.productName}',
                            color: buttonTextColor!,
                            fontWeight: FontWeight.bold,
                            isSmallText: true,
                          ),
                          // Text(
                          //   '${offersProductData!.productName}',
                          //   maxLines: 1,
                          //   overflow: TextOverflow.ellipsis,
                          //   style: firstLineStyle,
                          // ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              TextWidget(
                                text: '${offersProductData!.sale}' + "sar".tr,
                                color: buttonTextColor!,
                                fontWeight: FontWeight.w600,
                                isSmallText: true,
                              ),
                              SizedBox(
                                width: width * 0.02,
                              ),
                              Text(
                                '${offersProductData!.price}' + "sar".tr,
                                // '${offersProductData!.price}',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: SizerUtil.deviceType ==
                                            DeviceType.mobile
                                        ? 10.sp
                                        : 8.sp,
                                    fontWeight: FontWeight.w600,
                                    decoration: TextDecoration.lineThrough),
                              ),

                              // SizedBox(
                              //   width: width * 0.01,
                              // ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                  child: Stack(
                    alignment: AlignmentDirectional.topStart,
                    children: [
                      Image.asset(
                        'asset/images/discount_banner.png',
                        fit: BoxFit.fill,
                        height: height * 0.08,
                        width: width * 0.1,
                      ),
                      Container(
                        height: height * 0.08,
                        width: width * 0.1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Disc",
                              style: TextStyle(
                                  fontSize: width * 0.02,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "${offersProductData!.discount}%",
                              style: TextStyle(
                                  fontSize: width * 0.02,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // SizedBox(
            //   height: height * 0.01,
            // ),
            // Text(
            //   '${offersProductData!.productName}',
            //   maxLines: 1,
            //   overflow: TextOverflow.ellipsis,
            // ),
            // SizedBox(
            //   height: height * 0.01,
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
            //   children: [
            //     Text(
            //       '${offersProductData!.sale}' + "sar".tr,
            //       textAlign: TextAlign.center,
            //     ),
            //     SizedBox(
            //       width: width * 0.02,
            //     ),
            //     Text(
            //       '${offersProductData!.price}',
            //       style: TextStyle(decoration: TextDecoration.lineThrough),
            //     ),
            //     // SizedBox(
            //     //   width: width * 0.01,
            //     // ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
