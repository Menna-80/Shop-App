import '../../../models/shop_app/icon_fav_model.dart';
import '../../../models/shop_app/shop_login.dart';

abstract class ShopStates{}

class ShopinitState extends ShopStates{}

class BottomNavBarState extends ShopStates{}

class ShopHomeLoadingState extends ShopStates{}

class ShopHomeSuccessState extends ShopStates{}

class ShopHomeErrorState extends ShopStates{}

class ShopCategorySuccessState extends ShopStates{}

class ShopCategoryErrorState extends ShopStates{}

class ShopFAVSuccessState extends ShopStates{
  final ChangeFavoritesModel model;
  ShopFAVSuccessState(this.model);
}

class ShopFAVErrorState extends ShopStates{}

class ShopFAVChangeState extends ShopStates{}

class ShopLoadingFavState extends ShopStates{}

class ShopGetFavSuccessState extends ShopStates{}

class ShopGetFavErrorState extends ShopStates{}

class ShopGetUserDataSuccessState extends ShopStates{
final ShopLoginModel loginmodel;
ShopGetUserDataSuccessState(this.loginmodel);

}

class ShopGetUserDataErrorState extends ShopStates{}

class ShopLoadingUserDataState extends ShopStates{}

class ShopupdateUserDataSuccessState extends ShopStates{
  final ShopLoginModel loginmodel;
  ShopupdateUserDataSuccessState(this.loginmodel);
}

class ShopupdateUserDataErrorState extends ShopStates{}

class ShopLoadingupdateUserDataState extends ShopStates{}


class ChangeModeState extends ShopStates{}

