import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:qattan/constant.dart';
import 'package:qattan/controller/cubit/App_cubit.dart';
import 'package:qattan/controller/cubit_states/app_states.dart';
import 'package:qattan/features/responsive_setup/responsive_builder.dart';
import 'package:qattan/model/favorite_model.dart';
import 'package:qattan/veiw/component_widget/home_widget/popular_item.dart';
import 'package:qattan/veiw/component_widget/home_widget/sale_discount_item.dart';
import 'package:qattan/veiw/component_widget/icon_button_widget.dart';
import 'package:qattan/veiw/component_widget/loading_progress_indecator.dart';
import 'package:qattan/veiw/component_widget/navigator.dart';
import 'package:qattan/veiw/component_widget/text_widget.dart';
import 'package:qattan/veiw/screens/cart/cart_screen.dart';
import 'package:qattan/veiw/screens/home/product_details.dart';
import 'package:qattan/veiw/screens/home/search_screen.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatelessWidget {
  final TextEditingController filterCategoryController =
      TextEditingController();
  final TextEditingController filterSizeController = TextEditingController();
  final TextEditingController filterProductNameController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        // var categoryData = AppCubit.get(context).categoryModel?.data;
        var offerProducts = AppCubit.get(context).offersProductModel?.data;
        var popularProducts = AppCubit.get(context).homeModel?.data;

        return (state is GetCategoryLoadingState ||
                state is GetPopularProductsLoadingState ||
                state is GetofferProductsLoadingState)
            ? LoadingProgressIndecator()
            : RefreshIndicator(
                color: mainColor,
                onRefresh: () async {
                  AppCubit.get(context).getPopularProducts();
                  AppCubit.get(context).getOffersProducts();
                  AppCubit.get(context).getCategory();
                },
                child: SafeArea(
                  child: SingleChildScrollView(
                    child: Stack(
                      alignment: AlignmentDirectional.topCenter,
                      children: [
                        Container(
                          width: 100.w,
                          height: 100.h,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                alignment: AlignmentDirectional.bottomCenter,
                                children: [
                                  Align(
                                    alignment: AlignmentDirectional.topCenter,
                                    child: Container(
                                      width: 100.w,
                                      height: SizerUtil.deviceType ==
                                              DeviceType.mobile
                                          ? 35.h
                                          : 45.h,
                                      decoration: BoxDecoration(
                                        // color: Colors.grey[200],
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(6.w),
                                          bottomRight: Radius.circular(6.w),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 3.w),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height: 0.5.h,
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: InkWell(
                                                    onTap: () {
                                                      AppCubit.get(context)
                                                          .searchOfproduct(
                                                              productName: "",
                                                              categoryId: "",
                                                              size: "10xl")
                                                          .then((value) => goTo(
                                                              context,
                                                              SearchScreen()));
                                                    },
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                          child: TextField(
                                                              decoration:
                                                                  InputDecoration(
                                                            hintStyle:
                                                                TextStyle(
                                                                    fontSize:
                                                                        8.sp),
                                                            enabled: false,
                                                            contentPadding:
                                                                EdgeInsets
                                                                    .symmetric(
                                                              horizontal: 10.w,
                                                            ),
                                                            fillColor:
                                                                Colors.white,
                                                            filled: true,
                                                            hintText:
                                                                "search_hint"
                                                                    .tr,
                                                            prefixIcon: Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(2.w),
                                                              child:
                                                                  CircleAvatar(
                                                                radius: 5.w,
                                                                backgroundColor:
                                                                    mainColor,
                                                                child: Icon(
                                                                  Icons.search,
                                                                  size: 5.w,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                            ),
                                                            border:
                                                                OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide
                                                                      .none,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          6.w),
                                                            ),
                                                          )),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 5.w,
                                                ),
                                                if (userId != null)
                                                  IconButtonWidget(
                                                    icon: Icons
                                                        .shopping_cart_rounded,
                                                    radius: 5.w,
                                                    size: 5.w,
                                                    onpressed: () {
                                                      // AppCubit.get(context)
                                                      //     .getAllCarts()
                                                      //     .then((value) =>
                                                      //
                                                      //        goTo(context, CartScreen()));

                                                      // AppCubit.get(context)
                                                      //     .getTotalPrice();
                                                      goTo(context,
                                                          CartScreen());
                                                    },
                                                  ),
                                              ],
                                            ),
                                            // SizedBox(
                                            //   height:1.h,
                                            // ),
                                            // Text('Category'),
                                            // SizedBox(
                                            //   height:1.h,
                                            // ),
                                            SizedBox(
                                              height: 1.h,
                                            ),

                                            // Align(
                                            //   alignment:
                                            //       AlignmentDirectional
                                            //           .center,
                                            //   child: Container(
                                            //     width: width * 0.63,
                                            //     height: height * 0.09,

                                            //     // alignment: AlignmentDirectional.center,
                                            //     decoration: BoxDecoration(
                                            //         color: buttonColor,
                                            //         borderRadius:
                                            //             BorderRadius
                                            //                 .circular(15)),
                                            //     child: ListView(
                                            //       scrollDirection:
                                            //           Axis.horizontal,
                                            //       children: [
                                            //         TopItem(
                                            //           height: height * 0.07,
                                            //           width: width * 0.8,
                                            //           title:
                                            //               "my_account".tr,
                                            //           // image: "asset/images/Profil_Icon.png",
                                            //           iconSelect: true,
                                            //           icon: Icons.person,
                                            //           onTap: () {
                                            //             goTo(context,
                                            //                 ProfilScreen());
                                            //           },
                                            //         ),
                                            //         TopItem(
                                            //           height: height * 0.07,
                                            //           width: width * 0.8,
                                            //           title: "my_orders".tr,
                                            //           // image:
                                            //           //     "asset/images/list order_Icon.png",
                                            //           iconSelect: true,
                                            //           icon: Icons
                                            //               .shopping_basket,
                                            //           onTap: () async {
                                            //             await Jiffy.locale(
                                            //                 CachedHelper
                                            //                     .getData(
                                            //                         key:
                                            //                             languageKey));
                                            //             AppCubit.get(
                                            //                     context)
                                            //                 .getOrders()
                                            //                 .then((value) =>
                                            //                     goTo(
                                            //                         context,
                                            //                         OrdersScreen()));
                                            //           },
                                            //         ),
                                            //         TopItem(
                                            //           height: height * 0.07,
                                            //           width: width * 0.8,
                                            //           title: "filter".tr,
                                            //           // image: "asset/images/filter.png",
                                            //           iconSelect: true,
                                            //           icon:
                                            //               Icons.filter_list,
                                            //           onTap: () {
                                            //             // showDialog(
                                            //             //   context: context,
                                            //             //   builder: (context) =>
                                            //             //       FilterDialog(
                                            //             //           width: 100.w,
                                            //             //           height: height),
                                            //             // );
                                            //             AppCubit.get(
                                            //                     context)
                                            //                 .changeFilterExpand(
                                            //                     context);
                                            //           },
                                            //         ),
                                            //       ],
                                            //     ),
                                            //   ),
                                            // ),

                                            // SizedBox(
                                            //   height: height * 0.005,
                                            // ),
                                            // Text(
                                            //   'category'.tr,
                                            //   style: TextStyle(
                                            //       fontWeight:
                                            //           FontWeight.bold),
                                            // ),
                                            // offers slider
                                            offerProducts == null
                                                ? LoadingProgressIndecator()
                                                : Container(
                                                    width: 100.w,
                                                    height: 25.h,
                                                    child: CarouselSlider(
                                                      items: offerProducts
                                                          .map((e) =>
                                                              SaleDiscountItem(
                                                                height: 100.h,
                                                                width: 100.w,
                                                                offersProductData:
                                                                    e,
                                                                onTap: () {
                                                                  AppCubit.get(
                                                                          context)
                                                                      .getHomeProductDetails(e
                                                                          .id
                                                                          .toString())
                                                                      .then(
                                                                          (value) {
                                                                    print(
                                                                        ',,,,,,,,,,,,,,,,,,,,,');
                                                                    print(
                                                                        value);
                                                                    goTo(
                                                                        context,
                                                                        ProductDetails());
                                                                  });
                                                                },
                                                              ))
                                                          .toList(),
                                                      options: CarouselOptions(
                                                        height: 50.h,
                                                        aspectRatio: 3 / 4,
                                                        viewportFraction: 1,
                                                        initialPage: 0,
                                                        enableInfiniteScroll:
                                                            true,
                                                        reverse: true,
                                                        autoPlay: true,
                                                        autoPlayInterval:
                                                            Duration(
                                                                seconds: 5),
                                                        autoPlayAnimationDuration:
                                                            Duration(
                                                                seconds: 1),
                                                        autoPlayCurve: Curves
                                                            .fastOutSlowIn,
                                                        enlargeCenterPage: true,
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                      ),
                                                    ),
                                                  ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  // categoryData == null &&
                                  //         !(state is GetCategorySuccessState)
                                  //     ? LoadingProgressIndecator()
                                  //     : Align(
                                  //         alignment: AlignmentDirectional
                                  //             .bottomCenter,
                                  //         child: Container(
                                  //             height: height * 0.11,
                                  //             width: 100.w,
                                  //             padding: EdgeInsets.symmetric(
                                  //               horizontal: width * 0.02,
                                  //             ),
                                  //             child: ListView.separated(
                                  //               physics:
                                  //                   BouncingScrollPhysics(),
                                  //               separatorBuilder:
                                  //                   (context, index) =>
                                  //                       SizedBox(
                                  //                 width: width * 0.02,
                                  //               ),
                                  //               scrollDirection:
                                  //                   Axis.horizontal,
                                  //               itemCount:
                                  //                   categoryData!.length !=
                                  //                               0 ||
                                  //                           categoryData
                                  //                               .isNotEmpty
                                  //                       ? categoryData.length
                                  //                       : 0,
                                  //               itemBuilder:
                                  //                   (context, index) {
                                  //                 return CategoryItem(
                                  //                   height: height * 0.28,
                                  //                   width: width * 0.7,
                                  //                   categoryData:
                                  //                       categoryData[index],
                                  //                   onTap: () {
                                  //                     AppCubit.get(context)
                                  //                         .getSubCategory(
                                  //                             categoryData[
                                  //                                     index]
                                  //                                 .id!)
                                  //                         .then((value) => AppCubit
                                  //                                 .get(
                                  //                                     context)
                                  //                             .getCategoryProducts(
                                  //                                 categoryData[
                                  //                                         index]
                                  //                                     .id!))
                                  //                         .then((value) => goTo(
                                  //                             context,
                                  //                             CategoryScreen(
                                  //                               title: categoryData[
                                  //                                       index]
                                  //                                   .title,
                                  //                               id: categoryData[
                                  //                                       index]
                                  //                                   .id!,
                                  //                             )));
                                  //                   },
                                  //                 );
                                  //               },
                                  //             )),
                                  //       ),
                                ],
                              ),

                              SizedBox(
                                height: 1.h,
                              ),
                              // Padding(
                              //   padding: EdgeInsets.symmetric(horizontal: 8),
                              //   child: Text(
                              //     "sale_discount".tr,
                              //     style:
                              //         TextStyle(fontWeight: FontWeight.bold),
                              //   ),
                              // ),
                              // SizedBox(
                              //   height:1.h,
                              // ),
                              // (offerProducts == null &&
                              //         !(state
                              //             is GetofferProductsSuccessState))
                              //     ? LoadingProgressIndecator()
                              //     : Padding(
                              //         padding:
                              //             EdgeInsets.symmetric(horizontal: 8),
                              //         child: Container(
                              //             height: height * 0.19,
                              //             // width: 100.w,

                              //             child: ListView.separated(
                              //               physics: BouncingScrollPhysics(),
                              //               separatorBuilder:
                              //                   (context, index) => SizedBox(
                              //                 width: width * 0.02,
                              //               ),
                              //               scrollDirection: Axis.horizontal,
                              //               itemCount: offerProducts!.length,
                              //               itemBuilder: (context, index) {
                              //                 return SaleDiscountItem(
                              //                   height: height * 0.9,
                              //                   width: width * 0.8,
                              //                   offersProductData:
                              //                       offerProducts[index],
                              //                   onTap: () {
                              //                     AppCubit.get(context)
                              //                         .getHomeProductDetails(
                              //                             offerProducts[index]
                              //                                 .id
                              //                                 .toString())
                              //                         .then((value) {
                              //                       print(
                              //                           ',,,,,,,,,,,,,,,,,,,,,');
                              //                       print(value);
                              //                       goTo(context,
                              //                           ProductDetails());
                              //                     });
                              //                   },
                              //                 );
                              //                 // return CategoryItem(
                              //                 // height: height * 0.28,
                              //                 // width: width * 0.7,
                              //                 // );
                              //               },
                              //             )),
                              //       ),

                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 3.w),
                                child: TextWidget(
                                  text: "popular".tr,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              // SizedBox(
                              //   height:1.h,
                              // ),

                              (popularProducts == null &&
                                      !(state
                                          is GetPopularProductsSuccessState))
                                  ? LoadingProgressIndecator()
                                  : Expanded(
                                      child: StaggeredGridView.countBuilder(
                                        crossAxisCount: 4,
                                        itemCount:
                                            (popularProducts!.length == 0)
                                                ? 0
                                                : popularProducts.length,
                                        itemBuilder: (BuildContext context,
                                                int index) =>
                                            popularProducts.isEmpty
                                                ? LoadingProgressIndecator()
                                                : Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 2.w),
                                                    child: PopularItem(
                                                      width: 50.w,
                                                      height: 30.h,
                                                      index: index,
                                                      homeData: popularProducts[
                                                          index],
                                                      favColor: AppCubit.get(
                                                                  context)
                                                              .prodFavIds
                                                              .contains(int.parse(
                                                                  popularProducts[
                                                                          index]
                                                                      .id
                                                                      .toString()))
                                                          ? Colors.red
                                                          : mainColor,
                                                      onTap: () {
                                                        // var ccc = AppCubit.get(context)
                                                        //     .prodFavIds
                                                        //     .contains(3);
                                                        // print(AppCubit.get(context)
                                                        //     .prodFavIds);
                                                        // print(AppCubit.get(context)
                                                        //     .prodIds);
                                                        // print(
                                                        //     "lllllllllllllllllll---->$ccc");
                                                        // print(popularProducts[index]
                                                        //     .id
                                                        //     .toString());
                                                        AppCubit.get(context)
                                                            .getHomeProductDetails(
                                                                popularProducts[
                                                                        index]
                                                                    .id
                                                                    .toString())
                                                            .then((value) {
                                                          goTo(context,
                                                              ProductDetails());
                                                        });
                                                      },
                                                      favoritePressed: () {
                                                        print(popularProducts[
                                                                index]
                                                            .productName);
                                                        FavoriteModel
                                                            favoriteModel =
                                                            FavoriteModel(
                                                          prodId: int.parse(
                                                              popularProducts[
                                                                      index]
                                                                  .id!),
                                                          favId: int.parse(
                                                              popularProducts[
                                                                      index]
                                                                  .id!),
                                                          customerId: userId,
                                                          prodImage:
                                                              popularProducts[
                                                                          index]
                                                                      .productImage ??
                                                                  "image",
                                                          prodTitle:
                                                              popularProducts[
                                                                      index]
                                                                  .productName!,
                                                          prodPrice:
                                                              popularProducts[
                                                                      index]
                                                                  .price,
                                                          proddateTime:
                                                              DateTime.now()
                                                                  .toString(),
                                                        );
                                                        AppCubit.get(context)
                                                                .prodFavIds
                                                                .contains(int.parse(
                                                                    popularProducts[index]
                                                                        .id
                                                                        .toString()))
                                                            ? AppCubit.get(
                                                                    context)
                                                                .deleteFavorite(
                                                                  int.parse(popularProducts[
                                                                          index]
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
                                                                            "add_to_favorite_success".tr));
                                                        print(
                                                            "product id ---> ${popularProducts[index].id}");

                                                        print(
                                                            "favorite id --->${favoriteModel.favId}");
                                                      },
                                                    )),
                                        staggeredTileBuilder: (int index) =>
                                            new StaggeredTile.count(
                                                2, index.isEven ? 3 : 2),
                                        mainAxisSpacing: 2.h,
                                        crossAxisSpacing: 1.w,
                                      ),
                                    ),
                              SizedBox(
                                height: 13.h,
                              ),
                              // : Expanded(
                              //     child: ListView.separated(
                              //     physics: BouncingScrollPhysics(),
                              //     separatorBuilder: (context, index) =>
                              //         SizedBox(
                              //       height: height * 0.02,
                              //     ),
                              //     // scrollDirection: Axis.horizontal,
                              //     itemCount:
                              //         (popularProducts!.length == 0)
                              //             ? 0
                              //             : popularProducts.length,
                              //     itemBuilder: (context, index) {
                              //       // ignore: unnecessary_null_comparison
                              //       return popularProducts.isEmpty
                              //           ? LoadingProgressIndecator()
                              //           : Padding(
                              //               padding: EdgeInsets.symmetric(
                              //                   horizontal: 1.w),
                              //               child:

                              //                   PopularItem(
                              //                 height: height * 0.9,
                              //                 width: width * 0.8,
                              //                 homeData:
                              //                     popularProducts[index],
                              //                 favColor: AppCubit.get(
                              //                             context)
                              //                         .prodFavIds
                              //                         .contains(int.parse(
                              //                             popularProducts[
                              //                                     index]
                              //                                 .id
                              //                                 .toString()))
                              //                     ? Colors.red
                              //                     : mainColor,
                              //                 onTap: () {
                              //                   // var ccc = AppCubit.get(context)
                              //                   //     .prodFavIds
                              //                   //     .contains(3);
                              //                   // print(AppCubit.get(context)
                              //                   //     .prodFavIds);
                              //                   // print(AppCubit.get(context)
                              //                   //     .prodIds);
                              //                   // print(
                              //                   //     "lllllllllllllllllll---->$ccc");
                              //                   // print(popularProducts[index]
                              //                   //     .id
                              //                   //     .toString());
                              //                   AppCubit.get(context)
                              //                       .getHomeProductDetails(
                              //                           popularProducts[
                              //                                   index]
                              //                               .id
                              //                               .toString())
                              //                       .then((value) {
                              //                     goTo(context,
                              //                         ProductDetails());
                              //                   });
                              //                 },
                              //                 favoritePressed: () {
                              //                   print(
                              //                       popularProducts[index]
                              //                           .productName);
                              //                   FavoriteModel
                              //                       favoriteModel =
                              //                       FavoriteModel(
                              //                     prodId: int.parse(
                              //                         popularProducts[
                              //                                 index]
                              //                             .id!),
                              //                     favId: int.parse(
                              //                         popularProducts[
                              //                                 index]
                              //                             .id!),
                              //                     customerId: userId,
                              //                     prodImage: popularProducts[
                              //                                 index]
                              //                             .productImage ??
                              //                         "image",
                              //                     prodTitle:
                              //                         popularProducts[
                              //                                 index]
                              //                             .productName!,
                              //                     prodPrice:
                              //                         popularProducts[
                              //                                 index]
                              //                             .price,
                              //                     proddateTime:
                              //                         DateTime.now()
                              //                             .toString(),
                              //                   );
                              //                   AppCubit.get(context)
                              //                           .prodFavIds
                              //                           .contains(int.parse(
                              //                               popularProducts[index]
                              //                                   .id
                              //                                   .toString()))
                              //                       ? AppCubit.get(
                              //                               context)
                              //                           .deleteFavorite(
                              //                             int.parse(popularProducts[
                              //                                     index]
                              //                                 .id
                              //                                 .toString()),
                              //                           )
                              //                           .then((value) =>
                              //                               showFlutterToast(
                              //                                   message:
                              //                                       "delete_success"
                              //                                           .tr))
                              //                       : AppCubit.get(context)
                              //                           .addToFavorite(
                              //                               favoriteModel)
                              //                           .then((value) =>
                              //                               showFlutterToast(
                              //                                   message:
                              //                                       "add_to_favorite_success".tr));
                              //                   print(
                              //                       "product id ---> ${popularProducts[index].id}");

                              //                   print(
                              //                       "favorite id --->${favoriteModel.favId}");
                              //                 },
                              //               ));
                              //       // return CategoryItem(
                              //       // height: height * 0.28,
                              //       // width: width * 0.7,
                              //       // );
                              //     },
                              //   )),
                            ],
                          ),
                        ),
                        // if (AppCubit.get(context).categoryExpand)
                        //   Align(
                        //     alignment: AlignmentDirectional.bottomCenter,
                        //     child: Column(
                        //       children: [
                        //         SizedBox(
                        //           height: height * 0.19,
                        //         ),
                        //         Container(
                        //           margin: EdgeInsets.symmetric(
                        //             horizontal: 5.w,
                        //           ),
                        //           height: height * 0.55,
                        //           width: 100.w,
                        //           decoration: BoxDecoration(
                        //             color: mainColorOpacity,
                        //             borderRadius:
                        //                 BorderRadiusDirectional.circular(
                        //                     5.w),
                        //           ),
                        //           child: categoryData == null &&
                        //                   !(state is GetCategorySuccessState)
                        //               ? LoadingProgressIndecator()
                        //               : Align(
                        //                   alignment: AlignmentDirectional
                        //                       .bottomCenter,
                        //                   child: Container(
                        //                       height: height * 0.5,
                        //                       width: 100.w,
                        //                       padding: EdgeInsets.symmetric(
                        //                         horizontal: width * 0.02,
                        //                       ),
                        //                       child: ListView.separated(
                        //                         physics:
                        //                             BouncingScrollPhysics(),
                        //                         separatorBuilder:
                        //                             (context, index) =>
                        //                                 SizedBox(
                        //                           width:3.w,
                        //                         ),
                        //                         scrollDirection:
                        //                             Axis.vertical,
                        //                         itemCount:
                        //                             categoryData!.length !=
                        //                                         0 ||
                        //                                     categoryData
                        //                                         .isNotEmpty
                        //                                 ? categoryData.length
                        //                                 : 0,
                        //                         itemBuilder:
                        //                             (context, index) {
                        //                           return CategoryItem(
                        //                             height: height * 0.6,
                        //                             width: 100.w,
                        //                             categoryData:
                        //                                 categoryData[index],
                        //                             onTap: () {
                        //                               AppCubit.get(context)
                        //                                   .getSubCategory(
                        //                                       categoryData[
                        //                                               index]
                        //                                           .id!)
                        //                                   .then((value) => AppCubit
                        //                                           .get(
                        //                                               context)
                        //                                       .getCategoryProducts(
                        //                                           categoryData[
                        //                                                   index]
                        //                                               .id!))
                        //                                   .then((value) => goTo(
                        //                                       context,
                        //                                       CategoryScreen(
                        //                                         title: categoryData[
                        //                                                 index]
                        //                                             .title,
                        //                                         id: categoryData[
                        //                                                 index]
                        //                                             .id!,
                        //                                       )));
                        //                             },
                        //                           );
                        //                         },
                        //                       )),
                        //                 ),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // // Align(
                        // //   alignment: AlignmentDirectional.centerEnd,
                        // //   child: Container(
                        // //     margin: EdgeInsets.symmetric(
                        // //       horizontal: 5.w,
                        // //     ),
                        // //     height: height * 0.55,
                        // //     width: 100.w,
                        // // child: PopupMenuButton<String>(
                        // //   icon: Padding(
                        // //     padding: EdgeInsets.all(1.w),
                        // //     child: Icon(
                        // //       Icons.arrow_drop_down,
                        // //       size: width * 0.1,
                        // //       color: Colors.white,
                        // //     ),
                        // //   ),
                        // //   onSelected: (String value) {},
                        // //   itemBuilder: (BuildContext context) {
                        // //     return categoryData!
                        // //         .map<PopupMenuItem<String>>((value) {
                        // //       return PopupMenuItem(
                        // //           child: Text(value.title!),
                        // //           value: value.id!);
                        // //     }).toList();
                        // //   },
                        // // ),
                        // //   ),
                        // // ),
                        // if (AppCubit.get(context).filterExpand)
                        //   Align(
                        //     alignment: AlignmentDirectional.bottomCenter,
                        //     child: Column(
                        //       children: [
                        //         SizedBox(
                        //           height: height * 0.19,
                        //         ),
                        //         Container(
                        //           margin: EdgeInsets.symmetric(
                        //             horizontal: 5.w,
                        //           ),
                        //           height: height * 0.55,
                        //           width: 100.w,
                        //           decoration: BoxDecoration(
                        //             color: mainColorOpacity,
                        //             borderRadius:
                        //                 BorderRadiusDirectional.circular(
                        //                     5.w),
                        //           ),
                        //           child: Column(
                        //             children: [
                        //               Padding(
                        //                 padding: EdgeInsets.all(5.w),
                        //                 child: Stack(
                        //                   children: [
                        //                     TextField(
                        //                       enabled: false,
                        //                       controller:
                        //                           filterCategoryController,
                        //                       style: TextStyle(
                        //                           color: Colors.white,
                        //                           fontWeight:
                        //                               FontWeight.bold),
                        //                       decoration: InputDecoration(
                        //                         hintText:
                        //                             "filter_cat_hint".tr,
                        //                         hintStyle: TextStyle(
                        //                           color: Colors.white,
                        //                           fontWeight: FontWeight.bold,
                        //                         ),
                        //                         disabledBorder:
                        //                             OutlineInputBorder(
                        //                           borderSide: BorderSide(
                        //                             color: Colors.white,
                        //                           ),
                        //                           borderRadius:
                        //                               BorderRadius.circular(
                        //                                   width * 0.1),
                        //                         ),
                        //                         border: OutlineInputBorder(
                        //                             borderRadius:
                        //                                 BorderRadius.circular(
                        //                                     width * 0.1)),
                        //                       ),
                        //                     ),
                        //                     SizedBox(
                        //                       width: width * 0.1,
                        //                     ),
                        //                     Align(
                        //                       alignment: AlignmentDirectional
                        //                           .centerEnd,
                        //                       child: PopupMenuButton<String>(
                        //                         icon: Padding(
                        //                           padding: EdgeInsets.all(
                        //                               1.w),
                        //                           child: Icon(
                        //                             Icons.arrow_drop_down,
                        //                             size: width * 0.1,
                        //                             color: Colors.white,
                        //                           ),
                        //                         ),
                        //                         onSelected: (String value) {
                        //                           filterCategoryController
                        //                               .text = value;
                        //                           print(
                        //                               "nnnnnnnnnnnn-> ${filterCategoryController.text}");
                        //                         },
                        //                         itemBuilder:
                        //                             (BuildContext context) {
                        //                           return AppCubit.get(context)
                        //                               .allCategoryModel!
                        //                               .data!
                        //                               .map<
                        //                                       PopupMenuItem<
                        //                                           String>>(
                        //                                   (value) {
                        //                             return PopupMenuItem(
                        //                                 child: Text(
                        //                                     value.title!),
                        //                                 value: value.id!);
                        //                           }).toList();
                        //                         },
                        //                       ),
                        //                     ),
                        //                   ],
                        //                 ),
                        //               ),
                        //               Padding(
                        //                 padding: EdgeInsets.symmetric(
                        //                     horizontal: 5.w),
                        //                 child: Stack(
                        //                   children: [
                        //                     TextField(
                        //                       enabled: false,
                        //                       controller:
                        //                           filterSizeController,
                        //                       style: TextStyle(
                        //                           color: Colors.white,
                        //                           fontWeight:
                        //                               FontWeight.bold),
                        //                       decoration: InputDecoration(
                        //                         hintText:
                        //                             "filter_size_hint".tr,
                        //                         hintStyle: TextStyle(
                        //                           color: Colors.white,
                        //                           fontWeight: FontWeight.bold,
                        //                         ),
                        //                         disabledBorder:
                        //                             OutlineInputBorder(
                        //                           borderSide: BorderSide(
                        //                             color: Colors.white,
                        //                           ),
                        //                           borderRadius:
                        //                               BorderRadius.circular(
                        //                                   width * 0.1),
                        //                         ),
                        //                         border: OutlineInputBorder(
                        //                             borderRadius:
                        //                                 BorderRadius.circular(
                        //                                     width * 0.1)),
                        //                       ),
                        //                     ),
                        //                     SizedBox(
                        //                       width: width * 0.1,
                        //                     ),
                        //                     Align(
                        //                       alignment: AlignmentDirectional
                        //                           .centerEnd,
                        //                       child: PopupMenuButton<String>(
                        //                         icon: Padding(
                        //                           padding: EdgeInsets.all(
                        //                               1.w),
                        //                           child: Icon(
                        //                             Icons.arrow_drop_down,
                        //                             size: width * 0.1,
                        //                             color: Colors.white,
                        //                           ),
                        //                         ),
                        //                         onSelected: (String value) {
                        //                           filterSizeController.text =
                        //                               value;
                        //                           print(
                        //                               "nnnnnnnnnnnn-> ${filterSizeController.text}");
                        //                         },
                        //                         itemBuilder:
                        //                             (BuildContext context) {
                        //                           return AppCubit.get(context)
                        //                               .sizesItemsFilters
                        //                               .map<
                        //                                       PopupMenuItem<
                        //                                           String>>(
                        //                                   (String value) {
                        //                             return PopupMenuItem(
                        //                                 child: Text(
                        //                                   value,
                        //                                   textAlign: TextAlign
                        //                                       .center,
                        //                                 ),
                        //                                 value: value);
                        //                           }).toList();
                        //                         },
                        //                       ),
                        //                     ),
                        //                   ],
                        //                 ),
                        //               ),
                        //               SizedBox(
                        //                 height: height * 0.03,
                        //               ),
                        //               Padding(
                        //                 padding: EdgeInsets.symmetric(
                        //                     horizontal: 5.w),
                        //                 child: TextField(
                        //                   controller:
                        //                       filterProductNameController,
                        //                   style: TextStyle(
                        //                       color: Colors.white,
                        //                       fontWeight: FontWeight.bold),
                        //                   decoration: InputDecoration(
                        //                     hintText:
                        //                         "filter_product_name_hint".tr,
                        //                     hintStyle: TextStyle(
                        //                       color: Colors.white,
                        //                       fontWeight: FontWeight.bold,
                        //                     ),
                        //                     focusedBorder: OutlineInputBorder(
                        //                       borderSide: const BorderSide(
                        //                         color: Colors.amber,
                        //                       ),
                        //                       borderRadius:
                        //                           BorderRadius.circular(35.0),
                        //                     ),
                        //                     enabledBorder: OutlineInputBorder(
                        //                       borderSide: BorderSide(
                        //                         color: Colors.white,
                        //                       ),
                        //                       borderRadius:
                        //                           BorderRadius.circular(
                        //                               width * 0.1),
                        //                     ),
                        //                     border: OutlineInputBorder(
                        //                       borderSide: BorderSide(
                        //                         color: Colors.white,
                        //                       ),
                        //                       borderRadius:
                        //                           BorderRadius.circular(
                        //                               width * 0.1),
                        //                     ),
                        //                   ),
                        //                 ),
                        //               ),
                        //               SizedBox(
                        //                 height: height * 0.03,
                        //               ),
                        //               CommonButton(
                        //                 text: "search_hint".tr,
                        //                 width: width * 0.55,
                        //                 containerColor: buttonColor,
                        //                 textColor: buttonTextColor,
                        //                 onTap: () {
                        //                   if (filterCategoryController
                        //                           .text.isEmpty &&
                        //                       filterProductNameController
                        //                           .text.isEmpty &&
                        //                       filterSizeController
                        //                           .text.isEmpty) {
                        //                     return showFlutterToast(
                        //                         message:
                        //                             "search_field_empty".tr);
                        //                   }
                        //                   AppCubit.get(context)
                        //                       .searchOfproduct(
                        //                     categoryId:
                        //                         filterCategoryController.text,
                        //                     productName:
                        //                         filterProductNameController
                        //                             .text,
                        //                     size: filterSizeController.text,
                        //                   )
                        //                       .then((value) {
                        //                     goTo(context, FilterScreen());
                        //                     filterProductNameController
                        //                         .clear();
                        //                     filterCategoryController.clear();
                        //                     filterSizeController.clear();
                        //                   });
                        //                 },
                        //               ),
                        //             ],
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                      ],
                    ),
                  ),
                ),
              );
      },
    );
  }
}
