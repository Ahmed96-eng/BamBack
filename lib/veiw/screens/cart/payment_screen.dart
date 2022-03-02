import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:qattan/constant.dart';
import 'package:qattan/controller/cubit/App_cubit.dart';
import 'package:qattan/controller/cubit_states/app_states.dart';
import 'package:qattan/model/cart_model.dart';
import 'package:qattan/veiw/component_widget/app_bar_widget.dart';
import 'package:qattan/veiw/component_widget/cached_network_Image_widget.dart';
import 'package:qattan/veiw/component_widget/common_button.dart';
import 'package:qattan/veiw/component_widget/navigator.dart';
import 'package:qattan/veiw/component_widget/text_widget.dart';
import 'package:qattan/veiw/component_widget/wrap_widget.dart';
import 'package:qattan/veiw/screens/bottom_nav_bar_layout.dart';
import 'package:qattan/veiw/screens/cart/add_credit_card.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class PaymentScreen extends StatelessWidget {
  // List<String> cards = [
  //   "aaaaaaa",
  //   "bbbbbbb",
  // ];
  final double? totalPrice;
  final List<CartModel>? carts;
  final List? productsId;
  final List? productQuantity;
  final List? productPrice;
  final List? productSize;
  final List? productColor;
  final List? productTotalPrice;
  PaymentScreen(
      {this.totalPrice,
      this.carts,
      this.productsId,
      this.productQuantity,
      this.productPrice,
      this.productTotalPrice,
      this.productSize,
      this.productColor});

  final notesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        var profileData = AppCubit.get(context).profilModel!.data;
        var shippingAmount =
            AppCubit.get(context).shippingModel!.shippingAmount!;
        double totalPaymentAmount =
            (totalPrice)! + double.parse(shippingAmount);
        return Scaffold(
          backgroundColor: Colors.grey[300],
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(8.h),
              child: AppBarWidgets(
                title: "payment".tr,
                width: 100.w,
              )),
          // appBar: AppBar(
          //   elevation: 0,
          //   centerTitle: true,
          //   title: Text("payment".tr),
          //   leading: (lang == 'en')
          //       ? InkWell(
          //           onTap: () {
          //             back(context);
          //           },
          //           child: Padding(
          //             padding: EdgeInsets.all(width * 0.03),
          //             child: IconButtonWidget(
          //               icon: (lang == 'ar')
          //                   ? Icons.arrow_forward
          //                   : Icons.arrow_back,
          //               radius: width * 0.05,
          //               size: width * 0.05,
          //               onpressed: () {
          //                 back(context);
          //               },
          //             ),
          //           ),
          //         )
          //       : Container(),
          //   actions: [
          //     if ((lang == 'ar'))
          //       Padding(
          //         padding: EdgeInsets.all(width * 0.03),
          //         child: InkWell(
          //           child: IconButtonWidget(
          //             icon: (lang == 'ar')
          //                 ? Icons.arrow_forward
          //                 : Icons.arrow_back,
          //             radius: width * 0.05,
          //             size: width * 0.05,
          //             onpressed: () {
          //               back(context);
          //             },
          //           ),
          //           onTap: () {
          //             back(context);
          //           },
          //         ),
          //       ),
          //   ],
          // ),

          body: Padding(
            padding: EdgeInsets.all(2.w),
            child: ListView(
              children: [
                Container(
                  width: 100.w,
                  height: 30.h,
                  color: Colors.white,
                  padding: EdgeInsets.all(3.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      WrapWidget(
                        width: 100.w,
                        height: 100.h,
                        icon: Icons.location_on,
                        title: "shipping_address".tr,
                      ),
                      Padding(
                        padding: EdgeInsets.all(2.w),
                        child: Divider(
                          color: Colors.grey,
                          endIndent: 5.w,
                          indent: 5.w,
                        ),
                      ),
                      TextWidget(
                          fontWeight: FontWeight.w600,
                          isSmallText: true,
                          text: profileData!.location!),
                      SizedBox(
                        height: 1.h,
                      ),
                      TextWidget(
                          fontWeight: FontWeight.w600,
                          isSmallText: true,
                          text: profileData.city!),
                      SizedBox(
                        height: 1.h,
                      ),
                      TextWidget(
                          fontWeight: FontWeight.w600,
                          isSmallText: true,
                          text: profileData.region!),
                      SizedBox(
                        height: 1.h,
                      ),
                      Center(
                          child: TextWidget(
                              fontWeight: FontWeight.w500,
                              isSmallText: true,
                              text: profileData.phone!)),
                    ],
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: carts!
                      .map(
                        (cartModel) => PaymentCartItem(
                          width: 100.w,
                          height: 100.h,
                          cartModel: cartModel,
                        ),
                      )
                      .toList(),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Container(
                  width: 100.w,
                  height: 17.h,
                  color: Colors.white,
                  padding: EdgeInsets.all(3.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                          fontWeight: FontWeight.bold,
                          isSmallText: true,
                          text: "deliver".tr),
                      Padding(
                        padding: EdgeInsets.all(2.w),
                        child: Divider(
                          color: Colors.grey,
                          endIndent: 3.w,
                          indent: 3.w,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextWidget(
                              fontWeight: FontWeight.bold,
                              isSmallText: true,
                              text: "total_shipping".tr),
                          TextWidget(
                              fontWeight: FontWeight.w600,
                              isSmallText: true,
                              text: '$shippingAmount' + "sar".tr),
                          SizedBox(
                            width: 3.w,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Container(
                  width: 100.w,
                  height: 22.h,
                  color: Colors.white,
                  padding: EdgeInsets.all(3.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                          fontWeight: FontWeight.bold,
                          isSmallText: true,
                          text: "note".tr),
                      SizedBox(
                        height: 2.h,
                      ),
                      TextField(
                        controller: notesController,
                        maxLines: 4,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 2.w, vertical: 2.w)),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Container(
                  width: 100.w,
                  height: 28.h,
                  color: Colors.white,
                  padding: EdgeInsets.all(3.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      WrapWidget(
                        width: 100.w,
                        height: 100.h,
                        icon: Icons.payment,
                        title: 'invoice'.tr,
                      ),
                      Padding(
                        padding: EdgeInsets.all(2.w),
                        child: Divider(
                          color: Colors.grey,
                          endIndent: 5.w,
                          indent: 5.w,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextWidget(
                              fontWeight: FontWeight.bold,
                              isSmallText: true,
                              text: "total_product".tr),
                          TextWidget(
                              fontWeight: FontWeight.w600,
                              isSmallText: true,
                              text: '$totalPrice' + "sar".tr),
                        ],
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextWidget(
                              fontWeight: FontWeight.bold,
                              isSmallText: true,
                              text: "total_shipping".tr),
                          TextWidget(
                              fontWeight: FontWeight.w600,
                              isSmallText: true,
                              text: '$shippingAmount' + "sar".tr),
                        ],
                      ),
                      SizedBox(
                        height: 1.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextWidget(
                              fontWeight: FontWeight.bold,
                              isSmallText: true,
                              text: "total_payment".tr),
                          TextWidget(
                              fontWeight: FontWeight.w600,
                              isSmallText: true,
                              text: '$totalPaymentAmount' + "sar".tr),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Container(
                  width: 100.w,
                  height: 10.h,
                  color: Colors.white,
                  padding: EdgeInsets.all(3.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextWidget(
                          fontWeight: FontWeight.bold,
                          isSmallText: true,
                          text: "total_payment".tr),
                      TextWidget(
                          fontWeight: FontWeight.w600,
                          isSmallText: true,
                          text: '$totalPaymentAmount' + "sar".tr),
                    ],
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Container(
                  width: 100.w,
                  height: 12.h,
                  color: Colors.white,
                  padding: EdgeInsets.all(5.w),
                  child: CommonButton(
                    text: "payment".tr,
                    height: 5.h,
                    width: 70.w,
                    containerColor: buttonColor,
                    textColor: buttonTextColor,
                    onTap: () {
                      showModalBottomSheet<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              height: 30.h,
                              width: 100.w,
                              margin: EdgeInsets.all(4.w),
                              child: Column(
                                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  Center(
                                    child: TextWidget(
                                      fontWeight: FontWeight.bold,
                                      text: "payment_method".tr,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 4.h,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      back(context);
                                      goTo(
                                          context,
                                          AddCridetCard(
                                            notes: notesController.text,
                                            productPrice:
                                                productPrice as List<double?>,
                                            productQuantity:
                                                productQuantity as List<int?>,
                                            productTotalPrice:
                                                productTotalPrice,
                                            productsId:
                                                productsId as List<int?>,
                                            productColor: productColor,
                                            productSize: productSize,
                                            totalPaymentAmount:
                                                totalPaymentAmount,
                                          ));
                                    },
                                    child: WrapWidget(
                                      width: 100.w,
                                      height: 100.h,
                                      icon: Icons.payment,
                                      title: "credit_card".tr,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 4.h,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      // back(context);
                                      print(productsId);
                                      print(productPrice);
                                      print(productQuantity);
                                      AppCubit.get(context).addOrder(
                                        paymentMethod: "cashOnDelivery",
                                        shippingLocation: profileData.location,
                                        notes: notesController.text,
                                        total: totalPaymentAmount,
                                        productsId: productsId as List<int?>,
                                        productsPrices:
                                            productPrice as List<double?>,
                                        productsQuantity:
                                            productQuantity as List<int?>,
                                        productsTotalPrice: productTotalPrice,
                                        productColor: productColor,
                                        productsSize: productSize,
                                        orders: [
                                          productsId,
                                          productPrice,
                                          productQuantity,
                                        ],
                                      ).then((value) {
                                        // if (state is AddOrdersSuccessState) {
                                        AppCubit.get(context).deleteAllCart();
                                        productsId!.clear();
                                        productPrice!.clear();
                                        productQuantity!.clear();
                                        showModalBottomSheet(
                                          context: context,
                                          builder: (context) => WillPopScope(
                                            onWillPop: () async => false,
                                            child: Container(
                                              height: 35.h,
                                              width: 100.w,
                                              color: Colors.grey[300],
                                              // margin: EdgeInsets.all(width * 0.04),
                                              child: Stack(
                                                alignment:
                                                    AlignmentDirectional.center,
                                                children: [
                                                  Align(
                                                      alignment:
                                                          AlignmentDirectional
                                                              .bottomCenter,
                                                      child: Container(
                                                        height: 25.h,
                                                        width: 100.w,
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        4.w)),
                                                      )),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      CircleAvatar(
                                                        radius: 10.w,
                                                        backgroundColor:
                                                            Colors.amber,
                                                        child: Icon(Icons.check,
                                                            size: 10.w,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      TextWidget(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          isSmallText: true,
                                                          text: "success".tr),
                                                      CommonButton(
                                                        text:
                                                            "continue_shopping"
                                                                .tr,
                                                        width: 80.w,
                                                        containerColor:
                                                            buttonColor,
                                                        textColor:
                                                            buttonTextColor,
                                                        onTap: () {
                                                          goToAndFinish(context,
                                                              BotomNavBarLayout());
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                        // }
                                      });
                                    },
                                    child: WrapWidget(
                                      width: 100.w,
                                      height: 100.h,
                                      icon: Icons.location_on,
                                      title: "hand_payment".tr,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          });
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class PaymentCartItem extends StatelessWidget {
  PaymentCartItem({
    required this.width,
    required this.height,
    required this.cartModel,
  });

  final double width;
  final double height;
  final CartModel cartModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(2.0),
      child: Container(
          width: width,
          height: height * 0.2,
          color: Colors.white,
          padding: EdgeInsets.all(width * 0.03),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: width * 0.25,
                height: height * 0.15,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(width * .02),
                ),
                child: CachedNetworkImageWidget(
                  borderRadius: BorderRadius.circular(width * .02),
                  image: cartModel.prodImage,
                ),
              ),
              SizedBox(
                width: 2.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                      fontWeight: FontWeight.bold,
                      isSmallText: true,
                      text: cartModel.prodTitle!),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  // Text("اللون : اسمر"),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Container(
                    width: width * 0.6,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextWidget(
                            fontWeight: FontWeight.w600,
                            isSmallText: true,
                            text: "${cartModel.prodPrice}" + "sar".tr),
                        TextWidget(
                            fontWeight: FontWeight.w600,
                            isSmallText: true,
                            text: "x ${cartModel.prodQuantity}"),
                      ],
                    ),
                  ),
                  Container(
                    width: width * 0.6,
                    child: Row(
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
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
