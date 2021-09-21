import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:qattan/controller/cached_helper/cached_helper.dart';
import 'package:qattan/controller/cached_helper/key_constant.dart';
import 'package:qattan/model/cart_model.dart';
import 'package:qattan/veiw/component_widget/cached_network_Image_widget.dart';
import 'package:qattan/veiw/component_widget/home_widget/selector_item.dart';

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
                height: height * 0.65,
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
                        Text(cartModel.prodTitle!),
                        InkWell(
                          onTap: deleteFun,
                          child: Container(
                            width: width * 0.1,
                            height: height * 0.2,
                            color: Colors.red,
                            child: Icon(
                              Icons.delete,
                              size: width * 0.1,
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

                    Center(child: Text("${cartModel.prodPrice}" + "sar".tr)),
                    // SizedBox(
                    //   height: height * 0.02,
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text("size".tr),
                            Text("${cartModel.prodSize!}"),
                          ],
                        ),
                        Column(
                          children: [
                            Text("color".tr),
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
                                    child: Text(
                                      cartModel.prodQuantity.toString(),
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
                    Text("tottal".tr),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Text("${productTotalPrice!.toStringAsFixed(2)}" + "sar".tr),
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
