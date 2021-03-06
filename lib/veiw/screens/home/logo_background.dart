import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qattan/constant.dart';
import 'package:qattan/controller/cubit/App_cubit.dart';
import 'package:qattan/controller/cubit_states/app_states.dart';
import 'package:qattan/features/responsive_setup/responsive_builder.dart';
import 'package:qattan/veiw/component_widget/category/category_item.dart';
import 'package:qattan/veiw/component_widget/common_button.dart';
import 'package:qattan/veiw/component_widget/loading_progress_indecator.dart';
import 'package:qattan/veiw/component_widget/navigator.dart';
import 'package:qattan/veiw/screens/category/category_screen.dart';
import 'package:get/get.dart';
import 'package:qattan/veiw/screens/home/filter_screen.dart';
import 'package:sizer/sizer.dart';

class LogoBackGround extends StatelessWidget {
  String? textValue = '';
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
          var categoryData = AppCubit.get(context).categoryModel?.data;
          // var offerProducts = AppCubit.get(context).offersProductModel?.data;
          // var popularProducts = AppCubit.get(context).homeModel?.data;

          return Container(
            width: 100.w,
            height: 100.h,
            color: Colors.grey[200],
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                // Container(
                //   // width: width * 0.4,
                //   // height: height * 0.4,
                //   child: Image.asset(
                //     "asset/images/main_logo.png",
                //     fit: BoxFit.cover,
                //     width: width * 0.5,
                //     height: height * 0.4,
                //   ),
                // ),
                if (AppCubit.get(context).categoryExpand)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 15.h,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 5.w,
                        ),
                        height: 65.h,
                        // width: 100.w,
                        decoration: BoxDecoration(
                          // color: mainColor,
                          color: Colors.white.withOpacity(0.5),
                          borderRadius: BorderRadiusDirectional.circular(5.w),
                        ),
                        child: categoryData == null &&
                                !(state is GetCategorySuccessState)
                            ? LoadingProgressIndecator()
                            : Stack(
                                alignment: AlignmentDirectional.topEnd,
                                children: [
                                  Container(
                                      height: 60.h,
                                      width: 100.w,
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 2.w,
                                        vertical: 2.h,
                                      ),
                                      child: ListView.separated(
                                        physics: BouncingScrollPhysics(),
                                        separatorBuilder: (context, index) =>
                                            SizedBox(
                                          width: 3.w,
                                        ),
                                        scrollDirection: Axis.vertical,
                                        itemCount: categoryData!.length != 0 ||
                                                categoryData.isNotEmpty
                                            ? categoryData.length
                                            : 0,
                                        itemBuilder: (context, index) {
                                          return CategoryItem(
                                            height: 10.h,
                                            width: 20.w,
                                            categoryData: categoryData[index],
                                            onTap: () {
                                              AppCubit.get(context)
                                                  .getSubCategory(
                                                      categoryData[index].id!)
                                                  .then((value) => AppCubit.get(
                                                          context)
                                                      .getCategoryProducts(
                                                          categoryData[index]
                                                              .id!))
                                                  .then((value) => goTo(
                                                      context,
                                                      CategoryScreen(
                                                        title:
                                                            categoryData[index]
                                                                .title,
                                                        id: categoryData[index]
                                                            .id!,
                                                      )));
                                            },
                                          );
                                        },
                                      )),
                                  Container(
                                    margin: EdgeInsets.all(1.w),
                                    child: Image.asset(
                                      "asset/images/main_logo.png",
                                      fit: BoxFit.cover,
                                      width: 20.w,
                                      height: 15.h,
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ],
                  ),
                if (AppCubit.get(context).filterExpand)
                  Align(
                    alignment: AlignmentDirectional.topStart,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 15.h,
                          ),
                          Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(
                                  horizontal: 6.w,
                                  vertical: 0.5.h,
                                ),
                                child: Image.asset(
                                  "asset/images/main_logo.png",
                                  fit: BoxFit.cover,
                                  width: 20.w,
                                  height: 15.h,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(
                                  horizontal: 5.w,
                                ),
                                height: 65.h,
                                width: 100.w,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.5),
                                  // color: mainColor,
                                  borderRadius:
                                      BorderRadiusDirectional.circular(5.w),
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 2.w,
                                        vertical: 3.h,
                                      ),
                                      child: Stack(
                                        children: [
                                          TextFormField(
                                            enabled: false,
                                            controller:
                                                filterCategoryController,
                                            style: TextStyle(
                                                // color: Colors.white,
                                                color: mainColor,
                                                fontWeight: FontWeight.bold),
                                            decoration: InputDecoration(
                                              hintText: "filter_cat_hint".tr,
                                              hintStyle: TextStyle(
                                                // color: Colors.white,
                                                color: mainColor,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              disabledBorder:
                                                  OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  // color: Colors.white,
                                                  color: mainColor!,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(10.w),
                                              ),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.w)),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          Align(
                                            alignment:
                                                AlignmentDirectional.centerEnd,
                                            child: PopupMenuButton<String>(
                                              icon: Padding(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 13.w,
                                                ),
                                                child: Icon(
                                                  Icons.arrow_drop_down,
                                                  size: 10.w,
                                                  // color: Colors.white,
                                                  color: mainColor,
                                                ),
                                              ),
                                              onSelected: (String value) {
                                                textValue = value;
                                                AppCubit.get(context)
                                                    .allCategoryModel!
                                                    .data!
                                                    .forEach((element) {
                                                  if (element.id == value) {
                                                    filterCategoryController
                                                        .text = element.title!;
                                                  }
                                                });
                                                print(
                                                    "nnnnnnnnnnnn-> ${filterCategoryController.text}");
                                                print(
                                                    "nnnnnnnnnnnn-> $textValue");
                                              },
                                              itemBuilder:
                                                  (BuildContext context) {
                                                return AppCubit.get(context)
                                                    .allCategoryModel!
                                                    .data!
                                                    .map<PopupMenuItem<String>>(
                                                        (value) {
                                                  return PopupMenuItem(
                                                      child: Text(value.title!),
                                                      value: value.id!);
                                                }).toList();
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 2.w),
                                      child: Stack(
                                        children: [
                                          TextFormField(
                                            enabled: false,
                                            controller: filterSizeController,
                                            style: TextStyle(
                                                // color: Colors.white,
                                                color: mainColor,
                                                fontWeight: FontWeight.bold),
                                            decoration: InputDecoration(
                                              hintText: "filter_size_hint".tr,
                                              hintStyle: TextStyle(
                                                // color: Colors.white,
                                                color: mainColor,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              disabledBorder:
                                                  OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  // color: Colors.white,
                                                  color: mainColor!,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(10.w),
                                              ),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.w)),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          Align(
                                            alignment:
                                                AlignmentDirectional.centerEnd,
                                            child: PopupMenuButton<String>(
                                              icon: Padding(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 13.w,
                                                ),
                                                child: Icon(
                                                  Icons.arrow_drop_down,
                                                  size: 10.w,
                                                  // color: Colors.white,
                                                  color: mainColor,
                                                ),
                                              ),
                                              onSelected: (String value) {
                                                filterSizeController.text =
                                                    value;
                                                print(
                                                    "nnnnnnnnnnnn-> ${filterSizeController.text}");
                                              },
                                              itemBuilder:
                                                  (BuildContext context) {
                                                return AppCubit.get(context)
                                                    .sizesItemsFilters
                                                    .map<PopupMenuItem<String>>(
                                                        (String value) {
                                                  return PopupMenuItem(
                                                      child: Text(
                                                        value,
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                      value: value);
                                                }).toList();
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 3.h,
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 2.w),
                                      child: TextField(
                                        controller: filterProductNameController,
                                        style: TextStyle(
                                            // color: Colors.white,
                                            color: mainColor,
                                            fontWeight: FontWeight.bold),
                                        decoration: InputDecoration(
                                          hintText:
                                              "filter_product_name_hint".tr,
                                          hintStyle: TextStyle(
                                            // color: Colors.white,
                                            color: mainColor,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: mainColor!,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10.w),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              // color: Colors.white,
                                              color: mainColor!,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10.w),
                                          ),
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              // color: Colors.white,
                                              color: mainColor!,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10.w),
                                          ),
                                        ),
                                        textInputAction: TextInputAction.done,
                                        onEditingComplete: () {
                                          if (filterCategoryController
                                                  .text.isEmpty &&
                                              filterProductNameController
                                                  .text.isEmpty &&
                                              filterSizeController
                                                  .text.isEmpty) {
                                            return showFlutterToast(
                                                message:
                                                    "search_field_empty".tr);
                                          }
                                          AppCubit.get(context)
                                              .searchOfproduct(
                                            categoryId: textValue,
                                            productName:
                                                filterProductNameController
                                                    .text,
                                            size: filterSizeController.text,
                                          )
                                              .then((value) {
                                            goTo(context, FilterScreen());
                                            filterProductNameController.clear();
                                            filterCategoryController.clear();
                                            filterSizeController.clear();
                                            textValue = '';
                                            FocusScope.of(context)
                                                .requestFocus(FocusNode());
                                          });
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      height: 3.h,
                                    ),
                                    CommonButton(
                                      text: "search_hint".tr,
                                      width: 50.w,
                                      containerColor: buttonColor,
                                      textColor: buttonTextColor,
                                      onTap: () {
                                        if (filterCategoryController
                                                .text.isEmpty &&
                                            filterProductNameController
                                                .text.isEmpty &&
                                            filterSizeController.text.isEmpty) {
                                          return showFlutterToast(
                                              message: "search_field_empty".tr);
                                        }
                                        AppCubit.get(context)
                                            .searchOfproduct(
                                          categoryId: textValue,
                                          productName:
                                              filterProductNameController.text,
                                          size: filterSizeController.text,
                                        )
                                            .then((value) {
                                          goTo(context, FilterScreen());
                                          filterProductNameController.clear();
                                          filterCategoryController.clear();
                                          filterSizeController.clear();
                                          textValue = '';
                                          FocusScope.of(context)
                                              .requestFocus(FocusNode());
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          );
        });
  }
}
