import 'package:bloc/bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/shop_app/shop_register/cubit/states.dart';

import '../../../../models/shop_app/shop_login.dart';
import '../../../../shared/network/end_points.dart';
import '../../../../shared/network/remote/dio_helper.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates> {
  ShopRegisterCubit() : super(ShopRegisterInitialState());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);
  ShopLoginModel? LoginModel;

  void userRegister({
    required String? email,
    required String? password,
    required String? name,
    required String? phone,
  }) {
    emit(ShopRegisterLoadingState());

    DioHelper.postData(url: register, data: {
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
    }).then((value) {
      //print(value?.data);
      LoginModel = ShopLoginModel.fromjson(value?.data);
      print(LoginModel?.message);
      print(LoginModel?.status);
      print(LoginModel?.data?.token);
      emit(ShopRegisterSuccessState(LoginModel));
    }).catchError((error) {
      print(error.toString());
      emit(ShopRegisterErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_off_rounded;
  bool isPassword = true;
  void passwordVisibality() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_off_rounded : Icons.visibility_rounded;
    emit(ShopPasswordRegisterState());
  }
}
