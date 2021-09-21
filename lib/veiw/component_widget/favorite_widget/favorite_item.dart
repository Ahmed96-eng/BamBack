import 'package:flutter/material.dart';
import 'package:qattan/model/favorite_model.dart';
import 'package:qattan/veiw/component_widget/cached_network_Image_widget.dart';
import 'package:get/get.dart';

class FavoriteItem extends StatelessWidget {
  const FavoriteItem({
    required this.width,
    required this.height,
    required this.favoriteModel,
    this.onTap,
  });

  final double width;
  final double height;
  final FavoriteModel favoriteModel;
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
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.black12,
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(width * .02)),
                  width: width * 0.3,
                  height: height * 0.72,
                  child: CachedNetworkImageWidget(
                    // image: '',
                    borderRadius: BorderRadius.circular(width * .02),
                    image: favoriteModel.prodImage,
                  ),
                ),
                SizedBox(
                  width: width * 0.02,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(favoriteModel.prodTitle!),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Text("${favoriteModel.prodPrice!}" + "sar".tr),
                      // SizedBox(
                      //   height: height * 0.02,
                      // ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: height * 0.04,
            ),
            Divider(
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
