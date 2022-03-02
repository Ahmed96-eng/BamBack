import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:qattan/constant.dart';
import 'package:sizer/sizer.dart';

class SelectorItem extends StatelessWidget {
  final List? sizes;
  final String? selectedSize;
  final bool? colorView;
  final double? width;
  final double? height;
  final void Function(String)? onSizeSelected;

  SelectorItem(
      {this.sizes,
      this.selectedSize,
      this.onSizeSelected,
      this.colorView = false,
      this.width,
      this.height});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: sizes!.length,
        itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.all(width! * 0.2),
              child: Material(
                child: InkWell(
                  borderRadius: BorderRadius.circular(
                      colorView! ? width! / 2 : width! * 0.01),
                  onTap: () => onSizeSelected!(sizes![index]),
                  child: Ink(
                    height: height,
                    width: width,
                    decoration: BoxDecoration(
                        color: selectedSize == sizes![index]
                            ? mainColor
                            : Color(0xFFF3F3F3),
                        borderRadius: BorderRadius.circular(
                            colorView! ? width! * 0.5 : width! * 0.01)),
                    child: Align(
                      alignment: Alignment.center,
                      child: colorView!
                          ? CircleAvatar(
                              radius: 13,
                              child: CircleAvatar(
                                radius: 10,
                                backgroundColor: HexColor(sizes![index]),
                              ),
                            )
                          : Text(
                              sizes![index],
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(
                                      fontSize: 12.sp,
                                      color: selectedSize == sizes![index]
                                          ? Colors.white
                                          : Colors.black87),
                            ),
                    ),
                  ),
                ),
              ),
            ));
  }
}
