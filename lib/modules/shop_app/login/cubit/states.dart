
import '../../../../models/shop_app/shop_login.dart';

abstract class ShopLoginStates {}
class InitialState  extends ShopLoginStates {}
class ShopLoginLoadingState  extends ShopLoginStates {}
class ShopLoginSuccessState  extends ShopLoginStates {
  final ShopLoginModel? LoginModel;
  ShopLoginSuccessState(this.LoginModel);
}
class ShopLoginErrorState  extends ShopLoginStates {
  final String error;
  ShopLoginErrorState(this.error);

}
class ShopPasswordState  extends ShopLoginStates {}
