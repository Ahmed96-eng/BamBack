import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:qattan/constant.dart';
import 'dart:async';
import 'package:qattan/controller/api_base_http/api_service.dart';
import 'package:qattan/controller/api_dio_helper/dio_helper.dart';
import 'package:qattan/controller/api_dio_helper/endpoint_dio.dart';
import 'package:qattan/controller/cached_helper/cached_helper.dart';
import 'package:qattan/controller/cached_helper/key_constant.dart';
import 'package:qattan/controller/cubit_states/Auth_state.dart';
import 'package:qattan/model/auth_model.dart';
// import 'package:connectivity/connectivity.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitialState());
  static AuthCubit get(context) => BlocProvider.of(context);

  APIService apiService = APIService();

  onInit() {
    // initConnectivity();
    // _connectivitySubscription =
    //     _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  refresh() {
    emit(AuthRefreshgState());
  }

  getCachesData(key) {
    CachedHelper.getData(key: key);
    emit(AppGetCachedSuccessState());
  }

  // void login({String? username, String? password}) {
  //   emit(AuthLoginLoadingState());

  //   apiService.postHttpData(endpoint: Endpoints.login, body: {
  //     "username": username!,
  //     "password": password!,
  //   }).then(
  //     (value) {
  //       print(value);

  //       authModel = AuthModelModel.fromJson(value);
  //       print(authModel!.data!.username);
  //       CachedHelper.setData(
  //           key: loginTokenId, value: authModel!.data!.id.toString());
  //       emit(AutLoginSuccessState(authModel!));
  //     },
  //   ).catchError((error) {
  //     print("ERROR");
  //     print(error.toString());
  //     emit(AuthLoginErrorState());
  //   });
  // }

  bool showPassword = true;
  void changeshowPassword(BuildContext context) {
    showPassword = !showPassword;
    emit(ChangeShowPasswordState());
  }

  AuthModelModel? authModel;
  Future<void> logIn({String? username, String? password}) async {
    try {
      emit(AuthLoginLoadingState());

      return await DioHelper.postData(endpoint: LOGIN, data: {
        "username": username,
        "password": password,
      }).then(
        (value) {
          print('pppppppppppppppppp');
          print(value.data);
          print(value);
          authModel = AuthModelModel.fromJson(value.data);
          print(authModel!.data!.username);
          CachedHelper.setData(
              key: loginTokenId, value: authModel!.data!.id.toString());
          userId = authModel!.data!.id;
          print('kkkkkkkkkkkkkk==> $userId');

          emit(AutLoginSuccessState(authModel!));
        },
      ).catchError((error) {
        print("ERROR");
        print(error.toString());
        emit(AuthLoginErrorState());
      });
    } catch (error) {
      print("ERROR");
      print(error.toString());
      emit(AuthLoginErrorState());
    }
  }

  Future register({
    String? email,
    String? password,
    String? username,
    String? phone,
    String? city,
    String? region,
    String? location,
  }) async {
    emit(AuthRegisterLoadingState());

    await DioHelper.postData(endpoint: REGISTER, data: {
      "email": email,
      "password": password,
      "phone": phone,
      "username": username,
      "city": city,
      "region": region,
      "location": location,
    }).then(
      (value) {
        print(value.data);
        authModel = AuthModelModel.fromJson(value.data);
        CachedHelper.setData(
            key: loginTokenId, value: authModel!.data!.id.toString());
        userId = authModel!.data!.id;
        emit(AuthRegisterSuccessState(authModel));
      },
    ).catchError((error) {
      print("ERROR");
      print(error.toString());
      emit(AuthRegisterErrorState());
    });
  }

  Future sendSMS(String phoneNumber) async {
    try {
      emit(SendSMSLoadingState());

      await DioHelper.postData(endpoint: SENDSMS, data: {
        "phone_number": phoneNumber,
      }).then(
        (value) {
          print('SMS Success');
          print(value);
          emit(SendSMSSuccessState());
          // return value;
        },
      ).catchError((error) {
        print("SMS ERROR");
        print(error.toString());
        emit(SendSMSErrorState());
      });
    } catch (e) {
      print(e);
      emit(SendSMSErrorState());
    }
  }

  Future sendOTP(String otp, String phoneNumber) async {
    try {
      emit(SendOTPLoadingState());

      await DioHelper.postData(endpoint: SENDOTP, data: {
        "phone_number": phoneNumber,
        "otp": otp,
      }).then(
        (value) {
          print('OTP Success');
          print(value);
          emit(SendOTPSuccessState());
          // return value;
        },
      ).catchError((error) {
        print("OTP ERROR");
        print(error.toString());
        emit(SendOTPErrorState());
      });
    } catch (e) {
      print(e);
      emit(SendOTPErrorState());
    }
  }

  Future setNewPassword(String newPassword, String phoneNumber) async {
    try {
      emit(SetNewPasswordLoadingState());

      await DioHelper.postData(endpoint: SETNEWPASSWORD, data: {
        "phone_number": phoneNumber,
        "password": newPassword,
      }).then(
        (value) {
          print('Set Success');
          print(value);
          emit(SetNewPasswordSuccessState());
          // return value;
        },
      ).catchError((error) {
        print("Set ERROR");
        print(error.toString());
        emit(SetNewPasswordErrorState());
      });
    } catch (e) {
      print(e);
      emit(SetNewPasswordErrorState());
    }
  }

///////////////////////////////////////
  // String _connectionStatus = 'Unknown';
  // final Connectivity _connectivity = Connectivity();
  // late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  // Future<void> initConnectivity() async {
  //   ConnectivityResult result = ConnectivityResult.none;
  //   // Platform messages may fail, so we use a try/catch PlatformException.
  //   try {
  //     result = await _connectivity.checkConnectivity();
  //     emit(ConecctivitySuccessState());
  //   } on PlatformException catch (e) {
  //     print(e.toString());
  //     emit(ConecctivityErrorState());
  //   }

  //   // If the widget was removed from the tree while the asynchronous platform
  //   // message was in flight, we want to discard the reply rather than calling
  //   // setState to update our non-existent appearance.
  //   // if (mounted) {
  //   //   return Future.value(null);
  //   // }

  //   return _updateConnectionStatus(result);
  // }

  // Future<void> _updateConnectionStatus(ConnectivityResult result) async {
  //   switch (result) {
  //     case ConnectivityResult.wifi:
  //     case ConnectivityResult.mobile:
  //     case ConnectivityResult.none:
  //       _connectionStatus = result.toString();
  //       emit(ConecctivitySuccessState());
  //       break;
  //     default:
  //       _connectionStatus = 'Failed to get connectivity.)';
  //       emit(ConecctivityErrorState());

  //       break;
  //   }
  // }
}
