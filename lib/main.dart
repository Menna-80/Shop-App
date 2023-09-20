import 'package:bloc/bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app_layout/cubit/states.dart';
import 'package:shop_app/shared/bloc_observer.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/network/local/shared_pref.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/themes.dart';
import 'layout/shop_app_layout/cubit/cubit.dart';
import 'layout/shop_app_layout/shop.dart';
import 'modules/shop_app/login/shop_login.dart';
import 'modules/shop_app/on_board_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CachHelper.init();
  Widget widget;
  bool? OnBoarding =CachHelper.getData(key: 'OnBoarding');
  token =CachHelper.getData(key: 'token');
  print(token);
  if (OnBoarding != null){
    if(token != null) widget=ShopHomeScreen();
    else widget= ShopLoginScreen();
  }else widget=OnBoardScreen();
 // print(OnBoarding);

  runApp(MyApp(startwidget: widget));
}

class MyApp extends StatelessWidget {
 final Widget startwidget;
  MyApp({required this.startwidget});
   @override
  Widget build(BuildContext context) {
    // constructor
    return MultiBlocProvider(
      providers: [

         BlocProvider(
          create: (context) => ShopCubit()..getHomeData()..getCategoryData()..getFAVData()..getUserData(),
        ),
      ],
      child: BlocConsumer<ShopCubit, ShopStates>(
        builder: (BuildContext context, state) {
          return MaterialApp(
            theme: lighttheme,
            darkTheme: darktheme,
            themeMode: ShopCubit.get(context).isDark
                ? ThemeMode.dark
                : ThemeMode.light,
            debugShowCheckedModeBanner: false,
            home: startwidget,
          );
        },
        listener: (BuildContext context, Object? state) {},
      ),
    );
  }
}
