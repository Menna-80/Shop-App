
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/shop_app_layout/cubit/cubit.dart';
import '../../../layout/shop_app_layout/cubit/states.dart';
import '../../../models/shop_app/catogry_model.dart';
import '../../../shared/components/components.dart';

class CatogryScreen extends StatelessWidget {
  const CatogryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
        builder: (context,state){
          return ListView.separated(
            physics: BouncingScrollPhysics(),
              itemBuilder: (context,index)=>BuildCategoryScreen(ShopCubit.get(context).categoryModel!.data.data[index]),
              separatorBuilder: (context,index)=>myDivider(),
              itemCount: ShopCubit.get(context).categoryModel!.data.data.length
          );
        },
        listener: (context,state){}
    );
  }
  Widget BuildCategoryScreen(DataModel data)=>Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Image(image: NetworkImage(data.image),
          width: 100,
          height: 100,
          fit: BoxFit.cover,
        ),
        SizedBox(height: 20.0,
          width: 15.0,
        ),
        Text(data.name,
            style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
        ),
        Spacer(),
        Icon(Icons.arrow_forward_ios_rounded),
      ],
    ),
  );
}
