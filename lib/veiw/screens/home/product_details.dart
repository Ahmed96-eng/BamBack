import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:qattan/constant.dart';
import 'package:qattan/controller/cached_helper/cached_helper.dart';
import 'package:qattan/controller/cached_helper/key_constant.dart';
import 'package:qattan/controller/cubit/App_cubit.dart';
import 'package:qattan/controller/cubit_states/app_states.dart';
import 'package:qattan/features/responsive_setup/responsive_builder.dart';
import 'package:qattan/model/cart_model.dart';
import 'package:qattan/model/favorite_model.dart';
import 'package:qattan/veiw/component_widget/cached_network_Image_widget.dart';
import 'package:qattan/veiw/component_widget/common_button.dart';
import 'package:qattan/veiw/component_widget/home_widget/selector_item.dart';
import 'package:qattan/veiw/component_widget/icon_button_widget.dart';
import 'package:qattan/veiw/component_widget/loading_progress_indecator.dart';
import 'package:qattan/veiw/component_widget/navigator.dart';
import 'package:get/get.dart';
import 'package:qattan/veiw/screens/cart/cart_screen.dart';

class ProductDetails extends StatefulWidget {
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  bool expand = false;
  TextEditingController reviewController = TextEditingController();
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          var productDetails = AppCubit.get(context).productDetailsModel?.data;
          return ResponsiveBuilder(builder: (context, sizeConfig) {
            final height = sizeConfig.screenHeight!;
            final width = sizeConfig.screenWidth!;
            return SafeArea(
              child: Scaffold(
                body: (productDetails == null)
                    ? LoadingProgressIndecator()
                    : Container(
                        width: width,
                        height: height,
                        child: Stack(
                          children: [
                            Container(
                              width: width,
                              height: height * 0.48,
                              child: Stack(
                                alignment: AlignmentDirectional.bottomEnd,
                                children: [
                                  productDetails.images!.length <= 1
                                      ? CachedNetworkImageWidget(
                                          image: productDetails.productImage,
                                          width: width,
                                          height: height * 0.6,
                                          boxFit: BoxFit.fill,
                                        )
                                      : CarouselSlider(
                                          items: productDetails.images!
                                              .map(
                                                (e) =>
                                                    //  Image.asset(
                                                    //   e,
                                                    //   fit: BoxFit.cover,
                                                    // ),
                                                    //     Image(
                                                    //   // image: NetworkImage(
                                                    //   //     "http://qatan-ksa.com/$e"),
                                                    //   // image: AssetImage(e),
                                                    //   width: double.infinity,
                                                    //   // height: 250,
                                                    //   fit: BoxFit.fill,
                                                    // ),
                                                    CachedNetworkImageWidget(
                                                  image: e,
                                                  width: width,
                                                  boxFit: BoxFit.fill,
                                                ),
                                              )
                                              .toList(),
                                          options: CarouselOptions(
                                            height: height * 0.6,
                                            aspectRatio: 16 / 9,
                                            viewportFraction: 1,
                                            initialPage: 0,
                                            enableInfiniteScroll: true,
                                            reverse: true,
                                            autoPlay: true,
                                            autoPlayInterval:
                                                Duration(seconds: 2),
                                            autoPlayAnimationDuration:
                                                Duration(milliseconds: 800),
                                            autoPlayCurve: Curves.fastOutSlowIn,
                                            enlargeCenterPage: true,
                                            scrollDirection: Axis.horizontal,
                                          ),
                                        ),
                                  Align(
                                    alignment: (lang == 'ar')
                                        ? AlignmentDirectional.topStart
                                        : AlignmentDirectional.topEnd,
                                    child: Padding(
                                      padding: EdgeInsets.all(width * 0.02),
                                      child: IconButtonWidget(
                                        icon: Icons.shopping_cart_rounded,
                                        radius: width * 0.06,
                                        size: width * 0.06,
                                        onpressed: () {
                                          goTo(context, CartScreen());
                                        },
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: (lang == 'en')
                                        ? AlignmentDirectional.topStart
                                        : AlignmentDirectional.topEnd,
                                    child: Padding(
                                      padding: EdgeInsets.all(width * 0.02),
                                      child: IconButtonWidget(
                                        icon: (lang == 'ar')
                                            ? Icons.arrow_forward
                                            : Icons.arrow_back,
                                        radius: width * 0.05,
                                        size: width * 0.05,
                                        onpressed: () {
                                          back(context);
                                        },
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(width * 0.04),
                                    // child: Image.asset(
                                    //   'asset/images/love_Icon 3.png',
                                    //   fit: BoxFit.fill,
                                    //   height: height * 0.03,
                                    //   width: width * 0.05,
                                    //   color: Colors.red,
                                    // ),
                                    child: CircleAvatar(
                                      radius: width * 0.06,
                                      child: IconButton(
                                          onPressed: () {
                                            FavoriteModel favoriteModel =
                                                FavoriteModel(
                                              prodId:
                                                  int.parse(productDetails.id!),
                                              favId:
                                                  int.parse(productDetails.id!),
                                              customerId: userId,
                                              prodImage:
                                                  productDetails.productImage ??
                                                      "image",
                                              prodTitle:
                                                  productDetails.productName!,
                                              prodPrice: productDetails.price,
                                              proddateTime:
                                                  DateTime.now().toString(),
                                            );
                                            AppCubit.get(context)
                                                    .prodFavIds
                                                    .contains(int.parse(
                                                        productDetails.id
                                                            .toString()))
                                                ? AppCubit.get(context)
                                                    .deleteFavorite(
                                                      int.parse(productDetails
                                                          .id
                                                          .toString()),
                                                    )
                                                    .then((value) =>
                                                        showFlutterToast(
                                                            message:
                                                                "delete_success"
                                                                    .tr))
                                                : AppCubit.get(context)
                                                    .addToFavorite(
                                                        favoriteModel)
                                                    .then((value) =>
                                                        showFlutterToast(
                                                            message:
                                                                "add_to_favorite_success"
                                                                    .tr));
                                          },
                                          icon: Icon(
                                            Icons.favorite_border,
                                            color: AppCubit.get(context)
                                                    .prodFavIds
                                                    .contains(int.parse(
                                                        productDetails.id
                                                            .toString()))
                                                ? Colors.red
                                                : mainColor,
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Align(
                            //   alignment: AlignmentDirectional.bottomCenter,
                            //   child: Stack(
                            //     alignment: AlignmentDirectional.topCenter,
                            //     children: [
                            //       Container(
                            //         width: width,
                            //         // height: scrollController.offset,
                            //         height: AppCubit.get(context).boxExpand
                            //             ? height * 0.8
                            //             : height * 0.5,
                            //         color: Colors.white,
                            //         child: Column(
                            //           crossAxisAlignment:
                            //               CrossAxisAlignment.start,
                            //           children: [
                            //             SizedBox(
                            //               height: height * 0.01,
                            //             ),
                            //             ListTile(
                            //               title:
                            //                   Text(productDetails.productName!),
                            //               subtitle: Padding(
                            //                 padding: EdgeInsets.symmetric(
                            //                     vertical: height * 0.01),
                            //                 child: Row(
                            //                   children: [
                            //                     RatingBar.builder(
                            //                       itemSize: 15,
                            //                       initialRating:
                            //                           (productDetails.rate)!
                            //                               .toDouble(),
                            //                       minRating: 1,
                            //                       direction: Axis.horizontal,
                            //                       allowHalfRating: true,
                            //                       itemCount: 5,
                            //                       itemPadding:
                            //                           EdgeInsets.symmetric(
                            //                               horizontal: 4.0),
                            //                       itemBuilder: (context, _) =>
                            //                           Icon(
                            //                         Icons.star,
                            //                         color: Colors.amber,
                            //                       ),
                            //                       onRatingUpdate: (rating) {
                            //                         print(rating);
                            //                         AppCubit.get(context)
                            //                             .addProductRate(
                            //                                 rating.toInt(),
                            //                                 productDetails.id!);
                            //                       },
                            //                     ),
                            //                     Spacer(),
                            //                     TextButton(
                            //                       onPressed: () {
                            //                         AppCubit.get(context)
                            //                             .getProductReview(
                            //                                 productDetails.id!)
                            //                             .then(
                            //                               (value) => showModalBottomSheet(
                            //                                   context: context,
                            //                                   builder: (context) =>
                            //                                       //   ListView.builder(
                            //                                       // itemCount: AppCubit.get(
                            //                                       //         context)
                            //                                       //     .reviewModel!
                            //                                       //     .data!
                            //                                       //     .length,
                            //                                       // itemBuilder:
                            //                                       //     (context, index) =>
                            //                                       Container(
                            //                                         height:
                            //                                             height *
                            //                                                 0.8,
                            //                                         width:
                            //                                             width,
                            //                                         color: Colors
                            //                                                 .grey[
                            //                                             300],
                            //                                         padding: EdgeInsets
                            //                                             .all(width *
                            //                                                 0.04),
                            //                                         child:
                            //                                             Column(
                            //                                           children: [
                            //                                             Row(
                            //                                               children: [
                            //                                                 Flexible(
                            //                                                   // flex: 1,
                            //                                                   child: TextField(
                            //                                                       controller: reviewController,
                            //                                                       decoration: InputDecoration(
                            //                                                         contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 3),
                            //                                                         fillColor: Colors.white,
                            //                                                         filled: true,
                            //                                                         hintText: "review_hint".tr,
                            //                                                         border: OutlineInputBorder(
                            //                                                           borderSide: BorderSide.none,
                            //                                                           borderRadius: BorderRadius.circular(45),
                            //                                                         ),
                            //                                                       )),
                            //                                                 ),
                            //                                                 SizedBox(
                            //                                                   width: width * 0.02,
                            //                                                 ),
                            //                                                 Padding(
                            //                                                   padding: EdgeInsets.all(width * 0.025),
                            //                                                   child: IconButtonWidget(
                            //                                                     icon: Icons.send_rounded,
                            //                                                     radius: width * 0.05,
                            //                                                     size: width * 0.05,
                            //                                                     onpressed: () {
                            //                                                       if (reviewController.text.isEmpty) {
                            //                                                         showFlutterToast(message: 'write_any_thing'.tr);
                            //                                                       } else {
                            //                                                         AppCubit.get(context).addProductReview(
                            //                                                           reviewController.text,
                            //                                                           productDetails.id!,
                            //                                                         );
                            //                                                         reviewController.clear();
                            //                                                         back(context);
                            //                                                       }
                            //                                                     },
                            //                                                   ),
                            //                                                 ),
                            //                                                 SizedBox(
                            //                                                   width: width * 0.02,
                            //                                                 ),
                            //                                               ],
                            //                                             ),
                            //                                             SizedBox(
                            //                                               height:
                            //                                                   height * 0.02,
                            //                                             ),
                            //                                             Flexible(
                            //                                               // flex: 1,
                            //                                               child:
                            //                                                   ListView.builder(
                            //                                                 itemCount:
                            //                                                     AppCubit.get(context).reviewModel!.data!.length,
                            //                                                 itemBuilder: (context, index) =>
                            //                                                     ListTile(
                            //                                                   leading: ClipOval(
                            //                                                     child: CachedNetworkImageWidget(
                            //                                                       width: width * 0.15,
                            //                                                       height: height * 0.1,
                            //                                                       image: "${AppCubit.get(context).reviewModel!.data![index].customerImage}",
                            //                                                     ),
                            //                                                   ),
                            //                                                   title: Text("${AppCubit.get(context).reviewModel!.data![index].customerName}"),
                            //                                                   subtitle: Text("${AppCubit.get(context).reviewModel!.data![index].review}"),
                            //                                                 ),
                            //                                               ),
                            //                                             ),
                            //                                           ],
                            //                                         ),
                            //                                       )),
                            //                               // ),
                            //                             );
                            //                       },
                            //                       child: Text("reviews".tr),
                            //                     ),
                            //                     // SizedBox(
                            //                     //   width: width * 0.06,
                            //                     // ),
                            //                     Row(
                            //                       children: [
                            //                         Text(
                            //                             '(${productDetails.rate ?? 1})'),
                            //                         Icon(
                            //                           Icons.star,
                            //                           color: Colors.amber,
                            //                           size: width * 0.05,
                            //                         ),
                            //                       ],
                            //                     ),
                            //                   ],
                            //                 ),
                            //               ),
                            //               trailing: Text(
                            //                   '${productDetails.price}' +
                            //                       "sar".tr),
                            //             ),
                            //             Padding(
                            //               padding: EdgeInsets.symmetric(
                            //                 horizontal: width * 0.03,
                            //               ),
                            //               child: Row(
                            //                 mainAxisAlignment:
                            //                     MainAxisAlignment.spaceBetween,
                            //                 children: [
                            //                   Text("size".tr),
                            //                   Container(
                            //                     width: width / 2,
                            //                     height: height * 0.07,
                            //                     child: SelectorItem(
                            //                         width: width * 0.09,
                            //                         height: height * 0.04,
                            //                         sizes:
                            //                             (productDetails.sizes),
                            //                         selectedSize:
                            //                             AppCubit.get(context)
                            //                                 .sizeValue,
                            //                         onSizeSelected: (value) {
                            //                           AppCubit.get(context)
                            //                               .selectProductSize(
                            //                                   value);
                            //                           // selectSize = value;
                            //                           print(value);
                            //                           print(
                            //                               AppCubit.get(context)
                            //                                   .sizeValue);
                            //                         }),
                            //                   ),
                            //                 ],
                            //               ),
                            //             ),
                            //             Padding(
                            //               padding: EdgeInsets.symmetric(
                            //                   horizontal: width * 0.03),
                            //               child: Row(
                            //                 mainAxisAlignment:
                            //                     MainAxisAlignment.spaceBetween,
                            //                 children: [
                            //                   Text("color".tr),
                            //                   Container(
                            //                     width: width / 2,
                            //                     height: height * 0.07,
                            //                     child: SelectorItem(
                            //                         width: width * 0.09,
                            //                         height: height * 0.04,
                            //                         sizes:
                            //                             productDetails.colors,
                            //                         selectedSize:
                            //                             AppCubit.get(context)
                            //                                 .colorValue,
                            //                         colorView: true,
                            //                         onSizeSelected: (value) {
                            //                           // selectColor = '';
                            //                           // selectColor = value;
                            //                           AppCubit.get(context)
                            //                               .selectProductColor(
                            //                                   value);
                            //                           print(value);
                            //                           print(
                            //                               AppCubit.get(context)
                            //                                   .colorValue);
                            //                         }),
                            //                     // child: ListView.builder(
                            //                     //     scrollDirection: Axis.horizontal,
                            //                     //     itemCount: productColors.length,
                            //                     //     itemBuilder: (context, index) =>
                            //                     //         Padding(
                            //                     //           padding:
                            //                     //               EdgeInsets.all(width * 0.01),
                            //                     //           child: CircleAvatar(
                            //                     //             radius: width * 0.05,
                            //                     //             backgroundColor: Colors.black54,
                            //                     //             child: CircleAvatar(
                            //                     //               radius: width * 0.04,
                            //                     //               backgroundColor: Colors.white,
                            //                     //               child: CircleAvatar(
                            //                     //                 radius: width * 0.035,
                            //                     //                 backgroundColor: HexColor(
                            //                     //                     productColors[index]),
                            //                     //               ),
                            //                     //             ),
                            //                     //           ),
                            //                     //         )),
                            //                   ),
                            //                 ],
                            //               ),
                            //             ),
                            //             Padding(
                            //               padding: EdgeInsets.symmetric(
                            //                   horizontal: width * 0.03,
                            //                   vertical: width * 0.01),
                            //               child: Row(
                            //                 mainAxisAlignment:
                            //                     MainAxisAlignment.spaceBetween,
                            //                 children: [
                            //                   Text("الكمية"),
                            //                   Container(
                            //                     width: width / 2,
                            //                     height: height * 0.06,
                            //                     child: Row(
                            //                       children: [
                            //                         InkWell(
                            //                           onTap: () {
                            //                             AppCubit.get(context)
                            //                                 .incressProductQuantity();
                            //                             print(AppCubit.get(
                            //                                     context)
                            //                                 .productQuantity);
                            //                           },
                            //                           child: Container(
                            //                             width: width * 0.08,
                            //                             height: height * 0.045,
                            //                             color: Colors.grey[200],
                            //                             child: Icon(
                            //                               Icons.add,
                            //                               size: width * 0.05,
                            //                             ),
                            //                           ),
                            //                         ),
                            //                         Flexible(
                            //                           // flex: 1,
                            //                           child: Container(
                            //                             margin: EdgeInsets
                            //                                 .symmetric(
                            //                                     horizontal:
                            //                                         width *
                            //                                             0.03),
                            //                             height: height * 0.045,
                            //                             color: Colors.grey[200],
                            //                             child: Center(
                            //                               child: Text(
                            //                                 AppCubit.get(
                            //                                         context)
                            //                                     .productQuantity!
                            //                                     .toString(),
                            //                               ),
                            //                             ),
                            //                           ),
                            //                         ),
                            //                         InkWell(
                            //                           onTap: () {
                            //                             AppCubit.get(context)
                            //                                 .decressProductQuantity()
                            //                                 .then((value) {
                            //                               if (AppCubit.get(
                            //                                           context)
                            //                                       .productQuantity ==
                            //                                   1)
                            //                                 showFlutterToast(
                            //                                     message:
                            //                                         "min_quantity_is_1"
                            //                                             .tr);
                            //                             });
                            //                             print(AppCubit.get(
                            //                                     context)
                            //                                 .productQuantity);
                            //                           },
                            //                           child: Container(
                            //                             width: width * 0.08,
                            //                             height: height * 0.045,
                            //                             color: Colors.grey[200],
                            //                             child: Icon(
                            //                               Icons.remove,
                            //                               size: width * 0.05,
                            //                             ),
                            //                           ),
                            //                         ),
                            //                       ],
                            //                     ),
                            //                   ),
                            //                 ],
                            //               ),
                            //             ),
                            //             if (AppCubit.get(context)
                            //                 .boxExpand) ...[
                            //               SizedBox(
                            //                 height: height * 0.01,
                            //               ),
                            //               Padding(
                            //                 padding: EdgeInsets.symmetric(
                            //                     horizontal: width * 0.03,
                            //                     vertical: width * 0.01),
                            //                 child: Container(
                            //                   height: height * 0.3,
                            //                   child: SingleChildScrollView(
                            //                     child: Column(
                            //                       crossAxisAlignment:
                            //                           CrossAxisAlignment.start,
                            //                       children: [
                            //                         Text("description".tr),
                            //                         SizedBox(
                            //                           height: height * 0.01,
                            //                         ),
                            //                         Text(productDetails
                            //                             .productDescription!),
                            //                       ],
                            //                     ),
                            //                   ),
                            //                 ),
                            //               ),
                            //             ],
                            //             Spacer(),
                            //             Align(
                            //               alignment:
                            //                   AlignmentDirectional.bottomCenter,
                            //               child: CommonButton(
                            //                 text: 'add_cart'.tr,
                            //                 width: width * 0.85,
                            //                 containerColor: buttonColor,
                            //                 textColor: buttonTextColor,
                            //                 onTap: () {
                            //                   // if (AppCubit.get(context)
                            //                   //         .carts
                            //                   //         .length ==
                            //                   //     0) {
                            //                   //   totalAmount = 0.0;
                            //                   // }

                            //                   if (AppCubit.get(context)
                            //                               .colorValue ==
                            //                           '' ||
                            //                       AppCubit.get(context)
                            //                               .sizeValue ==
                            //                           '') {
                            //                     showFlutterToast(
                            //                         message:
                            //                             "add_to_cart_error".tr);
                            //                   }
                            //                   var cart1Model = CartModel(
                            //                     // cartId: CachedHelper.getData(
                            //                     //     key: cartId),
                            //                     cartId: DateTime.now()
                            //                         .toIso8601String(),
                            //                     prodId: productDetails.id!,
                            //                     customerId: userId,
                            //                     prodTitle:
                            //                         productDetails.productName,
                            //                     prodImage:
                            //                         productDetails.productImage,
                            //                     prodQuantity:
                            //                         AppCubit.get(context)
                            //                             .productQuantity,
                            //                     prodPrice: productDetails.price,
                            //                     proddateTime:
                            //                         DateTime.now().toString(),
                            //                     prodSize: AppCubit.get(context)
                            //                         .sizeValue,
                            //                     prodColor: AppCubit.get(context)
                            //                         .colorValue,
                            //                   );
                            //                   for (int i = 0;
                            //                       i <
                            //                           AppCubit.get(context)
                            //                               .carts
                            //                               .length;
                            //                       i++) {
                            //                     if (AppCubit.get(context)
                            //                                 .carts[i]
                            //                                 .prodId ==
                            //                             cart1Model.prodId &&
                            //                         AppCubit.get(context)
                            //                                 .carts[i]
                            //                                 .prodColor ==
                            //                             cart1Model.prodColor &&
                            //                         AppCubit.get(context)
                            //                                 .carts[i]
                            //                                 .prodSize ==
                            //                             cart1Model.prodSize) {
                            //                       return showFlutterToast(
                            //                           message:
                            //                               "already_exist".tr);
                            //                     }
                            //                   }
                            //                   //   } else {
                            //                   AppCubit.get(context)
                            //                       .addToCart(cart1Model)
                            //                       //     .addToCart(
                            //                       //   prodId: productDetails.id,
                            //                       //   customerId: userId,
                            //                       //   prodTitle: productDetails
                            //                       //       .productName,
                            //                       //   prodImage: productDetails
                            //                       //       .productImage,
                            //                       //   prodQuantity:
                            //                       //       AppCubit.get(context)
                            //                       //           .productQuantity
                            //                       //           .toString(),
                            //                       //   prodPrice:
                            //                       //       productDetails.price,
                            //                       //   prodDateTime: DateTime.now()
                            //                       //       .toString(),
                            //                       //   prodSize:
                            //                       //       AppCubit.get(context)
                            //                       //           .sizeValue,
                            //                       //   prodColor:
                            //                       //       AppCubit.get(context)
                            //                       //           .colorValue,
                            //                       // )

                            //                       .then((value) {
                            //                     // AppCubit.get(context)
                            //                     //     .incrementCartId();
                            //                     print(
                            //                         "totallllllllllll ->$totalAmount ");
                            //                     // print(
                            //                     //     'bbbbbbbb->${AppCubit.get(context).cartID}');
                            //                     // print(
                            //                     //     "mmmmmmm-> ${CachedHelper.getData(key: cartId)}");
                            //                     // print(AppCubit.get(context)
                            //                     //     .incrementCartId());
                            //                     print(cart1Model.cartId);
                            //                     AppCubit.get(context)
                            //                         .productQuantity = 1;
                            //                     AppCubit.get(context)
                            //                         .colorValue = '';
                            //                     AppCubit.get(context)
                            //                         .sizeValue = '';
                            //                     // AppCubit.get(context)
                            //                     //     .incrementCartId();

                            //                     showFlutterToast(
                            //                         message:
                            //                             "add_to_cart_success"
                            //                                 .tr);
                            //                   }).catchError((error) {
                            //                     showFlutterToast(
                            //                         message:
                            //                             "add_to_cart_error".tr);
                            //                   });
                            //                   //   }
                            //                   // }
                            //                   print(cart1Model);
                            //                 },
                            //               ),
                            //             ),
                            //             SizedBox(
                            //               height: height * 0.01,
                            //             ),
                            //           ],
                            //         ),
                            //       ),
                            //       InkWell(
                            //         onTap: () {
                            // AppCubit.get(context)
                            //     .changeBoxExpand(context);
                            // print(AppCubit.get(context).boxExpand);
                            //         },
                            //         child: Icon(
                            //           Icons.read_more,
                            //           size: width * 0.1,
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),

                            Align(
                              alignment: AlignmentDirectional.bottomCenter,
                              child: DraggableScrollableSheet(
                                initialChildSize: 0.5,
                                minChildSize: 0.5,
                                maxChildSize: 0.8,
                                builder: (BuildContext context,
                                    ScrollController scrollController) {
                                  // scrollController.addListener(() {
                                  //   AppCubit.get(context)
                                  //       .changeBoxExpand(context);
                                  //   print(AppCubit.get(context).boxExpand);
                                  // });
                                  // scrollController.animateTo(height * 0.5,
                                  //     duration: Duration(milliseconds: 200),
                                  //     curve: Curves.bounceIn);

                                  return Container(
                                    height: height * 0.75,
                                    width: width,
                                    child: Container(
                                      width: width,

                                      height: height,
                                      // AppCubit.get(context).boxExpand
                                      //     ? height * 0.8
                                      //     : height * 0.5,
                                      color: Colors.white,
                                      child: Stack(
                                        alignment:
                                            AlignmentDirectional.topCenter,
                                        children: [
                                          Icon(
                                            Icons.expand_less,
                                            // AppCubit.get(context).boxExpand
                                            //     ? Icons.expand_more
                                            //     : Icons.expand_less,
                                            size: width * 0.11,
                                            color: mainColor,
                                          ),
                                          ListView(
                                            controller: scrollController,
                                            physics: BouncingScrollPhysics(),
                                            // crossAxisAlignment:
                                            //     CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: height * 0.05,
                                              ),
                                              ListTile(
                                                title: Text(productDetails
                                                    .productName!),
                                                subtitle: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: height * 0.01),
                                                  child: Row(
                                                    children: [
                                                      RatingBar.builder(
                                                        itemSize: 15,
                                                        initialRating:
                                                            (productDetails
                                                                    .rate)!
                                                                .toDouble(),
                                                        minRating: 1,
                                                        direction:
                                                            Axis.horizontal,
                                                        allowHalfRating: true,
                                                        itemCount: 5,
                                                        itemPadding: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    4.0),
                                                        itemBuilder:
                                                            (context, _) =>
                                                                Icon(
                                                          Icons.star,
                                                          color: Colors.amber,
                                                        ),
                                                        onRatingUpdate:
                                                            (rating) {
                                                          print(rating);
                                                          AppCubit.get(context)
                                                              .addProductRate(
                                                                  rating
                                                                      .toInt(),
                                                                  productDetails
                                                                      .id!);
                                                        },
                                                      ),
                                                      Spacer(),
                                                      TextButton(
                                                        onPressed: () {
                                                          AppCubit.get(context)
                                                              .getProductReview(
                                                                  productDetails
                                                                      .id!)
                                                              .then(
                                                                (value) => showModalBottomSheet(
                                                                    context: context,
                                                                    builder: (context) =>
                                                                        //   ListView.builder(
                                                                        // itemCount: AppCubit.get(
                                                                        //         context)
                                                                        //     .reviewModel!
                                                                        //     .data!
                                                                        //     .length,
                                                                        // itemBuilder:
                                                                        //     (context, index) =>
                                                                        Container(
                                                                          height:
                                                                              height * 0.8,
                                                                          width:
                                                                              width,
                                                                          color:
                                                                              Colors.grey[300],
                                                                          padding:
                                                                              EdgeInsets.all(width * 0.04),
                                                                          child:
                                                                              Column(
                                                                            children: [
                                                                              Row(
                                                                                children: [
                                                                                  Flexible(
                                                                                    // flex: 1,
                                                                                    child: TextField(
                                                                                        controller: reviewController,
                                                                                        decoration: InputDecoration(
                                                                                          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 3),
                                                                                          fillColor: Colors.white,
                                                                                          filled: true,
                                                                                          hintText: "review_hint".tr,
                                                                                          border: OutlineInputBorder(
                                                                                            borderSide: BorderSide.none,
                                                                                            borderRadius: BorderRadius.circular(45),
                                                                                          ),
                                                                                        )),
                                                                                  ),
                                                                                  SizedBox(
                                                                                    width: width * 0.02,
                                                                                  ),
                                                                                  Padding(
                                                                                    padding: EdgeInsets.all(width * 0.025),
                                                                                    child: IconButtonWidget(
                                                                                      icon: Icons.send_rounded,
                                                                                      radius: width * 0.05,
                                                                                      size: width * 0.05,
                                                                                      onpressed: () {
                                                                                        if (reviewController.text.isEmpty) {
                                                                                          showFlutterToast(message: 'write_any_thing'.tr);
                                                                                        } else {
                                                                                          AppCubit.get(context).addProductReview(
                                                                                            reviewController.text,
                                                                                            productDetails.id!,
                                                                                          );
                                                                                          reviewController.clear();
                                                                                          back(context);
                                                                                        }
                                                                                      },
                                                                                    ),
                                                                                  ),
                                                                                  SizedBox(
                                                                                    width: width * 0.02,
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              SizedBox(
                                                                                height: height * 0.02,
                                                                              ),
                                                                              Flexible(
                                                                                // flex: 1,
                                                                                child: ListView.builder(
                                                                                  itemCount: AppCubit.get(context).reviewModel!.data!.length,
                                                                                  itemBuilder: (context, index) => ListTile(
                                                                                    leading: ClipOval(
                                                                                      child: CachedNetworkImageWidget(
                                                                                        width: width * 0.15,
                                                                                        height: height * 0.1,
                                                                                        image: "${AppCubit.get(context).reviewModel!.data![index].customerImage}",
                                                                                      ),
                                                                                    ),
                                                                                    title: Text("${AppCubit.get(context).reviewModel!.data![index].customerName}"),
                                                                                    subtitle: Text("${AppCubit.get(context).reviewModel!.data![index].review}"),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        )),
                                                                // ),
                                                              );
                                                        },
                                                        child:
                                                            Text("reviews".tr),
                                                      ),
                                                      // SizedBox(
                                                      //   width: width * 0.06,
                                                      // ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                              '(${productDetails.rate ?? 1})'),
                                                          Icon(
                                                            Icons.star,
                                                            color: Colors.amber,
                                                            size: width * 0.05,
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                trailing: Text(
                                                    '${double.parse(productDetails.sale!) > 0 ? productDetails.sale : productDetails.price}' +
                                                        "sar".tr),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: width * 0.03,
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text("size".tr),
                                                    Container(
                                                      width: width / 2,
                                                      height: height * 0.07,
                                                      child: SelectorItem(
                                                          width: width * 0.09,
                                                          height: height * 0.04,
                                                          sizes: (productDetails
                                                              .sizes),
                                                          selectedSize:
                                                              AppCubit.get(
                                                                      context)
                                                                  .sizeValue,
                                                          onSizeSelected:
                                                              (value) {
                                                            AppCubit.get(
                                                                    context)
                                                                .selectProductSize(
                                                                    value);
                                                            // selectSize = value;
                                                            print(value);
                                                            print(AppCubit.get(
                                                                    context)
                                                                .sizeValue);
                                                          }),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: width * 0.03),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text("color".tr),
                                                    Container(
                                                      width: width / 2,
                                                      height: height * 0.07,
                                                      child: SelectorItem(
                                                          width: width * 0.09,
                                                          height: height * 0.04,
                                                          sizes: productDetails
                                                              .colors,
                                                          selectedSize:
                                                              AppCubit.get(
                                                                      context)
                                                                  .colorValue,
                                                          colorView: true,
                                                          onSizeSelected:
                                                              (value) {
                                                            // selectColor = '';
                                                            // selectColor = value;
                                                            AppCubit.get(
                                                                    context)
                                                                .selectProductColor(
                                                                    value);
                                                            print(value);
                                                            print(AppCubit.get(
                                                                    context)
                                                                .colorValue);
                                                          }),
                                                      // child: ListView.builder(
                                                      //     scrollDirection: Axis.horizontal,
                                                      //     itemCount: productColors.length,
                                                      //     itemBuilder: (context, index) =>
                                                      //         Padding(
                                                      //           padding:
                                                      //               EdgeInsets.all(width * 0.01),
                                                      //           child: CircleAvatar(
                                                      //             radius: width * 0.05,
                                                      //             backgroundColor: Colors.black54,
                                                      //             child: CircleAvatar(
                                                      //               radius: width * 0.04,
                                                      //               backgroundColor: Colors.white,
                                                      //               child: CircleAvatar(
                                                      //                 radius: width * 0.035,
                                                      //                 backgroundColor: HexColor(
                                                      //                     productColors[index]),
                                                      //               ),
                                                      //             ),
                                                      //           ),
                                                      //         )),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: width * 0.03,
                                                    vertical: width * 0.01),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text("الكمية"),
                                                    Container(
                                                      width: width / 2,
                                                      height: height * 0.06,
                                                      child: Row(
                                                        children: [
                                                          InkWell(
                                                            onTap: () {
                                                              AppCubit.get(
                                                                      context)
                                                                  .incressProductQuantity();
                                                              print(AppCubit.get(
                                                                      context)
                                                                  .productQuantity);
                                                            },
                                                            child: Container(
                                                              width:
                                                                  width * 0.08,
                                                              height: height *
                                                                  0.045,
                                                              color: Colors
                                                                  .grey[200],
                                                              child: Icon(
                                                                Icons.add,
                                                                size: width *
                                                                    0.05,
                                                              ),
                                                            ),
                                                          ),
                                                          Flexible(
                                                            // flex: 1,
                                                            child: Container(
                                                              margin: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          width *
                                                                              0.03),
                                                              height: height *
                                                                  0.045,
                                                              color: Colors
                                                                  .grey[200],
                                                              child: Center(
                                                                child: Text(
                                                                  AppCubit.get(
                                                                          context)
                                                                      .productQuantity!
                                                                      .toString(),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          InkWell(
                                                            onTap: () {
                                                              AppCubit.get(
                                                                      context)
                                                                  .decressProductQuantity()
                                                                  .then(
                                                                      (value) {
                                                                if (AppCubit.get(
                                                                            context)
                                                                        .productQuantity ==
                                                                    1)
                                                                  showFlutterToast(
                                                                      message:
                                                                          "min_quantity_is_1"
                                                                              .tr);
                                                              });
                                                              print(AppCubit.get(
                                                                      context)
                                                                  .productQuantity);
                                                            },
                                                            child: Container(
                                                              width:
                                                                  width * 0.08,
                                                              height: height *
                                                                  0.045,
                                                              color: Colors
                                                                  .grey[200],
                                                              child: Icon(
                                                                Icons.remove,
                                                                size: width *
                                                                    0.05,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              // if (AppCubit.get(context)
                                              //     .boxExpand) ...[
                                              SizedBox(
                                                height: height * 0.01,
                                              ),
                                              // Padding(
                                              //   padding: EdgeInsets.symmetric(
                                              //       horizontal: width * 0.03,
                                              //       vertical: width * 0.01),
                                              //   child: Container(
                                              //     height: height * 0.3,
                                              //     child:
                                              //         SingleChildScrollView(
                                              //       child: Column(
                                              //         crossAxisAlignment:
                                              //             CrossAxisAlignment
                                              //                 .start,
                                              //         children: [
                                              //           Text(
                                              //               "description".tr),
                                              //           SizedBox(
                                              //             height:
                                              //                 height * 0.01,
                                              //           ),
                                              //           // Text(productDetails
                                              //           //     .productDescription!),
                                              //         ],
                                              //       ),
                                              //     ),
                                              //   ),
                                              // ),
                                              // // ],
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: width * 0.03,
                                                    vertical: width * 0.01),
                                                child: Text("description".tr),
                                              ),
                                              SizedBox(
                                                height: height * 0.01,
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: width * 0.03,
                                                    vertical: width * 0.01),
                                                child: Text(productDetails
                                                    .productDescription!),
                                              ),
                                              // Spacer(),
                                              Align(
                                                alignment: AlignmentDirectional
                                                    .bottomCenter,
                                                child: CommonButton(
                                                  text: 'add_cart'.tr,
                                                  width: width * 0.85,
                                                  containerColor: buttonColor,
                                                  textColor: buttonTextColor,
                                                  onTap: () {
                                                    // if (AppCubit.get(context)
                                                    //         .carts
                                                    //         .length ==
                                                    //     0) {
                                                    //   totalAmount = 0.0;
                                                    // }

                                                    if (AppCubit.get(context)
                                                                .colorValue ==
                                                            '' ||
                                                        AppCubit.get(context)
                                                                .sizeValue ==
                                                            '') {
                                                      showFlutterToast(
                                                          message:
                                                              "add_to_cart_error"
                                                                  .tr);
                                                    }
                                                    var cart1Model = CartModel(
                                                      // cartId: CachedHelper.getData(
                                                      //     key: cartId),
                                                      cartId: DateTime.now()
                                                          .toIso8601String(),
                                                      prodId:
                                                          productDetails.id!,
                                                      customerId: userId,
                                                      prodTitle: productDetails
                                                          .productName,
                                                      prodImage: productDetails
                                                          .productImage,
                                                      prodQuantity:
                                                          AppCubit.get(context)
                                                              .productQuantity,
                                                      prodPrice: double.parse(
                                                                  productDetails
                                                                      .sale!) >
                                                              0
                                                          ? productDetails.sale
                                                          : productDetails
                                                              .price,
                                                      proddateTime:
                                                          DateTime.now()
                                                              .toString(),
                                                      prodSize:
                                                          AppCubit.get(context)
                                                              .sizeValue,
                                                      prodColor:
                                                          AppCubit.get(context)
                                                              .colorValue,
                                                    );
                                                    for (int i = 0;
                                                        i <
                                                            AppCubit.get(
                                                                    context)
                                                                .carts
                                                                .length;
                                                        i++) {
                                                      if (AppCubit.get(context)
                                                                  .carts[i]
                                                                  .prodId ==
                                                              cart1Model
                                                                  .prodId &&
                                                          AppCubit.get(context)
                                                                  .carts[i]
                                                                  .prodColor ==
                                                              cart1Model
                                                                  .prodColor &&
                                                          AppCubit.get(context)
                                                                  .carts[i]
                                                                  .prodSize ==
                                                              cart1Model
                                                                  .prodSize) {
                                                        return showFlutterToast(
                                                            message:
                                                                "already_exist"
                                                                    .tr);
                                                      }
                                                    }
                                                    //   } else {
                                                    AppCubit.get(context)
                                                        .addToCart(cart1Model)
                                                        //     .addToCart(
                                                        //   prodId: productDetails.id,
                                                        //   customerId: userId,
                                                        //   prodTitle: productDetails
                                                        //       .productName,
                                                        //   prodImage: productDetails
                                                        //       .productImage,
                                                        //   prodQuantity:
                                                        //       AppCubit.get(context)
                                                        //           .productQuantity
                                                        //           .toString(),
                                                        //   prodPrice:
                                                        //       productDetails.price,
                                                        //   prodDateTime: DateTime.now()
                                                        //       .toString(),
                                                        //   prodSize:
                                                        //       AppCubit.get(context)
                                                        //           .sizeValue,
                                                        //   prodColor:
                                                        //       AppCubit.get(context)
                                                        //           .colorValue,
                                                        // )

                                                        .then((value) {
                                                      // AppCubit.get(context)
                                                      //     .incrementCartId();
                                                      print(
                                                          "totallllllllllll ->$totalAmount ");
                                                      // print(
                                                      //     'bbbbbbbb->${AppCubit.get(context).cartID}');
                                                      // print(
                                                      //     "mmmmmmm-> ${CachedHelper.getData(key: cartId)}");
                                                      // print(AppCubit.get(context)
                                                      //     .incrementCartId());
                                                      print(cart1Model.cartId);
                                                      AppCubit.get(context)
                                                          .productQuantity = 1;
                                                      AppCubit.get(context)
                                                          .colorValue = '';
                                                      AppCubit.get(context)
                                                          .sizeValue = '';
                                                      // AppCubit.get(context)
                                                      //     .incrementCartId();

                                                      showFlutterToast(
                                                          message:
                                                              "add_to_cart_success"
                                                                  .tr);
                                                    }).catchError((error) {
                                                      showFlutterToast(
                                                          message:
                                                              "add_to_cart_error"
                                                                  .tr);
                                                    });
                                                    //   }
                                                    // }
                                                    print(cart1Model);
                                                  },
                                                ),
                                              ),
                                              SizedBox(
                                                height: height * 0.01,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
              ),
            );
          });
        });
  }
}
