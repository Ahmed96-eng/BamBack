import 'package:flutter/material.dart';
import 'package:qattan/constant.dart';
import 'package:qattan/model/category_model.dart';
import 'package:qattan/veiw/component_widget/cached_network_Image_widget.dart';
import 'package:qattan/veiw/component_widget/style.dart';

import '../text_widget.dart';

class CategoryItem extends StatelessWidget {
  CategoryItem({
    required this.height,
    required this.width,
    this.showItemCount = false,
    // required this.title,
    required this.categoryData,
    this.onTap,
  });

  final double height;
  final double width;
  final bool showItemCount;
  final GestureTapCallback? onTap;

  final CategoryData categoryData;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        margin: EdgeInsets.all(5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              // padding: EdgeInsets.all(8),
              // decoration: BoxDecoration(border: Border.all(color: Colors.white)),
              child: Container(
                width: width,
                height: height,
                child: ClipOval(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: CachedNetworkImageWidget(
                    image: categoryData.image,
                    boxFit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            //   Container(
            //     child: Image.asset(
            //       'asset/images/sock_cat.png',
            //       fit: BoxFit.fill,
            //       height: height * 0.25,
            //       width: width * 0.15,
            //     ),
            //   ),
            // ),
            // SizedBox(
            //   height: height * 0.02,
            // ),
            SizedBox(
              width: width * 0.1,
            ),
            // Text(
            //   categoryData.title ?? "",
            //   maxLines: 2,
            //   textAlign: TextAlign.center,
            //   style: fourthLineStyle,
            // ),
            TextWidget(
              text: categoryData.title ?? "",
              isLargeText: true,
              color: mainColor!,
              textOverflow: TextOverflow.ellipsis,
            ),
            if (showItemCount) ...[
              SizedBox(
                height: height * 0.01,
              ),
              Text(
                categoryData.noProducts ?? "0",
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
