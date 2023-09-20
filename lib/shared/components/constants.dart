

import '../../modules/shop_app/login/shop_login.dart';
import '../network/local/shared_pref.dart';
import 'components.dart';

void signOut(context){
  CachHelper.removeData(key: 'token').then((value) {
            if(value==true){
              NavigateAndReplace(context, ShopLoginScreen());
            }
          });
}

void printFullData(String text){
  final pattern=RegExp('.{1,800}');
  pattern.allMatches(text).forEach((element) =>print(element.group(0)));
}

String? token ='';