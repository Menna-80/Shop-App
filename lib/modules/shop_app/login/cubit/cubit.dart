import 'package:bloc/bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/shop_app/login/cubit/states.dart';

import '../../../../models/shop_app/shop_login.dart';
import '../../../../shared/network/end_points.dart';
import '../../../../shared/network/remote/dio_helper.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() :super(InitialState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);
   ShopLoginModel? LoginModel;

  void userLogin({
  required String? email,
  required String? password,
}){
    emit(ShopLoginLoadingState());

    DioHelper.postData(
        url: LOGIN,
        data: {
          'email':email,
          'password':password,
        }
    ).then((value) {
      //print(value?.data);
      LoginModel=ShopLoginModel.fromjson(value?.data);
      print(LoginModel?.message);
       print(LoginModel?.status);
      print(LoginModel?.data?.token);
      emit(ShopLoginSuccessState(LoginModel));

    }).catchError((error){
      print(error.toString());
      emit(ShopLoginErrorState(error.toString()));
    });

  }
  IconData suffix= Icons.visibility_off_rounded;
  bool isPassword= true;
  void passwordVisibality(){
    isPassword = !isPassword;
    suffix= isPassword ?Icons.visibility_off_rounded:Icons.visibility_rounded;
    emit(ShopPasswordState());
  }


}