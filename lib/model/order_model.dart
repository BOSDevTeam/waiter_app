class OrderModel {
  String itemId;
  String itemName;
  String commonTaste;
  String tasteByItem;
  int quantity;
  int incomdId;
  int number;
  int salePrice;
  int totalTastePrice;
  int systemId;
  int counterId;
  int sType;
  int noDiscount;
  int itemDiscount;

  OrderModel(
      {required this.itemId,
      required this.itemName,
      this.commonTaste = "",
      this.tasteByItem = "",
      required this.quantity,
      required this.incomdId,
      this.number = 0,
      required this.salePrice,
      this.totalTastePrice = 0,
      required this.systemId,
      required this.counterId,
      required this.sType,
      required this.noDiscount,
      required this.itemDiscount});
}
