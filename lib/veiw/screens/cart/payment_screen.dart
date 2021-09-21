import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:qattan/constant.dart';
import 'package:qattan/controller/cubit/App_cubit.dart';
import 'package:qattan/controller/cubit_states/app_states.dart';
import 'package:qattan/features/responsive_setup/responsive_builder.dart';
import 'package:qattan/model/cart_model.dart';
import 'package:qattan/veiw/component_widget/app_bar_widget.dart';
import 'package:qattan/veiw/component_widget/cached_network_Image_widget.dart';
import 'package:qattan/veiw/component_widget/common_button.dart';
import 'package:qattan/veiw/component_widget/navigator.dart';
import 'package:qattan/veiw/component_widget/wrap_widget.dart';
import 'package:qattan/veiw/screens/bottom_nav_bar_layout.dart';
import 'package:qattan/veiw/screens/cart/add_credit_card.dart';
import 'package:get/get.dart';

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
    return ResponsiveBuilder(builder: (context, sizeConfig) {
      final height = sizeConfig.screenHeight!;
      final width = sizeConfig.screenWidth!;
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
                preferredSize: Size.fromHeight(height * 0.1),
                child: AppBarWidgets(
                  title: "payment".tr,
                  width: width,
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
              padding: EdgeInsets.all(width * 0.02),
              child: ListView(
                children: [
                  Container(
                    width: width,
                    height: height * 0.3,
                    color: Colors.white,
                    padding: EdgeInsets.all(width * 0.03),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        WrapWidget(
                          width: width,
                          height: height,
                          icon: Icons.location_on,
                          title: "shipping_address".tr,
                        ),
                        Padding(
                          padding: EdgeInsets.all(width * 0.02),
                          child: Divider(
                            color: Colors.grey,
                            endIndent: width * 0.05,
                            indent: width * 0.05,
                          ),
                        ),
                        Text(profileData!.location!),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        Text(profileData.city!),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        Text(profileData.region!),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        Center(child: Text(profileData.phone!)),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: carts!
                        .map(
                          (cartModel) => PaymentCartItem(
                            width: width,
                            height: height,
                            cartModel: cartModel,
                          ),
                        )
                        .toList(),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Container(
                    width: width,
                    height: height * 0.17,
                    color: Colors.white,
                    padding: EdgeInsets.all(width * 0.03),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("deliver".tr),
                        Padding(
                          padding: EdgeInsets.all(width * 0.02),
                          child: Divider(
                            color: Colors.grey,
                            endIndent: width * 0.03,
                            indent: width * 0.03,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("total_shipping".tr),
                            Text('$shippingAmount' + "sar".tr),
                            SizedBox(
                              width: width * 0.03,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Container(
                    width: width,
                    height: height * 0.24,
                    color: Colors.white,
                    padding: EdgeInsets.all(width * 0.03),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("note".tr),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        TextField(
                          controller: notesController,
                          maxLines: 4,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: width * 0.02,
                                  vertical: width * 0.02)),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Container(
                    width: width,
                    height: height * 0.28,
                    color: Colors.white,
                    padding: EdgeInsets.all(width * 0.03),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        WrapWidget(
                          width: width,
                          height: height,
                          icon: Icons.payment,
                          title: 'invoice'.tr,
                        ),
                        Padding(
                          padding: EdgeInsets.all(width * 0.02),
                          child: Divider(
                            color: Colors.grey,
                            endIndent: width * 0.05,
                            indent: width * 0.05,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("total_product".tr),
                            Text('$totalPrice' + "sar".tr),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("total_shipping".tr),
                            Text('$shippingAmount' + "sar".tr),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("total_payment".tr),
                            Text('$totalPaymentAmount' + "sar".tr),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Container(
                    width: width,
                    height: height * 0.1,
                    color: Colors.white,
                    padding: EdgeInsets.all(width * 0.03),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("total_payment".tr),
                        Text('$totalPaymentAmount' + "sar".tr),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Container(
                    width: width,
                    height: height * 0.13,
                    color: Colors.white,
                    padding: EdgeInsets.all(width * 0.03),
                    child: CommonButton(
                      text: "payment".tr,
                      width: width * 0.85,
                      containerColor: buttonColor,
                      textColor: buttonTextColor,
                      onTap: () {
                        showModalBottomSheet<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                height: height * 0.3,
                                width: width,
                                margin: EdgeInsets.all(width * 0.04),
                                child: Column(
                                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    SizedBox(
                                      height: height * 0.02,
                                    ),
                                    Center(
                                      child: Text(
                                        "payment_method".tr,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    SizedBox(
                                      height: height * 0.04,
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
                                        width: width,
                                        height: height,
                                        icon: Icons.payment,
                                        title: "credit_card".tr,
                                      ),
                                    ),
                                    SizedBox(
                                      height: height * 0.04,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        // back(context);
                                        print(productsId);
                                        print(productPrice);
                                        print(productQuantity);
                                        AppCubit.get(context).addOrder(
                                          paymentMethod: "cashOnDelivery",
                                          shippingLocation:
                                              profileData.location,
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
                                                height: height * 0.35,
                                                width: width,
                                                color: Colors.grey[300],
                                                // margin: EdgeInsets.all(width * 0.04),
                                                child: Stack(
                                                  alignment:
                                                      AlignmentDirectional
                                                          .center,
                                                  children: [
                                                    Align(
                                                        alignment:
                                                            AlignmentDirectional
                                                                .bottomCenter,
                                                        child: Container(
                                                          height: height * 0.25,
                                                          width: width,
                                                          decoration: BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          width *
                                                                              0.04)),
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
                                                          radius: width * 0.1,
                                                          backgroundColor:
                                                              Colors.amber,
                                                          child: Icon(
                                                              Icons.check,
                                                              size: width * 0.1,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                        Text("success".tr),
                                                        CommonButton(
                                                          text:
                                                              "continue_shopping"
                                                                  .tr,
                                                          width: width * 0.85,
                                                          containerColor:
                                                              buttonColor,
                                                          textColor:
                                                              buttonTextColor,
                                                          onTap: () {
                                                            goToAndFinish(
                                                                context,
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
                                        width: width,
                                        height: height,
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
    });
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
                width: width * 0.02,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(cartModel.prodTitle!),
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
                        Text("${cartModel.prodPrice}" + "sar".tr),
                        Text("x ${cartModel.prodQuantity}"),
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
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
