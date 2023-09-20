
import '../../../../models/shop_app/shop_login.dart';

abstract class ShopRegisterStates {}
class ShopRegisterInitialState  extends ShopRegisterStates {}
class ShopRegisterLoadingState  extends ShopRegisterStates {}
class ShopRegisterSuccessState  extends ShopRegisterStates {
  final ShopLoginModel? LoginModel;
  ShopRegisterSuccessState(this.LoginModel);
}
class ShopRegisterErrorState  extends ShopRegisterStates {
  final String error;
  ShopRegisterErrorState(this.error);

}
class ShopPasswordRegisterState  extends ShopRegisterStates {}
