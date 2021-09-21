// @dart=2.9
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:jiffy/jiffy.dart';
import 'package:qattan/constant.dart';
import 'package:qattan/controller/api_dio_helper/dio_helper.dart';
import 'package:qattan/controller/bloc_observer.dart';
import 'package:qattan/controller/cached_helper/cached_helper.dart';
import 'package:qattan/controller/cached_helper/key_constant.dart';
import 'package:qattan/controller/cubit/App_cubit.dart';
import 'package:qattan/controller/cubit/Auth_cubit.dart';
import 'package:qattan/controller/language_helper/Binding.dart';
import 'package:qattan/features/language/translation_app.dart';
import 'package:qattan/veiw/screens/auth/log_in.dart';
import 'package:qattan/veiw/screens/bottom_nav_bar_layout.dart';
import 'package:qattan/veiw/screens/no_internet_connection.dart';
import 'package:qattan/veiw/screens/on_boarding_screen.dart';
import 'package:qattan/veiw/screens/restart_app.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CachedHelper.init();
  AppCubit().onInit();
  AuthCubit().onInit();
  lang = CachedHelper.getData(key: languageKey) ?? 'ar';
  print("lllllllllllllllllllllllaaaaannngggg--->$lang");
  await Jiffy.locale(lang);
  userId = CachedHelper.getData(key: loginTokenId);
  CachedHelper.prefs.reload();
  print(
      "The Total Cached Price before IS -->  ${CachedHelper.getData(key: totalPriceKey)}");
  print("The Total Cached Price before IS -->  $totalAmount");
  // totalAmount = 0.0;
  totalAmount = CachedHelper.getData(key: totalPriceKey) == null
      ? totalAmount
      : CachedHelper.getData(key: totalPriceKey);
  // totalAmount = CachedHelper.getDouble(key: totalPriceKey);
  // CachedHelper.getData(key: cartId);
  // print("The cartID Cached IS -->  ${CachedHelper.getData(key: cartId)}");
  print("The Total Cached Price IS -->  $totalAmount");
  print(
      "The Total Cached2 Price IS -->  ${CachedHelper.getData(key: totalPriceKey)}");
  var onBoarding = CachedHelper.getData(key: onBoardingKey);
  // Widget screenWidget;
  // if (onBoarding != null) {
  //   if (userId != null)
  //     screenWidget = BotomNavBarLayout();
  //   else
  //     screenWidget = LogIn();
  // } else {
  //   screenWidget = OnBoardingScreen();
  // }

  // print("userId is $userId");
  // runApp(MyApp(
  //   screenWidget: screenWidget,
  // ));

  Widget screenWidget;
  if (onBoarding != null) {
    if (userId != null)
      try {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          screenWidget = BotomNavBarLayout();
          print('connected');
        }
      } on SocketException catch (_) {
        // showFlutterToast(message: "check_connection".tr);
        screenWidget = NoInternetConnection();
        print('not connected');
      }
    // screenWidget = BotomNavBarLayout();
    else
      try {
        final result = await InternetAddress.lookup('google.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          screenWidget = LogIn();
          print('connected');
        }
      } on SocketException catch (_) {
        screenWidget = NoInternetConnection();
        // showFlutterToast(message: 'check_connection'.tr);

        print('not connected');
      }
    // screenWidget = LogIn();
  } else {
    screenWidget = OnBoardingScreen();
  }

  print("userId is $userId");
  runApp(RestartWidget(
    child: MyApp(
      screenWidget: screenWidget,
    ),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final Widget screenWidget;

  const MyApp({this.screenWidget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          lazy: false,
          create: (context) => AppCubit()
            ..getCategory()
            ..getAllCategory()
            ..getOffersProducts()
            ..getPopularProducts()
            ..getProfile()
            ..getAllCarts()
            ..getTotalPrice()
            ..getAllFavorites()
            ..getShipping()
          // ..getOrders()
          ,
        ),
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
      ],
      child: GetMaterialApp(
        title: 'Bamback',
        initialBinding: Binding(),
        debugShowCheckedModeBanner: false,
        transitionDuration: Duration(milliseconds: 500),
        // defaultTransition: Transition.zoom,
        translations: TranslationApp(),
        locale: Locale(CachedHelper.getData(key: languageKey) ?? 'ar'),
        fallbackLocale: Locale(CachedHelper.getData(key: languageKey) ?? 'ar'),
        theme: ThemeData(
            primarySwatch: Colors.grey,
            appBarTheme: AppBarTheme(
              titleTextStyle: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
              backwardsCompatibility: false,
              color: mainColor,
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: mainColor,
                statusBarIconBrightness: Brightness.dark,
              ),
            )),
        home: SplashScreenView(
          navigateRoute: screenWidget,
          duration: 5000,
          imageSize: 250,
          imageSrc: "asset/images/main_logo.png",
          text: "Bamback",
          textType: TextType.ColorizeAnimationText,
          textStyle: TextStyle(
            fontSize: 40.0,
          ),
          colors: [
            Colors.blueGrey,
            Colors.blue,
            Colors.yellow,
            Colors.red,
          ],
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}
