class OrderModel {
  String itemId;
  String itemName;
  String? commonTaste;
  String? tasteByItem;
  int quantity;
  int incomdId;
  int? number;

  OrderModel(
      {required this.itemId,
      required this.itemName,
      this.commonTaste = "",
      this.tasteByItem = "",
      required this.quantity,
      required this.incomdId,
      this.number = 0});
}
