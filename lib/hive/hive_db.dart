import 'package:hive/hive.dart';

class HiveDB {
  static const String connectorBox = "connector_box";
  static const String baseUrlBox = "base_url_box";
  static const String waiterBox = "waiter_box";
  static const String mainMenuBox = "main_menu_box";
  static const String subMenuBox = "sub_menu_box";
  static const String itemBox = "item_box";
  static const String systemItemBox = "system_item_box";

  static Future<void> openAllBox() async {
    await Hive.openBox(connectorBox);
    await Hive.openBox(baseUrlBox);
    await Hive.openBox(waiterBox);
    await Hive.openBox(mainMenuBox);
    await Hive.openBox(subMenuBox);
    await Hive.openBox(itemBox);
    await Hive.openBox(systemItemBox);
  }

  static Future<void> insertConnectorBox(Map<String, dynamic> connector) async {
    await Hive.box(connectorBox).add(connector);
  }

  static Future<void> insertBaseUrl(Map<String, dynamic> baseUrl) async {
    await Hive.box(baseUrlBox).add(baseUrl);
  }

  static Future<void> insertWaiter(Map<String, dynamic> waiter) async {
    await Hive.box(waiterBox).add(waiter);
  }

  static Future<void> insertMainMenu(Map<String, dynamic> mainMenu) async {
    await Hive.box(mainMenuBox).add(mainMenu);
  }

  static Future<void> insertSubMenu(Map<String, dynamic> subMenu) async {
    await Hive.box(subMenuBox).add(subMenu);
  }

  static Future<void> insertItem(Map<String, dynamic> item) async {
    await Hive.box(itemBox).add(item);
  }

  static Future<void> insertSystemItem(Map<String, dynamic> systemItem) async {
    await Hive.box(systemItemBox).add(systemItem);
  }

  static List<Map<String, dynamic>> getConnector() {
    final data = Hive.box(connectorBox).keys.map((key) {
      final item = Hive.box(connectorBox).get(key);
      return {
        "key": key,
        "ipAddress": item["ipAddress"],
        "databaseName": item["databaseName"],
        "databaseLoginUser": item["databaseLoginUser"],
        "databaseLoginPassword": item["databaseLoginPassword"],
      };
    }).toList();
    return data;
  }

  static List<Map<String, dynamic>> getBaseUrl() {
    final data = Hive.box(baseUrlBox).keys.map((key) {
      final item = Hive.box(baseUrlBox).get(key);
      return {
        "key": key,
        "baseUrl": item["baseUrl"],
      };
    }).toList();
    return data;
  }

  static List<Map<String, dynamic>> getWaiter() {
    final data = Hive.box(waiterBox).keys.map((key) {
      final item = Hive.box(waiterBox).get(key);
      return {
        "key": key,
        "waiterId": item["waiterId"],
        "waiterName": item["waiterName"],
        "password": item["password"]
      };
    }).toList();
    return data;
  }

  static List<Map<String, dynamic>> getMainMenu() {
    final data = Hive.box(mainMenuBox).keys.map((key) {
      final item = Hive.box(mainMenuBox).get(key);
      return {
        "key": key,
        "mainMenuId": item["mainMenuId"],
        "mainMenuName": item["mainMenuName"],
        "counterId": item["counterId"]
      };
    }).toList();
    return data;
  }

  static List<Map<String, dynamic>> getSubMenu() {
    final data = Hive.box(subMenuBox).keys.map((key) {
      final item = Hive.box(subMenuBox).get(key);
      return {
        "key": key,
        "subMenuId": item["subMenuId"],
        "mainMenuId": item["mainMenuId"],
        "subMenuName": item["subMenuName"],
        "incomId": item["incomId"]
      };
    }).toList();
    return data;
  }

  static List<Map<String, dynamic>> getItem() {
    final data = Hive.box(itemBox).keys.map((key) {
      final item = Hive.box(itemBox).get(key);
      return {
        "key": key,
        "itemId": item["itemId"],
        "subMenuId": item["subMenuId"],
        "itemName": item["itemName"],
        "salePrice": item["salePrice"],
        "sType": item["sType"],
        "outOfOrder": item["outOfOrder"],
        "ingredients": item["ingredients"],
        "barcode": item["barcode"],
        "noDiscount": item["noDiscount"],
        "itemDiscount": item["itemDiscount"]
      };
    }).toList();
    return data;
  }

  static List<Map<String, dynamic>> getSystemItem() {
    final data = Hive.box(systemItemBox).keys.map((key) {
      final item = Hive.box(systemItemBox).get(key);
      return {
        "key": key,
        "systemId": item["systemId"],
        "itemId": item["itemId"]
      };
    }).toList();
    return data;
  }

  static void clearAllBox() {
    Hive.box(connectorBox).clear();
    Hive.box(baseUrlBox).clear();
    Hive.box(waiterBox).clear();
    Hive.box(mainMenuBox).clear();
    Hive.box(subMenuBox).clear();
    Hive.box(itemBox).clear();
    Hive.box(systemItemBox).clear();
  }
}
