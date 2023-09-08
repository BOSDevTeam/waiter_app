class MenuModel {
  String? id;
  String? name;
  List<MenuModel> list = [];
  int? type;
  int? incomdId;
  int salePrice;
  int systemId;
  int counterId;
  int sType;
  int noDiscount;
  int itemDiscount;

  MenuModel(
      {this.id,
      this.name,
      required this.list,
      this.incomdId,
      this.salePrice = 0,
      this.systemId = 0,
      this.counterId = 0,
      this.sType = 0,
      this.noDiscount = 0,
      this.itemDiscount = 0,});
}
