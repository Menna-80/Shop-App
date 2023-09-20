

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/shop_app/search/cubit/searchstate.dart';

import '../../../../models/shop_app/Search_model.dart';
import '../../../../shared/components/constants.dart';
import '../../../../shared/network/end_points.dart';
import '../../../../shared/network/remote/dio_helper.dart';

class ShopSearchCubit extends Cubit<SearchStates> {
  ShopSearchCubit() : super(InitialState());
  static ShopSearchCubit get(context) => BlocProvider.of(context);
  SearchModel? model;

  void Search(String? text) {
    emit(ShopSearchLoadingState());
    DioHelper.postData(url: search, token: token, data: {
      'text': text,
    }).then((value) {
      model = SearchModel.fromjson(value?.data);
      emit(ShopSearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopSearchErrorState());
    });
  }
}
