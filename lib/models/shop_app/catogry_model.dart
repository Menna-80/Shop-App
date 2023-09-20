class CategoryModel {
  late final bool status;
  late final CategoryDataModel data;
  CategoryModel.fromjson(Map<String, dynamic> json) {
    status = json['status'];
    data = CategoryDataModel.fromjson(json['data']);
  }
}

class CategoryDataModel {
  late final int current_page;
  List<DataModel> data = [];
  CategoryDataModel.fromjson(Map<String, dynamic> json) {
    current_page = json['current_page'];
    json['data'].forEach((element) {
      data.add(DataModel.fromjson(element));
    });
  }
}

class DataModel {
  late final int id;
  late final String name;
  late final String image;
  DataModel.fromjson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}
