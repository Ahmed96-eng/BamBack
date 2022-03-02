import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:qattan/constant.dart';
import 'package:qattan/controller/cubit/App_cubit.dart';
import 'package:qattan/controller/cubit_states/app_states.dart';
import 'package:qattan/veiw/component_widget/home_widget/search_product_item.dart';
import 'package:qattan/veiw/component_widget/icon_button_widget.dart';
import 'package:qattan/veiw/component_widget/loading_progress_indecator.dart';
import 'package:qattan/veiw/component_widget/navigator.dart';
import 'package:qattan/veiw/component_widget/no_data_widget.dart';
import 'package:qattan/veiw/screens/home/product_details.dart';
import 'package:sizer/sizer.dart';

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
                body: Container(
                  margin: EdgeInsets.all(2.w),
                  width: 100.w,
                  height: 100.h,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          if (lang == 'en')
                            IconButtonWidget(
                              icon: (lang == 'ar')
                                  ? Icons.arrow_forward
                                  : Icons.arrow_back,
                              radius: 5.w,
                              size: 5.w,
                              onpressed: () {
                                back(context);
                                AppCubit.get(context)
                                    .searchModel!
                                    .data!
                                    .length = 0;
                              },
                            ),
                          SizedBox(
                            width: 2.w,
                          ),
                          Expanded(
                            child: TextField(
                              controller: searchController,
                              autofocus: true,
                              textInputAction: TextInputAction.done,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 2.h, vertical: 1.w),
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
                            width: 2.w,
                          ),
                          IconButtonWidget(
                            icon: Icons.search,
                            radius: 5.w,
                            size: 5.w,
                            onpressed: () {
                              AppCubit.get(context).searchOfproduct(
                                  productName: searchController.text,
                                  categoryId: "",
                                  size: "");
                              searchController.clear();
                            },
                          ),
                          SizedBox(
                            width: 7.w,
                          ),
                          if (lang == 'ar')
                            IconButtonWidget(
                              icon: (lang == 'ar')
                                  ? Icons.arrow_forward
                                  : Icons.arrow_back,
                              radius: 5.w,
                              size: 5.w,
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
                        height: 2.h,
                      ),
                      if (state is SearchOfProductLoadingState)
                        LinearProgressIndicator(
                          color: mainColor,
                          minHeight: 1.h,
                        ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Text('Items Found'),
                      //     Text('Filters'),
                      //   ],
                      // ),
                      // SizedBox(
                      //   height: 2.h,
                      // ),

                      if (searchData.length == 0)
                        Container(
                            width: 100.w,
                            height: 53.h,
                            child: NoDataWidget(
                              width: 140.w,
                              height: 40.h,
                            )),

                      if (state is SearchOfProductSuccessState &&
                          searchController.text.isEmpty)
                        Expanded(
                          child: StaggeredGridView.countBuilder(
                            crossAxisCount: 4,
                            itemCount: searchData.length,
                            itemBuilder: (BuildContext context, int index) =>
                                new SearchProductItem(
                              width: 50.w,
                              height: 30.h,
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
                            mainAxisSpacing: 2.h,
                            crossAxisSpacing: 1.w,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            );
    });
  }
}
