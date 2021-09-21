import 'package:flutter/material.dart';
import 'package:qattan/model/search_model.dart';
import 'package:qattan/veiw/component_widget/cached_network_Image_widget.dart';
import 'package:get/get.dart';

class SearchProductItem extends StatelessWidget {
  const SearchProductItem({
    required this.width,
    required this.height,
    required this.index,
    required this.searchData,
    this.onTap,
  });

  final double width;
  final double height;
  final int index;
  final SearchData? searchData;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
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
                    image: searchData!.productImage,
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
                  Text(searchData!.productName!),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Text('${searchData!.price!}' + "sar".tr),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  // Row(
                  //   children: [
                  //     RatingBar.builder(
                  //       itemSize: 15,
                  //       initialRating: 3.5,
                  //       minRating: 1,
                  //       direction: Axis.horizontal,
                  //       allowHalfRating: true,
                  //       itemCount: 5,
                  //       itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  //       itemBuilder: (context, _) => Icon(
                  //         Icons.star,
                  //         color: Colors.amber,
                  //       ),
                  //       onRatingUpdate: (rating) {
                  //         print(rating);
                  //       },
                  //     ),
                  //     Text('(3.5)'),
                  //   ],
                  // )
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