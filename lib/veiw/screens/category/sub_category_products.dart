import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:qattan/controller/cubit/App_cubit.dart';
import 'package:qattan/controller/cubit_states/app_states.dart';
import 'package:qattan/features/responsive_setup/responsive_builder.dart';
import 'package:qattan/veiw/component_widget/app_bar_widget.dart';
import 'package:qattan/veiw/component_widget/category/sub_category_product_item.dart';
import 'package:qattan/veiw/component_widget/loading_progress_indecator.dart';
import 'package:qattan/veiw/component_widget/navigator.dart';
import 'package:qattan/veiw/component_widget/no_data_widget.dart';
import 'package:qattan/veiw/screens/home/product_details.dart';

class SubCategoryProducts extends StatelessWidget {
  final String? title;

  SubCategoryProducts({this.title});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) =>
          SafeArea(child: ResponsiveBuilder(builder: (context, sizeConfig) {
        final height = sizeConfig.screenHeight!;
        final width = sizeConfig.screenWidth!;
        return AppCubit.get(context).subCategoryProductsModel!.data == null
            ? LoadingProgressIndecator()
            : Scaffold(
                appBar: PreferredSize(
                    preferredSize: Size.fromHeight(height * 0.1),
                    child: AppBarWidgets(
                      title: title!,
                      width: width,
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

                body: ResponsiveBuilder(builder: (context, sizeConfig) {
                  final height = sizeConfig.screenHeight!;
                  final width = sizeConfig.screenWidth!;
                  return AppCubit.get(context)
                              .subCategoryProductsModel!
                              .data!
                              .length ==
                          0
                      ? Align(
                          alignment: AlignmentDirectional.center,
                          child: Container(
                            height: height * 0.5,
                            child: NoDataWidget(
                              width: width * 1.5,
                              height: height * 0.5,
                            ),
                          ),
                        )
                      : Container(
                          margin: EdgeInsets.all(width * 0.02),
                          child: Column(
                            children: [
                              SizedBox(
                                height: height * 0.02,
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
                                    width: width / 2,
                                    height: height * 0.3,
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
                                  mainAxisSpacing: height * 0.02,
                                  crossAxisSpacing: width * 0.01,
                                ),
                              ),
                            ],
                          ),
                        );
                }),
              );
      })),
    );
  }
}
