import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:qattan/veiw/component_widget/loading_progress_indecator.dart';

class CachedNetworkImageWidget extends StatelessWidget {
  final String? image;
  final double? height;
  final double? width;
  final BorderRadius? borderRadius;
  final BoxFit? boxFit;

  CachedNetworkImageWidget({
    this.image,
    this.height,
    this.width,
    this.borderRadius,
    this.boxFit = BoxFit.cover,
  });
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      height: height,
      width: width,
      // imageUrl: image!,
      imageUrl: "http://qatan-ksa.com/${image!}",
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          // border: Border.all(),
          borderRadius: borderRadius,
          image: DecorationImage(
            image: imageProvider,
            fit: boxFit,
            // colorFilter: ColorFilter.mode(Colors.red, BlendMode.colorBurn),
          ),
        ),
      ),
      placeholder: (context, url) => LoadingProgressIndecator(),
      errorWidget: (context, url, error) => Center(child: Icon(Icons.error)),
    );
  }
}
