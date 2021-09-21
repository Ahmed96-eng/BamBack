import 'package:flutter/material.dart';
import 'package:qattan/constant.dart';

class WrapWidget extends StatelessWidget {
  const WrapWidget({
    required this.width,
    required this.height,
    this.title,
    this.icon,
    this.isOrder = false,
    this.constantTitle,
  });

  final double width;
  final double height;
  final String? title;
  final IconData? icon;
  final String? constantTitle;
  final bool? isOrder;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: isOrder! ? height * 0.25 : height * 0.05,
      child: Wrap(
        alignment: WrapAlignment.start,
        crossAxisAlignment: WrapCrossAlignment.center,
        runSpacing: width * 0.03,
        spacing: width * 0.02,
        children: [
          isOrder!
              ? Text("${constantTitle!} : ")
              : Icon(
                  icon,
                  color: mainColor,
                ),
          // Image.asset(
          //   image!,
          //   fit: BoxFit.fill,
          //   height: height * 0.04,
          //   width: width * 0.07,
          // ),
          Text(title!),
        ],
      ),
    );
  }
}
