class ChangeFavoritesModel{
  late final bool status;
  late final String message;

  ChangeFavoritesModel.fromjson(Map<String,dynamic>json)
  {
    status=json['status'];
    message=json['message'];
  }
}