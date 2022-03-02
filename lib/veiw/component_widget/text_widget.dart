import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class TextWidget extends StatelessWidget {
  const TextWidget({
    Key? key,
    required this.text,
    this.isSmallText = false,
    this.isLargeText = false,
    this.fontWeight = FontWeight.w400,
    this.color = Colors.black,
    this.textOverflow = TextOverflow.fade,
  }) : super(key: key);

  final String text;
  final bool isSmallText;
  final bool isLargeText;
  final FontWeight fontWeight;
  final Color color;
  final TextOverflow textOverflow;

  @override
  Widget build(BuildContext context) {
    return Text(
      text, overflow: textOverflow,
      style: SizerUtil.deviceType == DeviceType.mobile
          ? TextStyle(
              fontSize: isSmallText
                  ? 10.sp
                  : isLargeText
                      ? 14.sp
                      : 12.sp,
              fontWeight: fontWeight,
              color: color)
          : TextStyle(
              fontSize: isSmallText
                  ? 8.sp
                  : isLargeText
                      ? 14.sp
                      : 10.sp,
              fontWeight: fontWeight,
              color: color),
      // style: MediaQuery.of(context).size.width > 600
      //     ? Theme.of(context).textTheme.bodyText2
      //     : Theme.of(context).textTheme.bodyText1,
    );
  }
}
