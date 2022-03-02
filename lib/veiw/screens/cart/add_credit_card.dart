import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qattan/constant.dart';
import 'package:qattan/controller/cubit/App_cubit.dart';
import 'package:qattan/controller/cubit_states/app_states.dart';
import 'package:qattan/features/responsive_setup/responsive_builder.dart';
import 'package:qattan/veiw/component_widget/app_bar_widget.dart';
import 'package:qattan/veiw/component_widget/common_button.dart';
import 'package:qattan/veiw/component_widget/navigator.dart';
import 'package:qattan/veiw/component_widget/text_form_field_widget.dart';
import 'package:get/get.dart';
import 'package:qattan/veiw/component_widget/text_widget.dart';
import 'package:sizer/sizer.dart';
import '../bottom_nav_bar_layout.dart';

class AddCridetCard extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var accountNumber = TextEditingController();
  var accountExpiryMonth = TextEditingController();
  var accountExpiryYear = TextEditingController();
  var accountSecurityCode = TextEditingController();

  final double? totalPaymentAmount;
  final String? notes;
  final List? productsId;
  final List? productQuantity;
  final List? productPrice;
  final List? productTotalPrice;
  final List? productColor;
  final List? productSize;
  AddCridetCard(
      {this.totalPaymentAmount,
      this.productsId,
      this.productQuantity,
      this.productPrice,
      this.productTotalPrice,
      this.notes,
      this.productColor,
      this.productSize});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          var profileData = AppCubit.get(context).profilModel!.data;
          return SafeArea(
            child: Scaffold(
              appBar: PreferredSize(
                  preferredSize: Size.fromHeight(8.h),
                  child: AppBarWidgets(
                    title: "payment".tr,
                    width: 100.w,
                  )),
              // appBar: AppBar(
              //   elevation: 0,
              //   centerTitle: true,
              //   title: Text("payment".tr),
              //   leading: (lang == 'en')
              //       ? InkWell(
              //           onTap: () {
              //             back(context);
              //           },
              //           child: Padding(
              //             padding: EdgeInsets.all(width * 0.03),
              //             child: IconButtonWidget(
              //               icon: (lang == 'ar')
              //                   ? Icons.arrow_forward
              //                   : Icons.arrow_back,
              //               radius: width * 0.05,
              //               size: width * 0.05,
              //               onpressed: () {
              //                 back(context);
              //               },
              //             ),
              //           ),
              //         )
              //       : Container(),
              //   actions: [
              //     if ((lang == 'ar'))
              //       Padding(
              //         padding: EdgeInsets.all(width * 0.03),
              //         child: InkWell(
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
              //           onTap: () {
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
                    Expanded(
                      // flex: 2,
                      child: Form(
                        key: formKey,
                        child: Container(
                          margin: EdgeInsets.all(5.w),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 2.h,
                                ),
                                TextWidget(
                                    fontWeight: FontWeight.bold,
                                    isSmallText: true,
                                    text: "add_credit_card".tr),
                                SizedBox(
                                  height: 2.h,
                                ),
                                // TextFormFieldWidget(
                                //   hint: "account_name_hint".tr,
                                //   controller: accountName,
                                //   keyboardType: TextInputType.text,
                                // ),
                                // TextFormFieldWidget(
                                //   hint: "bank_hint".tr,
                                // ),
                                TextFormFieldWidget(
                                  hint: "account_number_hint".tr,
                                  controller: accountNumber,
                                  keyboardType: TextInputType.number,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextFormFieldWidget(
                                        hint: "expire_hint_month".tr,
                                        controller: accountExpiryMonth,
                                        keyboardType: TextInputType.datetime,
                                      ),
                                    ),
                                    Expanded(
                                      child: TextFormFieldWidget(
                                        hint: "expire_hint_year".tr,
                                        controller: accountExpiryYear,
                                        keyboardType: TextInputType.datetime,
                                      ),
                                    ),
                                  ],
                                ),
                                TextFormFieldWidget(
                                  hint: "security_code_hint".tr,
                                  controller: accountSecurityCode,
                                  keyboardType: TextInputType.number,
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    CommonButton(
                      text: "add_credit_card".tr,
                      width: 80.w,
                      containerColor: buttonColor,
                      textColor: buttonTextColor,
                      onTap: () {
                        AppCubit.get(context)
                            .addOrder(
                                paymentMethod: "card",
                                shippingLocation: profileData!.location,
                                notes: notes,
                                total: totalPaymentAmount,
                                productsId: productsId as List<int?>,
                                productsPrices: productPrice as List<double?>,
                                productsQuantity: productQuantity as List<int?>,
                                productsTotalPrice: productTotalPrice,
                                productColor: productColor,
                                productsSize: productSize,
                                orders: [
                                  productsId,
                                  productPrice,
                                  productQuantity,
                                ],
                                cardNumber: accountNumber.text,
                                expiryMonth: accountExpiryMonth.text,
                                expiryYear: accountExpiryYear.text,
                                securityCode: accountSecurityCode.text)
                            .then((value) {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) => WillPopScope(
                              onWillPop: () async => false,
                              child: Container(
                                height: 35.h,
                                width: 100.w,
                                color: Colors.grey[300],
                                // margin: EdgeInsets.all(width * 0.04),
                                child: Stack(
                                  alignment: AlignmentDirectional.center,
                                  children: [
                                    Align(
                                        alignment:
                                            AlignmentDirectional.bottomCenter,
                                        child: Container(
                                          height: 25.h,
                                          width: 100.w,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(4.w)),
                                        )),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        CircleAvatar(
                                          radius: 10.w,
                                          backgroundColor: Colors.amber,
                                          child: Icon(Icons.check,
                                              size: 10.w, color: Colors.white),
                                        ),
                                        TextWidget(
                                            fontWeight: FontWeight.bold,
                                            isSmallText: true,
                                            text: "success".tr),
                                        CommonButton(
                                          text: "continue_shopping".tr,
                                          width: 80.w,
                                          containerColor: buttonColor,
                                          textColor: buttonTextColor,
                                          onTap: () {
                                            goToAndFinish(
                                                context, BotomNavBarLayout());
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                          AppCubit.get(context).deleteAllCart();
                          productsId!.clear();
                          productPrice!.clear();
                          productQuantity!.clear();
                        });
                      },
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
