import 'package:flutter/material.dart';
import 'package:qattan/model/popular_product_model.dart';
import 'package:qattan/veiw/component_widget/cached_network_Image_widget.dart';
import 'package:qattan/veiw/component_widget/rating_widget.dart';
import 'package:get/get.dart';
import 'package:qattan/veiw/component_widget/text_widget.dart';
import 'package:qattan/veiw/screens/auth/log_in.dart';

import '../../../constant.dart';
import '../navigator.dart';

class PopularItem extends StatelessWidget {
  PopularItem({
    required this.width,
    required this.height,
    required this.index,
    this.homeData,
    this.onTap,
    this.favoritePressed,
    this.favColor,
  });

  final double width;
  final double height;
  final int index;
  final PopularProductData? homeData;
  final GestureTapCallback? onTap;
  final VoidCallback? favoritePressed;
  final Color? favColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        // height: height * 0.2,
        // color: Colors.red,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          // mainAxisAlignment: ,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                Container(
                  width: width,
                  height: index.isEven ? height * 0.95 : height * 0.5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(width * .04),
                  ),
                  child: CachedNetworkImageWidget(
                    borderRadius: BorderRadius.circular(width * .02),
                    image: homeData!.productImage,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(width * 0.02),
                  child: CircleAvatar(
                    radius: width * 0.09,
                    child: IconButton(
                      onPressed: (userId == null)
                          ? () => showAlertDailog(
                              context: context,
                              titlle: "".tr,
                              message: "please_sign_in".tr,
                              labelNo: "no".tr,
                              labelYes: "sign_in".tr,
                              onPressNo: () {
                                back(context);
                              },
                              onPressYes: () {
                                goTo(context, LogIn());
                              })
                          : favoritePressed,
                      icon: Icon(
                        Icons.favorite_border,
                        size: width * 0.08,
                        // color: Color(0xff7BCFE9),
                        color: favColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: width * 0.01,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget(
                    text: homeData!.productName ?? "",
                    isSmallText: true,
                    textOverflow: TextOverflow.ellipsis,
                  ),
                  // SizedBox(
                  //   height: height * 0.005,
                  // ),
                  TextWidget(
                    text: '${homeData!.price}' + "sar".tr,
                    isSmallText: true,
                  ),
                  SizedBox(
                    height: height * 0.005,
                  ),
                  Row(
                    children: [
                      RatingMethodWidget(
                        width: width,
                        initialRating: (homeData!.rate!).toDouble(),
                      ),
                      TextWidget(
                        text: '(${homeData!.rate!})',
                        isSmallText: true,
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: width * 0.01,
            ),
          ],
        ),
      ),
    );
  }
}
