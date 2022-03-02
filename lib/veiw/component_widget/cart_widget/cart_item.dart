import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:qattan/controller/cached_helper/cached_helper.dart';
import 'package:qattan/controller/cached_helper/key_constant.dart';
import 'package:qattan/model/cart_model.dart';
import 'package:qattan/veiw/component_widget/cached_network_Image_widget.dart';
import 'package:sizer/sizer.dart';

import '../text_widget.dart';

class CartItem extends StatelessWidget {
  CartItem({
    required this.width,
    required this.height,
    required this.cartModel,
    required this.deleteFun,
    this.incressFun,
    this.decressFun,
    this.productTotalPrice,
  });

  final double width;
  final double height;
  final CartModel cartModel;
  final double? productTotalPrice;
  final GestureTapCallback? deleteFun;
  final GestureTapCallback? incressFun;
  final GestureTapCallback? decressFun;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.black12,
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(width * .02)),
                width: width * 0.35,
                height: height * 0.5,
                child: CachedNetworkImageWidget(
                  borderRadius: BorderRadius.circular(width * .02),
                  image: cartModel.prodImage,
                ),
              ),
              SizedBox(
                width: width * 0.02,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextWidget(
                            fontWeight: FontWeight.bold,
                            isSmallText: true,
                            text: cartModel.prodTitle!),
                        InkWell(
                          onTap: deleteFun,
                          child: Container(
                            width: width * 0.1,
                            height: height * 0.15,
                            color: Colors.red,
                            child: Icon(
                              Icons.delete,
                              size: SizerUtil.deviceType == DeviceType.mobile
                                  ? width * 0.1
                                  : width * 0.07,
                            ),
                          ),
                        ),
                      ],
                    ),
                    // ListTile(
                    //   title: Text("productName"),
                    //   trailing: InkWell(
                    //     onTap: () {},
                    //     child: Container(
                    //       width: 40,
                    //       height: 45,
                    //       color: Colors.red,
                    //       child: Icon(
                    //         Icons.delete,
                    //         size: 35,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Text("اللون: اسود"),
                    //     // Checkbox(value: true, onChanged: (value) {}),
                    //   ],
                    // ),
                    // ListTile(
                    //   title: Text("productName"),
                    //   trailing:
                    //       Checkbox(value: true, onChanged: (value) {}),
                    // ),

                    Center(
                        child: TextWidget(
                            fontWeight: FontWeight.bold,
                            isSmallText: true,
                            text: "${cartModel.prodPrice}" + "sar".tr)),
                    // SizedBox(
                    //   height: height * 0.02,
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            TextWidget(
                                fontWeight: FontWeight.bold,
                                isSmallText: true,
                                text: "size".tr),
                            TextWidget(
                                fontWeight: FontWeight.bold,
                                isSmallText: true,
                                text: "${cartModel.prodSize!}"),
                          ],
                        ),
                        Column(
                          children: [
                            TextWidget(
                                fontWeight: FontWeight.bold,
                                isSmallText: true,
                                text: "color".tr),
                            CircleAvatar(
                              radius: width * 0.03,
                              backgroundColor: HexColor(cartModel.prodColor!),
                            )

                            // Text("${cartModel.prodColor!}"),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: width * 0.4,
                          height: height * 0.12,
                          child: Row(
                            children: [
                              InkWell(
                                onTap: incressFun,
                                child: Container(
                                  width: width * 0.08,
                                  height: height * 0.12,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    border: Border.all(),
                                    borderRadius: BorderRadius.only(
                                      topLeft: (CachedHelper.getData(
                                                  key: languageKey) ==
                                              'en'
                                          ? Radius.circular(width * 0.02)
                                          : Radius.circular(0)),
                                      bottomLeft: (CachedHelper.getData(
                                                  key: languageKey) ==
                                              'en'
                                          ? Radius.circular(width * 0.02)
                                          : Radius.circular(0)),
                                      topRight: (CachedHelper.getData(
                                                  key: languageKey) ==
                                              'en'
                                          ? Radius.circular(0)
                                          : Radius.circular(width * 0.02)),
                                      bottomRight: (CachedHelper.getData(
                                                  key: languageKey) ==
                                              'en'
                                          ? Radius.circular(0)
                                          : Radius.circular(width * 0.02)),
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.add,
                                    size: width * 0.05,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  // margin: EdgeInsets.symmetric(
                                  //     horizontal: width * 0.03),
                                  height: height * 0.12,
                                  decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      border: Border.all()),
                                  child: Center(
                                    child: TextWidget(
                                      fontWeight: FontWeight.w500,
                                      isSmallText: true,
                                      text: cartModel.prodQuantity.toString(),
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: decressFun,
                                child: Container(
                                  width: width * 0.08,
                                  height: height * 0.12,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    border: Border.all(),
                                    borderRadius: BorderRadius.only(
                                      topLeft: (CachedHelper.getData(
                                                  key: languageKey) ==
                                              'en'
                                          ? Radius.circular(0)
                                          : Radius.circular(width * 0.02)),
                                      bottomLeft: (CachedHelper.getData(
                                                  key: languageKey) ==
                                              'en'
                                          ? Radius.circular(0)
                                          : Radius.circular(width * 0.02)),
                                      topRight: (CachedHelper.getData(
                                                  key: languageKey) ==
                                              'en'
                                          ? Radius.circular(width * 0.02)
                                          : Radius.circular(0)),
                                      bottomRight: (CachedHelper.getData(
                                                  key: languageKey) ==
                                              'en'
                                          ? Radius.circular(width * 0.02)
                                          : Radius.circular(0)),
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.remove,
                                    size: width * 0.05,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    TextWidget(
                        fontWeight: FontWeight.bold,
                        isSmallText: true,
                        text: "tottal".tr),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    TextWidget(
                        fontWeight: FontWeight.w500,
                        isSmallText: true,
                        text: "${productTotalPrice!.toStringAsFixed(2)}" +
                            "sar".tr),
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: height * 0.02,
          ),
          Divider(
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}
