class MenuModel {
  String? id;
  String? name;
  List<MenuModel> list = [];
  int? type;
  int? incomdId;
  int salePrice;

  MenuModel(
      {this.id,
      this.name,
      required this.list,
      this.incomdId,
      this.salePrice = 0});
}
