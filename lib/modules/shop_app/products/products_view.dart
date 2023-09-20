
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/shop_app_layout/cubit/cubit.dart';
import '../../../layout/shop_app_layout/cubit/states.dart';
import '../../../models/shop_app/catogry_model.dart';
import '../../../models/shop_app/home_model.dart';
import '../../../shared/components/components.dart';
import '../../../shared/styles/colors.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        builder: (context, state) {
          return ConditionalBuilder(
            condition: ShopCubit.get(context).homeModel != null && ShopCubit.get(context).categoryModel != null ,
            builder: (context) =>
                ProductBuilder(ShopCubit.get(context).homeModel,ShopCubit.get(context).categoryModel,context ),
            fallback: (context) => Center(child: CircularProgressIndicator()),
          );
        },
        listener: (context, state) {
          if(state is ShopFAVSuccessState)
            {
              if(!state.model.status)
                ShowToast(text: state.model.message, state: ToastStates.error);
            }

        });
  }

  Widget ProductBuilder(HomeModel? model, CategoryModel? categoryModel,context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
            items: model?.data.banners
                .map(
                  (e) => Image(
                    image: NetworkImage(e.image),
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                )
                .toList(),
            options: CarouselOptions(
              height: 250.0,
              viewportFraction: 1.0,
              autoPlay: true,
              scrollDirection: Axis.horizontal,
              autoPlayAnimationDuration: Duration(seconds: 1),
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Categories',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Container(
                  height: 140,

                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => BuildCategory(categoryModel!.data.data[index]),
                      separatorBuilder: (context, index) => SizedBox(
                            width: 10.0,
                          ),
                      itemCount: categoryModel!.data.data.length,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  'New Products',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Container(
            color: Colors.grey[300],
            child: GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              mainAxisSpacing: 6.0,
              crossAxisSpacing: 6.0,
              childAspectRatio: 1 / 1.45,
              crossAxisCount: 2,
              children: List.generate(model!.data.products.length,
                  (index) => BuildGridProduct(model.data.products[index],context)),
            ),
          ),
        ],
      ),
    );
  }

  Widget BuildCategory(DataModel data) => Container(
    height: 120.0,
     width: 120.0,
     decoration: BoxDecoration(
       borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 8.0,
              blurStyle: BlurStyle.outer
            ),
          ],
        ),
        child: Column(
          children: [
            Image(
              image: NetworkImage(
                 data.image
              ),
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
            Text(
             data.name,
              maxLines: 2,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      );

  Widget BuildGridProduct(ProductModel model,context) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 10.0,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image(
                    image: NetworkImage(model.image),
                    width: double.infinity,
                    height: 155,
                  ),
                  if (model.discount != 0)
                    Container(
                      color: Colors.red,
                      padding: EdgeInsets.symmetric(
                        horizontal: 5.0,
                      ),
                      child: Text(
                        'Discount',
                        style: TextStyle(
                          fontSize: 10.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      height: 2,
                      fontSize: 12.0,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        '${model.price}',
                        style: TextStyle(
                          fontSize: 12.0,
                          color: defaultcolor,
                        ),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      if (model.discount != 0)
                        Text(
                          '${model.old_price}',
                          style: TextStyle(
                              fontSize: 10.0,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough),
                        ),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                           ShopCubit.get(context).changeFAV(model.id) ;
                           print(model.id);
                        },
                        icon: Icon(
                       ShopCubit.get(context).fav[model.id]??false ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                          color:  ShopCubit.get(context).fav[model.id] ?? false
                              ? Colors.redAccent
                              :Colors.grey ,
                          size: 30.0,

                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
