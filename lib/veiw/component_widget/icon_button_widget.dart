import 'package:flutter/material.dart';

class IconButtonWidget extends StatelessWidget {
  final IconData? icon;
  final VoidCallback? onpressed;
  final double? radius;
  final double? size;
  final Color? color;
  final Color? circleAvatarColor;

  IconButtonWidget({
    this.icon,
    this.onpressed,
    this.radius,
    this.size,
    this.color,
    this.circleAvatarColor,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onpressed,
      child: CircleAvatar(
          radius: radius,
          backgroundColor: Color(0xff7BCFE9),
          child: Icon(
            icon,
            size: size,
            color: Colors.white,
          )),
    );
  }
}
