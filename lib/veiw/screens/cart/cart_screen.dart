import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qattan/constant.dart';
import 'package:qattan/controller/cubit/App_cubit.dart';
import 'package:qattan/controller/cubit_states/app_states.dart';
import 'package:qattan/features/responsive_setup/responsive_builder.dart';
import 'package:qattan/veiw/component_widget/app_bar_widget.dart';
import 'package:qattan/veiw/component_widget/cart_widget/cart_item.dart';
import 'package:qattan/veiw/component_widget/common_button.dart';
import 'package:qattan/veiw/component_widget/navigator.dart';
import 'package:qattan/veiw/component_widget/no_data_widget.dart';
import 'package:qattan/veiw/component_widget/text_widget.dart';
import 'package:qattan/veiw/screens/cart/payment_screen.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class CartScreen extends StatelessWidget {
  List<int?> productsId = [];
  List<int?> productQuantity = [];
  List<double?> productPrice = [];
  List productSize = [];
  List productColor = [];
  List productTotalPrice = [];
  @override
  Widget build(BuildContext context) {
    print("The Total Cached 4 Price IS -->  $totalAmount");
    // print(
    //     "The Total Cached 5 Price IS -->  ${CachedHelper.getData(key: totalPriceKey)}");
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) => Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(8.h),
            child: AppBarWidgets(
              title: "cart_screen".tr,
              width: 100.w,
            )),
        // appBar: AppBar(
        //   elevation: 0,
        //   centerTitle: true,
        //   title: Text("cart_screen".tr),
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
        //           icon:
        //               (lang == 'ar') ? Icons.arrow_forward : Icons.arrow_back,
        //           radius: width * 0.05,
        //           size: width * 0.05,
        //           onpressed: () {
        //             back(context);
        //           },
        //         ),
        //       ),
        //   ],
        // ),

        body: AppCubit.get(context).carts.length == 0
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
                width: 100.w,
                height: 100.h,
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: AppCubit.get(context).carts.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.all(1.w),
                            child: CartItem(
                              width: 100.w,
                              height: 40.h,
                              cartModel: AppCubit.get(context).carts[index],
                              productTotalPrice:
                                  AppCubit.get(context).getproductPrice(
                                price: double.parse(AppCubit.get(context)
                                    .carts[index]
                                    .prodPrice!),
                                quantity: AppCubit.get(context)
                                    .carts[index]
                                    .prodQuantity,
                              ),
                              deleteFun: () {
                                print(
                                    AppCubit.get(context).carts[index].cartId);
                                AppCubit.get(context)
                                    .deleteCart(
                                        AppCubit.get(context)
                                            .carts[index]
                                            .cartId!,
                                        index)
                                    .then((value) => showFlutterToast(
                                        message: "delete_success".tr,
                                        backgroundColor: Colors.red));
                              },
                              incressFun: () {
                                AppCubit.get(context).incressQuantity(index);
                              },
                              decressFun: () {
                                AppCubit.get(context)
                                    .decressQuantity(index)
                                    .then((value) {
                                  // print(
                                  // AppCubit.get(context).getTotalPrice());
                                  if (AppCubit.get(context)
                                          .carts[index]
                                          .prodQuantity ==
                                      1)
                                    showFlutterToast(
                                        message: "min_quantity_is_1".tr);
                                });
                              },
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      width: 100.w,
                      height: 18.h,
                      padding:
                          EdgeInsets.symmetric(horizontal: 6.w, vertical: 1.h),
                      // color: Colors.black12,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextWidget(
                                  fontWeight: FontWeight.bold,
                                  isSmallText: true,
                                  text: "tottal".tr),
                              TextWidget(
                                fontWeight: FontWeight.w600,
                                isSmallText: true,
                                text:

                                    // AppCubit.get(context).carts.length == 0)
                                    //       ? 0.0.toString()
                                    //       :
                                    "$totalAmount" + "sar".tr,
                                // "\$ ${AppCubit.get(context).totalPrice}",
                                // "\$ ${CachedHelper.getData(key: totalPriceKey)}"
                                // : "0.0"
                                // : "\$ ${AppCubit.get(context).totalPrice.toStringAsFixed(2)}",
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          CommonButton(
                            text: "payment".tr,
                            width: 80.w,
                            containerColor: buttonColor,
                            textColor: buttonTextColor,
                            onTap: () {
                              // print(AppCubit.get(context).carts);
                              AppCubit.get(context).carts.forEach((element) {
                                print(element.prodId!);
                                // print(productsId.length);
                                // productPrice.clear();
                                // productQuantity.clear();
                                // productsId.clear();
                                // productTotal.clear();
                                if (productsId.length ==
                                        AppCubit.get(context).carts.length &&
                                    productPrice.length ==
                                        AppCubit.get(context).carts.length &&
                                    productQuantity.length ==
                                        AppCubit.get(context).carts.length &&
                                    productColor.length ==
                                        AppCubit.get(context).carts.length &&
                                    productSize.length ==
                                        AppCubit.get(context).carts.length) {
                                  return;
                                }
                                productsId.add(int.parse(element.prodId!));
                                productPrice
                                    .add(double.parse(element.prodPrice!));
                                productQuantity.add(element.prodQuantity!);
                                productColor.add(element.prodColor!);
                                productSize.add(element.prodSize!);

                                productTotalPrice
                                    .add(AppCubit.get(context).getproductPrice(
                                  price: double.parse(element.prodPrice!),
                                  quantity: element.prodQuantity!,
                                ));
                                // print(element);
                              });
                              // print(productsId);
                              // print(productPrice);
                              print(productTotalPrice);

                              goTo(
                                  context,
                                  PaymentScreen(
                                    carts: AppCubit.get(context).carts,
                                    // totalPrice: CachedHelper.getData(
                                    //     key: totalPriceKey),
                                    totalPrice: totalAmount,
                                    // totalPrice:
                                    //     AppCubit.get(context).totalPrice,
                                    productPrice: productPrice,
                                    productQuantity: productQuantity,
                                    productsId: productsId,
                                    productTotalPrice: productTotalPrice,
                                    productColor: productColor,
                                    productSize: productSize,
                                  ));
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
