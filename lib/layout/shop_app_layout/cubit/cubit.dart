import 'package:bloc/bloc.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app_layout/cubit/states.dart';
import '../../../models/shop_app/catogry_model.dart';
import '../../../models/shop_app/favorites_model.dart';

import '../../../models/shop_app/home_model.dart';
import '../../../models/shop_app/icon_fav_model.dart';
import '../../../models/shop_app/shop_login.dart';
import '../../../modules/shop_app/catogries/catogry_view.dart';
import '../../../modules/shop_app/favorites/favorites_view.dart';
import '../../../modules/shop_app/products/products_view.dart';
import '../../../modules/shop_app/settings/settings_view.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/network/end_points.dart';
import '../../../shared/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopinitState());
  static ShopCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<Widget> screens = [
    ProductsScreen(),
    CatogryScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  void changeNav(int index) {
    currentIndex = index;
    emit(BottomNavBarState());
  }

  HomeModel? homeModel;
  Map<int, bool> fav = {};

  void getHomeData() {
    emit(ShopHomeLoadingState());
    DioHelper.getData(
      url: Home,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromjson(value?.data);
      homeModel?.data.products.forEach((element) {
        fav.addAll({
          element.id: element.in_favorite,
        });
      });
      emit(ShopHomeSuccessState());
    }).catchError((onError) {
      print(onError.toString());
      emit(ShopHomeErrorState());
    });
  }

  CategoryModel? categoryModel;
  void getCategoryData() {
    DioHelper.getData(
      url: CATEGORY,
    ).then((value) {
      categoryModel = CategoryModel.fromjson(value?.data);
      emit(ShopCategorySuccessState());
    }).catchError((onError) {
      print(onError.toString());
      emit(ShopCategoryErrorState());
    });
  }

  ChangeFavoritesModel? favModel;
  void changeFAV(int productID) {
    fav[productID] = !fav[productID]!;
    emit(ShopFAVChangeState());
    DioHelper.postData(
      url: FAVORITES,
      token: token,
      data: {
        'product_id': productID,
      },
    ).then((value) {
      favModel = ChangeFavoritesModel.fromjson(value?.data);
      print(value?.data);
      if (favModel?.status == false) {
        fav[productID] = !fav[productID]!;
      }else {
        getFAVData();
      }

      emit(ShopFAVSuccessState(favModel!));
    }).catchError((onError) {
      fav[productID] = !fav[productID]!;
      emit(ShopFAVErrorState());
    });
  }

 FavoritesScreenModel? favoritesModel;
  void getFAVData() {
    emit(ShopLoadingFavState());
    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value) {
      favoritesModel = FavoritesScreenModel.fromjson(value?.data);
      emit(ShopGetFavSuccessState());
    }).catchError((onError) {
      print(onError.toString());
      emit(ShopGetFavErrorState());
    });
  }

  ShopLoginModel? userModel;

   void getUserData() {
    emit(ShopLoadingUserDataState());
    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      userModel = ShopLoginModel.fromjson(value?.data);
      emit(ShopGetUserDataSuccessState(userModel!));
    }).catchError((onError) {
      print(onError.toString());
      emit(ShopGetUserDataErrorState());
    });
  }

  void updateUserData({
  required String name,
  required String phone,
  required String email,
  }) {
    emit(ShopLoadingupdateUserDataState());
    DioHelper.putData(
      url: updatePROFILE,
      token: token,
      data: {
        'name':name,
        'email':email,
        'phone':phone,

      },
    ).then((value) {
      userModel = ShopLoginModel.fromjson(value?.data);
      emit(ShopupdateUserDataSuccessState(userModel!));
    }).catchError((onError) {
      print(onError.toString());
      emit(ShopupdateUserDataErrorState());
    });
  }

  bool isDark = false;
  void changeMode(){
    isDark = !isDark;
    emit(ChangeModeState());
  }
}
