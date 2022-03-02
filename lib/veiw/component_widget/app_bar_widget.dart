import 'package:flutter/material.dart';
import 'package:qattan/constant.dart';
import 'package:qattan/veiw/component_widget/icon_button_widget.dart';
import 'package:qattan/veiw/component_widget/navigator.dart';
import 'package:qattan/veiw/component_widget/text_widget.dart';

class AppBarWidgets extends StatelessWidget {
  final String? title;
  final double? width;

  const AppBarWidgets({this.title, this.width});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      title: Padding(
        padding: EdgeInsets.only(top: width! * 0.02),
        child: TextWidget(
          text: title!,
          fontWeight: FontWeight.bold,
          // isLargeText: true,
          color: buttonTextColor!,
        ),
      ),
      leading: (lang == 'en')
          ? Padding(
              padding: EdgeInsets.all(width! * 0.01),
              child: IconButtonWidget(
                icon: (lang == 'ar') ? Icons.arrow_forward : Icons.arrow_back,
                radius: width! * 0.05,
                size: width! * 0.05,
                onpressed: () {
                  back(context);
                },
              ),
            )
          : Container(),
      actions: [
        if ((lang == 'ar'))
          Padding(
            padding: EdgeInsets.all(width! * 0.01),
            child: IconButtonWidget(
              icon: (lang == 'ar') ? Icons.arrow_forward : Icons.arrow_back,
              radius: width! * 0.05,
              size: width! * 0.05,
              onpressed: () {
                back(context);
              },
            ),
          )
      ],
    );
  }
}
