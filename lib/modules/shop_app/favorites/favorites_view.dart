import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/shop_app_layout/cubit/cubit.dart';
import '../../../layout/shop_app_layout/cubit/states.dart';
import '../../../shared/components/components.dart';
import '../../../shared/styles/colors.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        builder: (context, state) {

          return ConditionalBuilder(
              condition: state is! ShopLoadingFavState,
              builder: (context) => ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) => favItem(
                        ShopCubit.get(context).favoritesModel!.data.data[index].product,
                        context),
                    separatorBuilder: (context, index) => myDivider(),
                    itemCount:
                        ShopCubit.get(context).favoritesModel!.data.data.length,
                  ),
              fallback: (context) =>
                  const Center(child: CircularProgressIndicator()));
        },
        listener: (context, state) {});
  }
}

Widget favItem( model, context) => Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        height: 120.0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
               Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Image(
                    image: NetworkImage(model.image),
                    width: 120,
                    height: 120,
                    fit: BoxFit.fill,
                  ),
                  if (model.discount != 0)
                    Container(
                      color: Colors.red,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5.0,
                      ),
                      child: const Text(
                        'Discount',
                        style: TextStyle(
                          fontSize: 10.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                ],
              ),
            const SizedBox(width: 20.0,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      height: 2,
                      fontSize: 12.0,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Text(
                        model.price.toString(),
                        style: const TextStyle(
                          fontSize: 12.0,
                          color: defaultcolor,
                        ),
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      if (model.discount != 0)
                        Text(
                          model.oldPrice.toString(),
                          style: const TextStyle(
                              fontSize: 10.0,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough),
                        ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          ShopCubit.get(context).changeFAV(model.id);
                        },
                        icon: Icon(
                          ShopCubit.get(context).fav[model.id] ?? false
                              ? Icons.favorite_rounded
                              : Icons.favorite_border_rounded,
                          color: ShopCubit.get(context).fav[model.id] ?? false
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
      ),
    );
