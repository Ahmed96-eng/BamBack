import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:qattan/constant.dart';
import 'package:qattan/controller/cubit/App_cubit.dart';
import 'package:qattan/controller/cubit_states/app_states.dart';
import 'package:qattan/features/responsive_setup/responsive_builder.dart';
import 'package:qattan/veiw/component_widget/common_button.dart';
import 'package:qattan/veiw/component_widget/home_widget/filter_product_item.dart';
import 'package:qattan/veiw/component_widget/icon_button_widget.dart';
import 'package:qattan/veiw/component_widget/navigator.dart';
import 'package:qattan/veiw/component_widget/no_data_widget.dart';
import 'package:qattan/veiw/screens/home/product_details.dart';
import 'package:sizer/sizer.dart';

class FilterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          var searchData = AppCubit.get(context).searchModel!.data!;
          return SafeArea(
            child: Scaffold(
                body: Container(
              margin: EdgeInsets.all(2.w),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: lang == 'ar'
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.start,
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
                            AppCubit.get(context).searchModel!.data!.length = 0;
                          },
                        ),
                      SizedBox(
                        width: 2.w,
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
                            AppCubit.get(context).searchModel?.data!.length = 0;
                          },
                        ),
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
                  if (searchData.length == 0)
                    Align(
                      alignment: AlignmentDirectional.center,
                      child: Container(
                        height: 50.h,
                        child: NoDataWidget(
                          width: 140.w,
                          height: 50.h,
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
                            new StaggeredTile.count(2, index.isEven ? 3 : 2),
                        mainAxisSpacing: 2.h,
                        crossAxisSpacing: 1.w,
                      ),
                    ),
                ],
              ),
            )),
          );
        });
  }
}
