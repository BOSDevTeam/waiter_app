class MenuModel {
  String? id;
  String? name;
  List<MenuModel> list = [];
  int? type;
  int? incomdId;

  MenuModel({this.id, this.name, required this.list, this.incomdId});
}
