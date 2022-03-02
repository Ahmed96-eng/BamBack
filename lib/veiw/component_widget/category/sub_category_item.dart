import 'package:flutter/material.dart';
import 'package:qattan/model/sub_category_model.dart';
import 'package:qattan/veiw/component_widget/cached_network_Image_widget.dart';
import 'package:qattan/veiw/component_widget/text_widget.dart';

class SubCategoryItem extends StatelessWidget {
  SubCategoryItem({
    required this.height,
    required this.width,
    this.subcategoryData,
    this.onTap,
  });

  final double height;
  final double width;

  final SubCategoryData? subcategoryData;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width * 0.27,
        // margin: EdgeInsets.all(5),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              // padding: EdgeInsets.all(8),
              // decoration: BoxDecoration(border: Border.all(color: Colors.white)),
              child: Container(
                width: width * 0.15,
                height: height * 0.2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(width * .02),
                ),
                child: CachedNetworkImageWidget(
                  borderRadius: BorderRadius.circular(width * .02),
                  image: subcategoryData!.image,
                ),
              ),
            ),
            // SizedBox(
            //   height: height * 0.02,
            // ),
            TextWidget(
              text: subcategoryData!.title ?? "",
              isSmallText: true, fontWeight: FontWeight.w500,
              // maxLines: 2,
              // textAlign: TextAlign.center,
            ),
            // Text(
            //   subcategoryData!.noProducts!,
            //   textAlign: TextAlign.center,
            // ),
            // if (showItemCount) ...[
            //   SizedBox(
            //     height: height * 0.01,
            //   ),
            // Text(
            //   subcategoryData!.noProducts ?? "0",
            //   textAlign: TextAlign.center,
            // ),
            // ],
          ],
        ),
      ),
    );
  }
}
