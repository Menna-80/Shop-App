class HomeModel{
 late bool status;
 late HomeDataModel data;
 HomeModel.fromjson(Map<String,dynamic>json){
   status=json['status'];
   data = HomeDataModel.fromjson(json['data']);

 }
}
class HomeDataModel{
 List<BannersModel> banners=[];
 List<ProductModel> products=[];
  HomeDataModel.fromjson(Map<String,dynamic>json){
    json['banners'].forEach((element){
      banners.add(BannersModel.fromjson(element));
    });
    json['products'].forEach((element){
      products.add(ProductModel.fromjson(element));
    });

  }
}
class BannersModel{
 late int id;
late String image;
BannersModel.fromjson(Map<String,dynamic>json){
  id=json['id'];
  image=json['image'];

  }
}
class ProductModel{
 late int id;
  dynamic price;
  dynamic old_price;
  dynamic discount;
 late final String image;
 late final String name;
 late final bool in_favorite;
late final  bool in_cart;

ProductModel.fromjson(Map<String,dynamic>json){
  id=json['id'];
  price=json['price'];
  old_price=json['old_price'];
  discount=json['discount'];
  image=json['image'];
  name=json['name'];
  in_favorite=json['in_favorites'];
  in_cart=json['in_cart'];

  }
}