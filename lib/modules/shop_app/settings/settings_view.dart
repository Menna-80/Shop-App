import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app_layout/cubit/cubit.dart';
import 'package:shop_app/layout/shop_app_layout/cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';



class SettingsScreen extends StatelessWidget {
  var formkey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = ShopCubit.get(context).userModel;
        emailController.text = model?.data?.email ?? '';
        nameController.text = model?.data?.name ?? '';
        phoneController.text = model?.data?.phone ?? '';
        return ConditionalBuilder(
          condition: ShopCubit.get(context).userModel != null,
          builder: (context) => Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Form(
                key: formkey,
                child: Column(
                  children: [
                    if (state is ShopLoadingupdateUserDataState)
                      LinearProgressIndicator(),
                    const SizedBox(
                      height: 25.0,
                    ),
                    defualtFormField(
                      controller: nameController,
                      type: TextInputType.text,
                      validate: (value) {
                        if (value?.isEmpty == true) {
                          return 'name must not be Empty';
                        }
                        return null;
                      },
                      label: 'Name',
                      prefix: Icons.person,
                    ),
                    const SizedBox(
                      height: 25.0,
                    ),
                    defualtFormField(
                      controller: emailController,
                      type: TextInputType.emailAddress,
                      validate: (value) {
                        if (value?.isEmpty == true) {
                          return 'email must not be Empty';
                        }
                        return null;
                      },
                      label: 'Email Address',
                      prefix: Icons.email,
                    ),
                    const SizedBox(
                      height: 25.0,
                    ),
                    defualtFormField(
                      controller: phoneController,
                      type: TextInputType.phone,
                      validate: (value) {
                        if (value?.isEmpty == true) {
                          return 'phone must not be Empty';
                        }
                        return null;
                      },
                      label: 'phone',
                      prefix: Icons.phone,
                    ),
                    const SizedBox(
                      height: 25.0,
                    ),
                    defualtButton(
                        function: () {
                          if (formkey.currentState?.validate() == true) {
                            ShopCubit.get(context).updateUserData(
                              name: nameController.text,
                              phone: phoneController.text,
                              email: emailController.text,
                            );
                          }
                        },
                        text: 'UPDATE'),
                    const SizedBox(
                      height: 25.0,
                    ),
                    defualtButton(
                        function: () {
                          signOut(context);
                        },
                        text: 'LOGOUT'),
                  ],
                ),
              ),
            ),
          ),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
