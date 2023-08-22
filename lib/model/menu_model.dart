class MenuModel{
  String? id;
  String? name;
  List<MenuModel> list = [];
  int? type;

  MenuModel({this.id,this.name,required this.list});
}