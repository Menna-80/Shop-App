class cartModel {
  late final bool status;
  String? message;
  late final Data data;

  cartModel.fromjson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = (json['data'] != null ? Data.fromjson(json['data']) : null)!;
  }
}

class Data {
  late final int sub_total;
  late final List<cartItems> data;
  late final int total;

  Data.fromjson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <cartItems>[];
      json['data'].forEach((v) {
        data.add(cartItems.fromJson(v));
      });
    }
    sub_total = json['sub_total'];
    total = json['total'];
  }
}

class cartItems {
  late final int id;
  late final Product product;
  late final int quantity;

  cartItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    quantity = json['quantity'];
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
