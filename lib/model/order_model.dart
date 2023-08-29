class OrderModel {
  String itemId;
  String itemName;
  String? commonTaste;
  String? tasteByItem;
  int quantity;

  OrderModel(
      {required this.itemId,
      required this.itemName,
      this.commonTaste = "",
      this.tasteByItem = "",
      required this.quantity});
}
