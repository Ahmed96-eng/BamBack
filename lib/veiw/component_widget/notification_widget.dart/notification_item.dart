import 'package:flutter/material.dart';
import 'package:qattan/model/offers_products_model.dart';
import 'package:qattan/veiw/component_widget/cached_network_Image_widget.dart';

import '../text_widget.dart';

class NotificationItem extends StatelessWidget {
  NotificationItem({
    required this.width,
    required this.height,
    required this.offersProductData,
    this.onTap,
  });

  final double width;
  final double height;
  final OffersProductData? offersProductData;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        // decoration: BoxDecoration(
        //     color: Colors.black12,
        //     border: Border.all(),
        //     borderRadius: BorderRadius.circular(width * .02)),
        padding: EdgeInsets.all(width * 0.02),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Container(
            //   decoration: BoxDecoration(
            //       color: Colors.black12,
            //       border: Border.all(),
            //       borderRadius: BorderRadius.circular(width * .02)),
            // width: width * 0.15,
            // height: height * 0.7,
            // ),

            Stack(
              alignment: AlignmentDirectional.topEnd,
              children: [
                Container(
                  width: width * 0.3,
                  height: height,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(width * .02),
                  ),
                  child: CachedNetworkImageWidget(
                    borderRadius: BorderRadius.circular(width * .02),
                    image: offersProductData!.productImage,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.02),
                  child: Container(
                    height: height * 0.3,
                    width: width * 0.08,
                    child: Stack(
                      alignment: AlignmentDirectional.center,
                      children: [
                        Image.asset(
                          'asset/images/discount_banner.png',
                          fit: BoxFit.fill,
                          height: height * 0.3,
                          width: width * 0.08,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextWidget(
                              fontWeight: FontWeight.w500,
                              isSmallText: true,
                              text: "Disc",
                            ),
                            TextWidget(
                              fontWeight: FontWeight.w500,
                              isSmallText: true,
                              text: "${offersProductData!.discount}%",
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(
              width: width * 0.02,
            ),
            TextWidget(
                fontWeight: FontWeight.bold,
                isSmallText: true,
                text: offersProductData!.productName!),
            // SizedBox(
            //   height: height * 0.02,
            // ),
          ],
        ),
      ),
    );
  }
}
