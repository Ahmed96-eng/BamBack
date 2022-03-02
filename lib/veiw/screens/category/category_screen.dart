import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qattan/controller/cubit/App_cubit.dart';
import 'package:qattan/controller/cubit_states/app_states.dart';
import 'package:qattan/features/responsive_setup/responsive_builder.dart';
import 'package:qattan/veiw/component_widget/app_bar_widget.dart';
import 'package:qattan/veiw/component_widget/category/category_product_item.dart';
import 'package:qattan/veiw/component_widget/category/sub_category_item.dart';
import 'package:qattan/veiw/component_widget/loading_progress_indecator.dart';
import 'package:qattan/veiw/component_widget/navigator.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:qattan/veiw/component_widget/no_data_widget.dart';
import 'package:qattan/veiw/component_widget/text_widget.dart';
import 'package:qattan/veiw/screens/category/sub_category_products.dart';
import 'package:get/get.dart';
import 'package:qattan/veiw/screens/home/product_details.dart';
import 'package:sizer/sizer.dart';

class CategoryScreen extends StatelessWidget {
  final String? title;
  final String? id;
  CategoryScreen({this.title, this.id});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          var categoryData = AppCubit.get(context).subCategoryModel!.data!;
          return Builder(
            builder: (context) {
              return AppCubit.get(context).subCategoryModel!.data == null
                  ? LoadingProgressIndecator()
                  : Scaffold(
                      appBar: PreferredSize(
                          preferredSize: Size.fromHeight(8.h),
                          child: AppBarWidgets(
                            title: title!,
                            width: 100.w,
                          )),
                      // appBar: AppBar(
                      //   elevation: 0,
                      //   centerTitle: true,
                      //   title: Text(title!),
                      //   leading: (lang == 'en')
                      //       ? Padding(
                      //           padding: EdgeInsets.all(width * 0.03),
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
                      //         )
                      //       : Container(),
                      //   actions: [
                      //     if ((lang == 'ar'))
                      //       Padding(
                      //         padding: EdgeInsets.all(width * 0.03),
                      //         child: IconButtonWidget(
                      //           icon: (lang == 'ar')
                      //               ? Icons.arrow_forward
                      //               : Icons.arrow_back,
                      //           radius: width * 0.05,
                      //           size: width * 0.05,
                      //           onpressed: () {
                      //             back(context);
                      //           },
                      //         ),
                      //       ),
                      //   ],
                      // ),

                      body: Container(
                        width: 100.w,
                        height: 100.h,
                        child: Column(
                          children: [
                            Stack(
                              alignment: AlignmentDirectional.bottomCenter,
                              children: [
                                Container(
                                  width: 100.w,
                                  height: AppCubit.get(context)
                                              .subCategoryModel!
                                              .data!
                                              .length ==
                                          0
                                      ? 0
                                      : AppCubit.get(context).categoryBoxExpand
                                          ? 42.h
                                          : categoryData.length <= 3
                                              ? 20.h
                                              : 32.h,
                                  color: Colors.grey[300],
                                  child: Padding(
                                    padding: EdgeInsets.all(5.w),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // SizedBox(
                                        //   height: height * 0.002,
                                        // ),
                                        TextWidget(
                                            text: 'category'.tr,
                                            fontWeight: FontWeight.bold),

                                        // SizedBox(
                                        //   height: height * 0.01,
                                        // ),
                                        Expanded(
                                          child: GridView.builder(
                                            physics: BouncingScrollPhysics(),
                                            itemCount: AppCubit.get(context)
                                                    .categoryBoxExpand
                                                ? categoryData.length
                                                : categoryData.length < 3
                                                    ? categoryData.length
                                                    : 3,
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 3,
                                              crossAxisSpacing: 1.w,
                                              mainAxisSpacing: 1.w,
                                              // childAspectRatio: 1,
                                            ),
                                            itemBuilder: (context, index) {
                                              return SubCategoryItem(
                                                height: 30.h,
                                                width: 70.w,
                                                subcategoryData:
                                                    categoryData[index],
                                                onTap: () {
                                                  // print(
                                                  //     '----------- ${categoryData[index].parentId.toString()}');
                                                  AppCubit.get(context)
                                                      .subCategoryProducts(
                                                          categoryData[index]
                                                              .id
                                                              .toString())
                                                      .then((value) => goTo(
                                                          context,
                                                          SubCategoryProducts(
                                                            title: categoryData[
                                                                    index]
                                                                .title,
                                                          )));
                                                },
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                if (AppCubit.get(context)
                                        .subCategoryModel!
                                        .data!
                                        .length >
                                    3)
                                  InkWell(
                                    onTap: () {
                                      AppCubit.get(context)
                                          .changeCategoryBoxExpand();
                                      print(AppCubit.get(context)
                                          .categoryBoxExpand);
                                    },
                                    child: Icon(
                                      Icons.remove,
                                      size: 10.w,
                                    ),
                                  ),
                              ],
                            ),
                            AppCubit.get(context)
                                        .categoryProductsModel!
                                        .data!
                                        .length ==
                                    0
                                ? Expanded(
                                    // width: 100.w,
                                    // height: height * 0.68,
                                    child: Align(
                                      alignment: AlignmentDirectional.center,
                                      child: Container(
                                        height: 50.h,
                                        child: NoDataWidget(
                                          width: 150.w,
                                          height: 50.h,
                                        ),
                                      ),
                                    ),
                                  )
                                : Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.all(2.w),
                                      child: StaggeredGridView.countBuilder(
                                        crossAxisCount: 4,
                                        itemCount: AppCubit.get(context)
                                            .categoryProductsModel!
                                            .data!
                                            .length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          print(30.h);

                                          return CategoryProductItem(
                                            width: 50.w,
                                            height: 35.h,
                                            index: index,
                                            categoryProductsData:
                                                AppCubit.get(context)
                                                    .categoryProductsModel!
                                                    .data![index],
                                            onTap: () {
                                              AppCubit.get(context)
                                                  .getHomeProductDetails(
                                                    AppCubit.get(context)
                                                        .categoryProductsModel!
                                                        .data![index]
                                                        .id
                                                        .toString(),
                                                  )
                                                  .then((value) => goTo(context,
                                                      ProductDetails()));

                                              // goTo(context, ProductDetails());
                                            },
                                          );
                                        },
                                        staggeredTileBuilder: (int index) =>
                                            StaggeredTile.count(
                                                2, index.isEven ? 3 : 2),
                                        mainAxisSpacing: 2.h,
                                        crossAxisSpacing: 2.w,
                                      ),
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
