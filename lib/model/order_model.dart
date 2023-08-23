class OrderModel {
  String itemId;
  String itemName;
  String? taste;
  int quantity;

  OrderModel(
      {required this.itemId,
      required this.itemName,
      this.taste = "",
      required this.quantity});
}
