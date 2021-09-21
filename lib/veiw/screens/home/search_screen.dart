import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:qattan/constant.dart';
import 'package:qattan/controller/cubit/App_cubit.dart';
import 'package:qattan/controller/cubit_states/app_states.dart';
import 'package:qattan/features/responsive_setup/responsive_builder.dart';
import 'package:qattan/veiw/component_widget/home_widget/search_product_item.dart';
import 'package:qattan/veiw/component_widget/icon_button_widget.dart';
import 'package:qattan/veiw/component_widget/loading_progress_indecator.dart';
import 'package:qattan/veiw/component_widget/navigator.dart';
import 'package:qattan/veiw/component_widget/no_data_widget.dart';
import 'package:qattan/veiw/screens/home/product_details.dart';

class SearchScreen extends StatelessWidget {
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(listener: (context, state) {
      // if (AppCubit.get(context).homeModel?.data!.length == 0 ||
      //     AppCubit.get(context).categoryModel?.data!.length == 0 ||
      //     AppCubit.get(context).offersProductModel?.data!.length == 0) {
      //   LoadingProgressIndecator();
      // }
    }, builder: (context, state) {
      var searchData = AppCubit.get(context).searchModel?.data!;
      return (searchData == null)
          ? LoadingProgressIndecator()
          : SafeArea(
              child: Scaffold(
                body: ResponsiveBuilder(builder: (context, sizeConfig) {
                  final height = sizeConfig.screenHeight!;
                  final width = sizeConfig.screenWidth!;
                  return Container(
                    margin: EdgeInsets.all(width * 0.02),
                    width: width,
                    height: height,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            if (lang == 'en')
                              IconButtonWidget(
                                icon: (lang == 'ar')
                                    ? Icons.arrow_forward
                                    : Icons.arrow_back,
                                radius: width * 0.05,
                                size: width * 0.05,
                                onpressed: () {
                                  back(context);
                                  AppCubit.get(context)
                                      .searchModel!
                                      .data!
                                      .length = 0;
                                },
                              ),
                            SizedBox(
                              width: width * 0.02,
                            ),
                            Expanded(
                              child: TextField(
                                controller: searchController,
                                autofocus: true,
                                textInputAction: TextInputAction.done,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 3),
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: 'Search',
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius: BorderRadius.circular(45),
                                  ),
                                ),
                                onEditingComplete: () {
                                  AppCubit.get(context).searchOfproduct(
                                      productName: searchController.text,
                                      categoryId: "",
                                      size: "");
                                  searchController.clear();
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                },
                              ),
                            ),
                            SizedBox(
                              width: width * 0.02,
                            ),
                            IconButtonWidget(
                              icon: Icons.search,
                              radius: width * 0.05,
                              size: width * 0.05,
                              onpressed: () {
                                AppCubit.get(context).searchOfproduct(
                                    productName: searchController.text,
                                    categoryId: "",
                                    size: "");
                                searchController.clear();
                              },
                            ),
                            SizedBox(
                              width: width * 0.08,
                            ),
                            if (lang == 'ar')
                              IconButtonWidget(
                                icon: (lang == 'ar')
                                    ? Icons.arrow_forward
                                    : Icons.arrow_back,
                                radius: width * 0.05,
                                size: width * 0.05,
                                onpressed: () {
                                  back(context);
                                  AppCubit.get(context)
                                      .searchModel
                                      ?.data!
                                      .length = 0;
                                },
                              ),
                            // InkWell(
                            //   onTap: () {},
                            //   child: Image.asset(
                            //     'asset/images/shop cart_icon.png',
                            //     fit: BoxFit.cover,
                            //     height: height * 0.06,
                            //     width: width * 0.11,
                            //   ),
                            // ),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        if (state is SearchOfProductLoadingState)
                          LinearProgressIndicator(
                            color: mainColor,
                            minHeight: height * 0.01,
                          ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     Text('Items Found'),
                        //     Text('Filters'),
                        //   ],
                        // ),
                        // SizedBox(
                        //   height: height * 0.02,
                        // ),

                        if (searchData.length == 0)
                          Container(
                              width: width,
                              height: height * 0.35,
                              child: NoDataWidget(
                                width: width * 1.4,
                                height: height * 0.4,
                              )),

                        if (state is SearchOfProductSuccessState &&
                            searchController.text.isEmpty)
                          Expanded(
                            child: StaggeredGridView.countBuilder(
                              crossAxisCount: 4,
                              itemCount: searchData.length,
                              itemBuilder: (BuildContext context, int index) =>
                                  new SearchProductItem(
                                width: width / 2,
                                height: height * 0.3,
                                index: index,
                                searchData: searchData[index],
                                onTap: () {
                                  AppCubit.get(context).getHomeProductDetails(
                                      AppCubit.get(context)
                                          .searchModel!
                                          .data![index]
                                          .id
                                          .toString());

                                  goTo(context, ProductDetails());
                                  searchData.length = 0;
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
              ),
            );
    });
  }
}
