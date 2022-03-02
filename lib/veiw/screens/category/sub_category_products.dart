import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:qattan/controller/cubit/App_cubit.dart';
import 'package:qattan/controller/cubit_states/app_states.dart';
import 'package:qattan/veiw/component_widget/app_bar_widget.dart';
import 'package:qattan/veiw/component_widget/category/sub_category_product_item.dart';
import 'package:qattan/veiw/component_widget/loading_progress_indecator.dart';
import 'package:qattan/veiw/component_widget/navigator.dart';
import 'package:qattan/veiw/component_widget/no_data_widget.dart';
import 'package:qattan/veiw/screens/home/product_details.dart';
import 'package:sizer/sizer.dart';

class SubCategoryProducts extends StatelessWidget {
  final String? title;

  SubCategoryProducts({this.title});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) => SafeArea(
        child: AppCubit.get(context).subCategoryProductsModel!.data == null
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

                body: AppCubit.get(context)
                            .subCategoryProductsModel!
                            .data!
                            .length ==
                        0
                    ? Align(
                        alignment: AlignmentDirectional.center,
                        child: Container(
                          height: 50.h,
                          child: NoDataWidget(
                            width: 150.w,
                            height: 50.h,
                          ),
                        ),
                      )
                    : Container(
                        margin: EdgeInsets.all(2.w),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 2.h,
                            ),
                            Expanded(
                              child: StaggeredGridView.countBuilder(
                                crossAxisCount: 4,
                                itemCount: AppCubit.get(context)
                                    .subCategoryProductsModel!
                                    .data!
                                    .length,
                                itemBuilder:
                                    (BuildContext context, int index) =>
                                        SubCategoryProductItem(
                                  width: 50.w,
                                  height: 30.h,
                                  index: index,
                                  productData: AppCubit.get(context)
                                      .subCategoryProductsModel!
                                      .data![index],
                                  onTap: () {
                                    AppCubit.get(context)
                                        .getHomeProductDetails(
                                          AppCubit.get(context)
                                              .subCategoryProductsModel!
                                              .data![index]
                                              .id
                                              .toString(),
                                        )
                                        .then((value) =>
                                            goTo(context, ProductDetails()));

                                    // goTo(context, ProductDetails());
                                  },
                                ),
                                staggeredTileBuilder: (int index) =>
                                    new StaggeredTile.count(
                                        2, index.isEven ? 3 : 2),
                                mainAxisSpacing: 2.h,
                                crossAxisSpacing: 1.w,
                              ),
                            ),
                          ],
                        ),
                      )),
      ),
    );
  }
}
