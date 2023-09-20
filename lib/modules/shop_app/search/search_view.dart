
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../shared/components/components.dart';
import '../favorites/favorites_view.dart';
import 'cubit/searchcubit.dart';
import 'cubit/searchstate.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formkey = GlobalKey<FormState>();
    var searchControler = TextEditingController();
    
    return BlocProvider(
        create: (BuildContext context)=>ShopSearchCubit(),
      child: BlocConsumer<ShopSearchCubit, SearchStates>(
        listener: ( context, state) {},
        builder: ( context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formkey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: defualtFormField(
                      controller: searchControler,
                      type: TextInputType.text,
                      onChange: (value) {
                        ShopSearchCubit.get(context).Search(value);
                      },
                      validate: (String? value) {
                        if (value?.isEmpty==true) {
                          return 'you must write ';
                        }
                        return null;
                      },
                      label: 'search',
                      prefix: Icons.search_rounded,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  if(state is ShopSearchLoadingState)
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: LinearProgressIndicator(),
                    ),
                  SizedBox(
                    height: 10,
                  ),
                  if(state is ShopSearchSuccessState)
                    Expanded(
                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) => favItem(
                            ShopSearchCubit.get(context).model!.data.data[index],
                            context),
                        separatorBuilder: (context, index) => myDivider(),
                        itemCount:
                        ShopSearchCubit.get(context).model!.data.data.length,
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
