import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:qattan/constant.dart';
import 'package:qattan/controller/api_dio_helper/dio_helper.dart';
import 'package:qattan/controller/api_dio_helper/endpoint_dio.dart';
import 'package:qattan/controller/cached_helper/cached_helper.dart';
import 'package:qattan/controller/cached_helper/key_constant.dart';
import 'package:qattan/controller/cached_helper/sqflite_database/CartDataBaseServices.dart';
import 'package:qattan/controller/cached_helper/sqflite_database/FavoriteDataBaseServices.dart';
import 'package:qattan/controller/cubit_states/app_states.dart';
import 'package:qattan/model/cart_model.dart';
import 'package:qattan/model/category_all_model.dart';
import 'package:qattan/model/category_model.dart';
import 'package:qattan/model/category_products_model.dart';
import 'package:qattan/model/favorite_model.dart';
import 'package:qattan/model/offers_products_model.dart';
import 'package:qattan/model/orders_model.dart';
import 'package:qattan/model/product_details.dart';
import 'package:qattan/model/popular_product_model.dart';
import 'package:qattan/model/profile_model.dart';
import 'package:qattan/model/review_model.dart';
import 'package:qattan/model/search_model.dart';
import 'package:qattan/model/shipping_model.dart';
import 'package:qattan/model/sub_category_model.dart';
import 'package:qattan/model/sub_category_products_model.dart';
import 'package:qattan/veiw/component_widget/common_button.dart';
import 'package:qattan/veiw/component_widget/navigator.dart';
import 'package:qattan/veiw/screens/home/home_screen.dart';
import 'package:qattan/veiw/screens/home/logo_background.dart';
import 'package:qattan/veiw/screens/notification/notification_screen.dart';
import 'package:qattan/veiw/screens/profile/profile_screen.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);
  onInit() {
    // getPopularProducts();
    // getCategory();
    // getOffersProducts();
    CachedHelper.getData(key: loginTokenId);
  }

  CartDataBaseServices dataBaseServices = CartDataBaseServices();
  FavoriteDataBaseServices favoriteDataBaseServices =
      FavoriteDataBaseServices();

  refresh() {
    emit(AppRefreshState());
  }

  getCachesData(key) {
    CachedHelper.getData(key: key);
    emit(AppGetCachedSuccessState());
  }

  // BottomNavBar
  // PersistentTabController controller = PersistentTabController(initialIndex: 0);
  int currentIndex = 0;

  List<Widget> screens = [
    HomeScreen(),
    NotificationScreen(),
    LogoBackGround(),
    LogoBackGround(),
    ProfilScreen(),
  ];

  Future<bool> willPopScop(context) {
    emit(AppChangeBackBottomNavBarState());
    return currentIndex == 1
        ? [currentIndex = 0, emit(AppRefreshState())]
        : currentIndex == 2
            ? [currentIndex = 0, emit(AppRefreshState())]
            : currentIndex == 3
                ? [currentIndex = 0, emit(AppRefreshState())]
                : currentIndex == 4
                    ? [currentIndex = 0, emit(AppRefreshState())]
                    : back(context);
  }

  //   List<Widget> screens = [
  //   HomeScreen(),
  //   NotificationScreen(),
  //   ProfilScreen(),
  // ];

  // Future<bool> willPopScop(context) {
  //   emit(AppChangeBackBottomNavBarState());
  //   return currentIndex == 1
  //       ? [currentIndex = 0, emit(AppRefreshState())]
  //       : currentIndex == 2
  //           ? [currentIndex = 0, emit(AppRefreshState())]
  //           : back(context);
  // }

  void changeBottomnavBarIndex(int index, context) {
    currentIndex = index;
    filterExpand = false;
    categoryExpand = false;
    // if (current_index == 2 || userId == null) {
    //   getProfile();
    // }

    emit(AppChangeBackBottomNavBarState());
  }

// HOME
  PopularProductModel? homeModel;
  List<String> prodIds = [];
  getPopularProducts() {
    try {
      emit(GetPopularProductsLoadingState());

      DioHelper.getData(
        endpoint: POPULARPRODUCTS,
      ).then(
        (value) {
          // print(value.data);
          homeModel = (PopularProductModel.fromJson(value.data));
          // print("00000000000000000000000000000000");
          // print(value.data);
          homeModel!.data!.forEach((element) {
            prodIds.add(element.id!);
          });
          // print(prodIds);

          emit(GetPopularProductsSuccessState());
        },
      ).catchError((error) {
        print("ERROR");
        print(error.toString());
        emit(GetPopularProductsErrorState());
      });
    } catch (e) {
      print(e);
      emit(GetPopularProductsErrorState());
    }
  }

  OffersProductModel? offersProductModel;
  List<OffersProductData> offersNotification = [];

  bool filterExpand = false;
  void changeFilterExpand(BuildContext context) {
    filterExpand = !filterExpand;
    emit(ChangeFilterExpandState());
  }

  bool categoryExpand = false;
  void changeCategoryExpand(BuildContext context) {
    categoryExpand = !categoryExpand;
    emit(ChangeCategoryExpandState());
  }

  getOffersProducts() {
    try {
      emit(GetofferProductsLoadingState());

      DioHelper.getData(
        endpoint: OFFERPRODUCTS,
      ).then(
        (value) {
          // print(value.data);
          offersProductModel = (OffersProductModel.fromJson(value.data));
          // print("00000000000000000000000000000000");
          // print(value.data);
          offersProductModel!.data!.forEach((element) {
            if (DateTime.now().isBefore(
                DateTime.parse(element.createdAt!).add(Duration(days: 1)))) {
              offersNotification.add(element);
            }
          });
          print("offersNotification===>  ${offersNotification.length}");

          emit(GetofferProductsSuccessState());
        },
      ).catchError((error) {
        print("ERROR");
        print(error.toString());
        emit(GetofferProductsErrorState());
      });
    } catch (e) {
      print(e);
      emit(GetofferProductsErrorState());
    }
  }

  //  Details
  bool boxExpand = false;
  void changeBoxExpand(BuildContext context) {
    boxExpand = !boxExpand;
    emit(ChangeBoxExpandState());
  }

  String? sizeValue;
  void selectProductSize(String value) {
    sizeValue = value;

    emit(SelectProductSizeState());
  }

  String? colorValue;
  void selectProductColor(String value) {
    colorValue = value;

    emit(SelectProductColorState());
  }

  int? productQuantity = 1;
  incressProductQuantity() async {
    productQuantity = productQuantity! + 1;

    emit(IncressProductQuantitySuccessState());
  }

  Future decressProductQuantity() async {
    if (productQuantity == 1) {
      print('Min Quantity is 1');
      // showFlutterToast(message: "min_quantity_is_1".tr);
      return;
    }
    productQuantity = productQuantity! - 1;

    emit(DecressProductQuantitySuccessState());
  }

  ProductDetailsModel? productDetailsModel;
  Future getHomeProductDetails(String id) async {
    try {
      emit(GetProductDetailsLoadingState());

      await DioHelper.postData(endpoint: PRODUCTDETAILS, data: {
        "product_id": id,
      }).then(
        (value) {
          print('Detailsssssssssssss');
          print(value.data);

          print('22222222222223');

          productDetailsModel = (ProductDetailsModel.fromJson(value.data));
          print("00000000000000000000000000000000");
          print(productDetailsModel!.data!.sizes);
          print(productDetailsModel!.data!.images);

          emit(GetProductDetailsSuccessState());
        },
      ).catchError((error) {
        print("ERROR");
        print(error.toString());
        emit(GetProductDetailsErrorState());
      });
    } catch (e) {
      print(e);
      emit(GetProductDetailsErrorState());
    }
  }

  addProductReview(String review, String ptoductId) {
    try {
      emit(AddproductReviewLoadingState());

      DioHelper.postData(endpoint: REVIEW, data: {
        "customer_id": userId,
        "product_id": ptoductId,
        "review": review,
      }).then(
        (value) {
          print('lllllllllllllllll');
          print(value);
          emit(AddproductReviewSuccessState());
          // return value;
        },
      ).catchError((error) {
        print("ERROR");
        print(error.toString());
        emit(AddproductReviewErrorState());
      });
    } catch (e) {
      print(e);
      emit(AddproductReviewErrorState());
    }
  }

  addProductRate(int rate, String ptoductId) {
    try {
      emit(AddproductRateLoadingState());

      DioHelper.postData(endpoint: RATE, data: {
        "product_id": ptoductId,
        "rate": rate,
      }).then(
        (value) {
          print('lllllllllllllllll');
          print(value);
          emit(AddproductRateSuccessState());
          // return value;
        },
      ).catchError((error) {
        print("ERROR");
        print(error.toString());
        emit(AddproductRateErrorState());
      });
    } catch (e) {
      print(e);
      emit(AddproductRateErrorState());
    }
  }

  ReviewModel? reviewModel;
  Future getProductReview(String ptoductId) async {
    try {
      emit(GetproductReviewLoadingState());

      await DioHelper.postData(endpoint: REVIEW, data: {
        // "customer_id": userId,
        "product_id": ptoductId,
        // "review": review,
      }).then(
        (value) {
          print('11111111111111');
          print(value.data);
          print(value);

          print('22222222222223');

          reviewModel = (ReviewModel.fromJson(value.data));
          print("00000000000000000000000000000000");
          emit(GetproductReviewSuccessState());
          // return value;
        },
      ).catchError((error) {
        print("ERROR");
        print(error.toString());
        emit(GetproductReviewErrorState());
      });
    } catch (e) {
      print(e);
      emit(GetproductReviewErrorState());
    }
  }

// search

  List<String> sizesItemsFilters = ["s", "m", "l", "xl", "2xl", "3xl", "4xl"];

  SearchModel? searchModel;
  Future searchOfproduct(
      {String? productName, String? size, String? categoryId}) async {
    try {
      emit(SearchOfProductLoadingState());

      await DioHelper.postData(endpoint: SEARCH, data: {
        "product_name": productName,
        "size": size,
        "category_id": categoryId,
      }).then(
        (value) {
          print('11111111111111');
          print(value.data);
          print(value);

          print('22222222222223');

          searchModel = (SearchModel.fromJson(value.data));
          print("00000000000000000000000000000000");
          emit(SearchOfProductSuccessState());
          // return value;
        },
      ).catchError((error) {
        print("ERROR");
        print(error.toString());
        emit(SearchOfProductErrorState());
      });
    } catch (e) {
      print(e);
      emit(SearchOfProductErrorState());
    }
  }

  // category

  bool categoryBoxExpand = false;
  void changeCategoryBoxExpand() {
    categoryBoxExpand = !categoryBoxExpand;
    emit(ChangeCategoryBoxExpandState());
  }

  CategoryModel? categoryModel;
  getCategory() {
    try {
      emit(GetCategoryLoadingState());

      DioHelper.getData(
        endpoint: CATEGORY,
      ).then(
        (value) {
          // print(value.data);
          categoryModel = (CategoryModel.fromJson(value.data));
          // print("00000000000000000000000000000000");
          // print(value.data);

          emit(GetCategorySuccessState());
        },
      ).catchError((error) {
        print("ERROR");
        print(error.toString());
        emit(GetCategoryErrorState());
      });
    } catch (e) {
      print(e);
      emit(GetCategoryErrorState());
    }
  }

  AllCategoryModel? allCategoryModel;
  getAllCategory() {
    try {
      emit(GetAllCategoryLoadingState());

      DioHelper.getData(
        endpoint: ALLCATEGORY,
      ).then(
        (value) {
          // print(value.data);
          allCategoryModel = (AllCategoryModel.fromJson(value.data));
          // print("00000000000000000000000000000000");
          // print(value.data);

          emit(GetAllCategorySuccessState());
        },
      ).catchError((error) {
        print("ERROR");
        print(error.toString());
        emit(GetAllCategoryErrorState());
      });
    } catch (e) {
      print(e);
      emit(GetAllCategoryErrorState());
    }
  }

  CategoryProductsModel? categoryProductsModel;
  Future getCategoryProducts(String catId) async {
    try {
      emit(GetCategoryProductsLoadingState());

      await DioHelper.postData(endpoint: CATEGORYPRODUCTS, data: {
        "category_id": catId,
      }).then(
        (value) {
          print('11111111111111');
          print(value.data);
          print(value);

          print('22222222222223');

          categoryProductsModel = (CategoryProductsModel.fromJson(value.data));
          print("00000000000000000000000000000000");
          emit(GetCategoryProductsSuccessState());
          // return value;
        },
      ).catchError((error) {
        print("ERROR");
        print(error.toString());
        emit(GetCategoryProductsErrorState());
      });
    } catch (e) {
      print(e);
      emit(GetCategoryProductsErrorState());
    }
  }

  SubCategoryModel? subCategoryModel;
  Future getSubCategory(String id) async {
    try {
      emit(SubGetCategoryLoadingState());

      await DioHelper.postData(endpoint: SUBCATEGORY, data: {
        "category_id": id,
      }).then(
        (value) {
          // print('11111111111111');
          // print(value.data);
          // print(value);

          // print('22222222222223');

          subCategoryModel = (SubCategoryModel.fromJson(value.data));

          emit(SubGetCategorySuccessState());
        },
      ).catchError((error) {
        print("ERROR");
        print(error.toString());
        emit(SubGetCategoryErrorState());
      });
    } catch (e) {
      print(e);
      emit(SubGetCategoryErrorState());
    }
  }

  SubCategoryProductsModel? subCategoryProductsModel;
  Future subCategoryProducts(String catId) async {
    try {
      emit(SubGetCategoryProductsLoadingState());

      await DioHelper.postData(endpoint: SUBCATEGORYPRODUCTS, data: {
        "sub_cat_id": catId,
      }).then(
        (value) {
          print('11111111111111');
          print(value.data);
          print(value);

          print('22222222222223');

          subCategoryProductsModel =
              (SubCategoryProductsModel.fromJson(value.data));
          print("00000000000000000000000000000000");
          emit(SubGetCategoryProductsSuccessState());
          // return value;
        },
      ).catchError((error) {
        print("ERROR");
        print(error.toString());
        emit(SubGetCategoryProductsErrorState());
      });
    } catch (e) {
      print(e);
      emit(SubGetCategoryProductsErrorState());
    }
  }

  // profile

  ProfilModel? profilModel;
  getProfile() {
    try {
      emit(GetProfileLoadingState());

      DioHelper.postData(endpoint: PROFILE, data: {
        "user_id": userId,
      }).then(
        (value) {
          // print('11111111111111');
          // print(value.data);
          // print(value);

          // print('22222222222223');

          profilModel = (ProfilModel.fromJson(value.data));

          emit(GetProfileSuccessState());
        },
      ).catchError((error) {
        print("ERROR");
        print(error.toString());
        emit(GetProfileErrorState());
      });
    } catch (e) {
      print(e);
      emit(GetProfileErrorState());
    }
  }

  Future updateProfile({
    String? userName,
    String? location,
    File? imageFile,
  }) async {
    try {
      // String imageName = imageFile.path.split('/').last;
      emit(UpdateProfileLoadingState());

      DioHelper.postData(endpoint: UPDATEPROFILE, data: {
        "customer_id": userId,
        "username": userName,
        "location": location,
        "profile": imageFile != null
            ? await MultipartFile.fromFile(imageFile.path,
                filename: imageFile.path.split('/').last)
            : profilModel!.data!.profileImage,
      }).then(
        (value) {
          print('start updating');
          print(value.data);
          print(value);

          print('end updating');

          profilModel = (ProfilModel.fromJson(value.data));

          emit(UpdateProfileSuccessState());
        },
      ).catchError((error) {
        print("ERROR");
        print(error.toString());
        emit(UpdateProfileErrorState());
      });
    } catch (e) {
      print(e);
      emit(UpdateProfileErrorState());
    }
  }

  final picker = ImagePicker();
  File? profileImage;
  Future getProfileImageSource({required ImageSource imageSource}) async {
    final pickedFile = await picker.getImage(source: imageSource);

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(PickedProfileImageSuccessState());
    } else {
      print('No image selected.');
      emit(PickedProfileImageErrorState());
    }
  }

  Future getProfileImage(BuildContext context,
      {double? height, double? width}) async {
    showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 200,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'Picked Image From',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: height! * 0.1,
                  ),
                  CommonButton(
                    text: "Camera",
                    textColor: Color(0xffF6F6F7),
                    containerColor: Color(0xff126881),
                    height: height,
                    width: width!,
                    onTap: () {
                      getProfileImageSource(imageSource: ImageSource.camera);
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(
                    height: height * 0.15,
                  ),
                  CommonButton(
                    text: "Gallery",
                    textColor: Color(0xffF6F6F7),
                    containerColor: Color(0xff126881),
                    height: height,
                    width: width,
                    onTap: () {
                      getProfileImageSource(imageSource: ImageSource.gallery);
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

// cart

  Future addToCart(CartModel cartModel) async {
    emit(AddToCartLoadingState());

    for (int i = 0; i < carts.length; i++) {
      if (carts[i].prodId == cartModel.prodId &&
          // carts[i].cartId == cartModel.cartId &&
          carts[i].prodColor == cartModel.prodColor &&
          carts[i].prodSize == cartModel.prodSize) {
        // return showFlutterToast(message: "already_exist");
        return;
      }
    }
    dataBaseServices.addToCart(cartModel).then((value) {
      carts.add(cartModel);
      print('00000000000000000==========>');
      // if (carts.length == 0) {
      //   totalAmount = 0.0;
      //   CachedHelper.setDouble(key: totalPriceKey, value: totalAmount);
      // }
      totalAmount +=
          double.parse(cartModel.prodPrice!) * (cartModel.prodQuantity!);
      print('lllllllllllllllll==========>$totalAmount');
      CachedHelper.setData(key: totalPriceKey, value: totalAmount);

      emit(AddToCartSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(AddToCartErrorState());
    });
  }

  // int cartID = 0;
  // incrementCartId() {
  //   cartID++;
  //   CachedHelper.setData(key: cartId, value: cartID);

  //   emit(IncrementCartId());
  // }

  List<CartModel> carts = [];
  Future getAllCarts() async {
    emit(GetAllCartsLoadingState());
    dataBaseServices.showAllCarts().then((value) {
      carts = value;
      print(value);
      print(carts);
      print(carts.length);
      // CachedHelper.removeData(key: totalPriceKey);
      // getTotalPrice();

      emit(GetAllCartsSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetAllCartsErrorState());
    });
  }

  /*
  19-7-2021
  تم تغيير id  ف  ل delete cart الى string
   تم تغيير اسم ال table  to cart in database with column cartid database
   تم تغيير ال cartid to string and put datetime in product details
  */

  Future deleteCart(String id, index) async {
    await dataBaseServices.deleteCart(id).then((value) {
      carts.remove(id);

      totalAmount -=
          double.parse(carts[index].prodPrice!) * (carts[index].prodQuantity!);

      CachedHelper.setDouble(key: totalPriceKey, value: totalAmount);

      // getTotalPrice();
      getAllCarts();
      if (carts.length == 0) {
        totalAmount = 0.0;
        CachedHelper.setDouble(key: totalPriceKey, value: totalAmount);
      }
      emit(DeleteCartSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(DeleteCartErrorState());
    });
  }

  Future deleteAllCart() async {
    await dataBaseServices.deleteAllCart().then((value) {
      carts.clear();

      totalAmount = 0.0;

      CachedHelper.setDouble(key: totalPriceKey, value: totalAmount);

      emit(DeleteCartAllSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(DeleteCartAllErrorState());
    });
  }

  getTotalPrice() {
    carts.forEach((element) {
      totalAmount += double.parse(element.prodPrice!) * (element.prodQuantity!);
      CachedHelper.setDouble(key: totalPriceKey, value: totalAmount);

      // dataBaseServices.updateCart(element);

      print(totalAmount);
      // emit(TotalPriceSuccessState());
    });
    return totalAmount;
  }

  getproductPrice({int? quantity, double? price}) {
    var total = 0.0;
    total += quantity! * price!;

    return total;
  }

  incressQuantity(int index) async {
    carts[index].prodQuantity = carts[index].prodQuantity! + 1;
    totalAmount += double.parse(carts[index].prodPrice!);
    await dataBaseServices.updateCart(carts[index]);
    CachedHelper.setDouble(key: totalPriceKey, value: totalAmount);

    emit(IncressQuantitySuccessState());
  }

  Future decressQuantity(int index) async {
    if (carts[index].prodQuantity! == 1) {
      print('Min Quantity is 1');
      return;
    }
    carts[index].prodQuantity = carts[index].prodQuantity! - 1;
    totalAmount -= double.parse(carts[index].prodPrice!);

    await dataBaseServices.updateCart(carts[index]);
    CachedHelper.setDouble(key: totalPriceKey, value: totalAmount);

    emit(DecressQuantitySuccessState());
  }

// Favorite

  Future addToFavorite(FavoriteModel favoriteModel) async {
    emit(AddToFavoriteLoadingState());

    for (int i = 0; i < favorites.length; i++) {
      if (favorites[i].favId == favoriteModel.favId) {
        return;
      }
    }
    favoriteDataBaseServices.addToFavorite(favoriteModel).then((value) {
      favorites.add(favoriteModel);
      prodFavIds.add(favoriteModel.favId!);
      emit(AddToFavoriteSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(AddToFavoriteErrorState());
    });
  }

  List<FavoriteModel> favorites = [];
  List<int> prodFavIds = [];

  Future getAllFavorites() async {
    emit(GetAllFavoritesLoadingState());
    favoriteDataBaseServices.showAllFavorites().then((value) {
      favorites = value;
      print(value);
      print(favorites);
      print(favorites.length);
      // getTotalPrice();
      favorites.forEach((element) {
        prodFavIds.add(element.favId!);
      });
      print("favIds==> $prodFavIds");
      emit(GetAllFavoritesSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetAllFavoritesErrorState());
    });
  }

  Future deleteFavorite(int id) async {
    favoriteDataBaseServices.deleteFavorite(id).then((value) {
      favorites.remove(id);
      prodFavIds.remove(id);

      getAllFavorites();
      emit(DeleteFavoriteSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(DeleteFavoriteErrorState());
    });
  }

  // orders

  Future addOrder({
    String? paymentMethod,
    String? shippingLocation,
    double? total,
    String? notes,
    List? productsPrices,
    List? productsQuantity,
    List? productsId,
    List? productsSize,
    List? productColor,
    List? productsTotalPrice,
    List? orders,
    String? cardNumber,
    String? expiryYear,
    String? expiryMonth,
    String? securityCode,
  }) async {
    try {
      emit(AddOrdersLoadingState());

      await DioHelper.postData(endpoint: ORDERS, data: {
        "customer_id": userId,
        "payment_method": paymentMethod,
        "shipping_location": shippingLocation,
        "total": total,
        "notes": notes,
        "price": {productsPrices},
        "quantity": {productsQuantity},
        "ids": {productsId},
        "color": {productColor},
        "size": {productsSize},
        "total_product_price": {productsTotalPrice},
        "details": orders,
        "card_number": cardNumber,
        "cvc": securityCode,
        "exp_month": expiryMonth,
        "exp_year": expiryYear,
      }).then(
        (value) {
          print('lllllllllllllllll');
          print(value);
          emit(AddOrdersSuccessState());
          // return value;
        },
      ).catchError((error) {
        print("ERROR");
        print(error.toString());
        emit(AddOrdersErrorState());
      });
    } catch (e) {
      print(e);
      emit(AddOrdersErrorState());
    }
  }

  ShippingModel? shippingModel;
  getShipping() {
    try {
      emit(GetShippingLoadingState());

      DioHelper.getData(
        endpoint: SHIPPING,
      ).then(
        (value) {
          // print(value.data);
          shippingModel = (ShippingModel.fromJson(value.data));
          print("0000000000000 Shipping 0000000000000000000");
          print(value);
          print(value.data.toString());
          print(shippingModel!.shippingAmount);

          emit(GetShippingSuccessState());
        },
      ).catchError((error) {
        print("ERROR");
        print(error.toString());
        emit(GetShippingErrorState());
      });
    } catch (e) {
      print(e);
      emit(GetShippingErrorState());
    }
  }

  Future payment(
      {String? paymentMethod,
      String? cardNumber,
      String? expiryYear,
      String? expiryMonth,
      String? securityCode,
      String? shippingLocation,
      double? total,
      String? notes,
      List? productsPrices,
      List? productsQuantity,
      List? productsId,
      List? productsTotalPrice,
      List? orders}) async {
    try {
      emit(PaymentLoadingState());

      await DioHelper.postData(endpoint: PAYMENT, data: {
        "customer_id": userId,
        "payment_method": paymentMethod,
        "card_number": cardNumber,
        "cvc": securityCode,
        "exp_month": expiryMonth,
        "exp_year": expiryYear,
      }).then(
        (value) {
          print('lllllllllllllllll');
          print(value);
          emit(PaymentSuccessState());
          // return value;
        },
      ).catchError((error) {
        print("ERROR");
        print(error.toString());
        emit(PaymentErrorState());
      });
    } catch (e) {
      print(e);
      emit(PaymentErrorState());
    }
  }

  OrdersModel? ordersModel;
  Future getOrders() async {
    try {
      emit(GetOrdersLoadingState());

      await DioHelper.postData(endpoint: ORDERSLIST, data: {
        "customer_id": userId,
      }).then(
        (value) {
          // print(value.data);
          ordersModel = (OrdersModel.fromJson(value.data));
          print("00000000000000000000000000000000");
          print(value.data);

          emit(GetOrdersSuccessState());
        },
      ).catchError((error) {
        print("ERROR");
        print(error.toString());
        emit(GetOrdersErrorState());
      });
    } catch (e) {
      print(e);
      emit(GetOrdersErrorState());
    }
  }
}
