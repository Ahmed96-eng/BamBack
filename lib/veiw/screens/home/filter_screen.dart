import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:qattan/constant.dart';
import 'package:qattan/controller/cubit/App_cubit.dart';
import 'package:qattan/controller/cubit_states/app_states.dart';
import 'package:qattan/features/responsive_setup/responsive_builder.dart';
import 'package:qattan/veiw/component_widget/home_widget/filter_product_item.dart';
import 'package:qattan/veiw/component_widget/navigator.dart';
import 'package:qattan/veiw/component_widget/no_data_widget.dart';
import 'package:qattan/veiw/screens/home/product_details.dart';

class FilterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          var searchData = AppCubit.get(context).searchModel!.data!;
          return SafeArea(
            child: Scaffold(
              body: ResponsiveBuilder(builder: (context, sizeConfig) {
                final height = sizeConfig.screenHeight!;
                final width = sizeConfig.screenWidth!;
                return Container(
                  margin: EdgeInsets.all(width * 0.02),
                  child: Column(
                    children: [
                      SizedBox(
                        height: height * 0.02,
                      ),
                      if (state is SearchOfProductLoadingState)
                        LinearProgressIndicator(
                          color: mainColor,
                          minHeight: height * 0.01,
                        ),
                      if (searchData.length == 0)
                        Align(
                          alignment: AlignmentDirectional.center,
                          child: Container(
                            height: height * 0.5,
                            child: NoDataWidget(
                              width: width * 1.5,
                              height: height * 0.5,
                            ),
                          ),
                        ),
                      if (state is SearchOfProductSuccessState)
                        Expanded(
                          child: StaggeredGridView.countBuilder(
                            crossAxisCount: 4,
                            itemCount: searchData.length,
                            itemBuilder: (BuildContext context, int index) =>
                                new FilterProductItem(
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
