class FavoritesScreenModel {
  late final bool status;
  String? message;
late final  Data data;



  FavoritesScreenModel.fromjson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = (json['data'] != null ? Data.fromjson(json['data']) : null)!;
  }


}

class Data {
  late final int currentPage;
 late final  List<FavoritesData> data;
  late final String firstPageUrl;
  late final int from;
 late final  int lastPage;
 late final  String lastPageUrl;
 late final  Null nextPageUrl;
 late final  String path;
 late final  int perPage;
 late final  Null prevPageUrl;
  late final int to;
  late final int total;



  Data.fromjson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <FavoritesData>[];
      json['data'].forEach((v) {
        data.add(FavoritesData.fromjson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }


}

class FavoritesData {
  late final int id;
  late final Product product;
  FavoritesData.fromjson(Map<String, dynamic> json) {
    id = json['id'];
    product =
        (json['product'] != null ? Product.fromjson(json['product']) : null)!;
  }


}

class Product {
  late final int id;
  late final dynamic price;
   late final dynamic oldPrice;
  late final int discount;
  late final String image;
  late final String name;
  late final String description;



  Product.fromjson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }


}
