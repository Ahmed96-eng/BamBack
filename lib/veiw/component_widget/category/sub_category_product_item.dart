import 'package:flutter/material.dart';
import 'package:qattan/model/sub_category_products_model.dart';
import 'package:qattan/veiw/component_widget/cached_network_Image_widget.dart';
import 'package:qattan/veiw/component_widget/rating_widget.dart';
import 'package:get/get.dart';

class SubCategoryProductItem extends StatelessWidget {
  SubCategoryProductItem({
    required this.width,
    required this.height,
    required this.index,
    this.productData,
    this.onTap,
  });

  final double width;
  final double height;
  final int index;
  final SubCategoryProductsData? productData;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        // color: Colors.red,
        // decoration: BoxDecoration(border: Border.all()),
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
                    borderRadius: BorderRadius.circular(width * .04),
                    image: productData!.productImage!,
                  ),
                ),
                // Padding(
                //   padding: EdgeInsets.all(width * 0.04),
                //   child: Image.asset(
                //     'asset/images/love_Icon 3.png',
                //     fit: BoxFit.fill,
                //     height: height * 0.07,
                //     width: width * 0.08,
                //   ),
                // ),
              ],
            ),
            SizedBox(
              width: width * 0.01,
            ),
            Container(
              width: width,
              height: height * 0.35,
              margin: EdgeInsets.all(width * 0.02),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Text(productData!.productName!),
                  // SizedBox(
                  //   height: height * 0.02,
                  // ),
                  Text('${productData!.price!}' + "sar".tr),
                  // SizedBox(
                  //   height: height * 0.02,
                  // ),
                  Row(
                    children: [
                      RatingMethodWidget(
                        width: width,
                        initialRating: (productData!.rate!).toDouble(),
                      ),
                      Text('(${productData!.rate!})'),
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
