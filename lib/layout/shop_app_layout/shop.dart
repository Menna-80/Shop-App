
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app_layout/cubit/states.dart';

import '../../modules/shop_app/search/search_view.dart';
import '../../shared/components/components.dart';
import 'cubit/cubit.dart';

class ShopHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      builder: (BuildContext context, state) {
        var cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('Salla'),
            actions: [
              IconButton(
                onPressed: () {
                  NavigateTo(context, SearchScreen());
                },
                icon: Icon(
                  Icons.search,
                ),
              ),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
              cubit.changeNav(index);
            },
            currentIndex: cubit.currentIndex,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.category_outlined), label: 'Catogry'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite_border_rounded),
                  label: 'favorites'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings_rounded), label: 'settings'),
            ],
          ),
        );
      },
      listener: (BuildContext context, Object? state) {},
    );
  }
}
