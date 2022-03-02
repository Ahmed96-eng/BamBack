import 'package:flutter/material.dart';
import 'package:qattan/constant.dart';
import 'package:sizer/sizer.dart';

class TextFormFieldWidget extends StatelessWidget {
  final String? hint;
  final TextEditingController? controller;
  final IconData? iconData;
  final FormFieldValidator<String>? valdiator;
  final bool? obscurePassword;
  final TextInputType? keyboardType;
  final GestureTapCallback? onTap;
  final TextInputAction textInputAction;

  TextFormFieldWidget({
    this.hint,
    this.controller,
    this.iconData,
    this.valdiator,
    this.obscurePassword = false,
    this.keyboardType = TextInputType.text,
    this.onTap,
    this.textInputAction = TextInputAction.next,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Stack(
        alignment: AlignmentDirectional.centerEnd,
        children: [
          TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            textInputAction: textInputAction,
            obscureText: obscurePassword!,
            style: TextStyle(
                color: Colors.black,
                fontSize:
                    SizerUtil.deviceType == DeviceType.mobile ? 10.sp : 8.sp),
            decoration: InputDecoration(
              // hoverColor: Colors.amber,
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Colors.amber,
                ),
                borderRadius: BorderRadius.circular(35.0),
              ),
              errorStyle: TextStyle(
                fontSize:
                    SizerUtil.deviceType == DeviceType.mobile ? 9.sp : 7.0.sp,
              ),
              contentPadding: EdgeInsets.all(16),
              hintText: hint, hintStyle: TextStyle(fontSize: 9.sp),
              fillColor: Colors.grey[200],
              filled: true,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(15.w)),
              // suffixIcon: Padding(
              //   padding: EdgeInsets.all(16.0),
              //   child: InkWell(onTap: onTap, child: Icon(iconData)),
              // ),
            ),
            validator: valdiator,
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: InkWell(
                onTap: onTap,
                child: Icon(
                  iconData,
                  color: buttonColor,
                )),
          )
        ],
      ),
    );
  }
}
