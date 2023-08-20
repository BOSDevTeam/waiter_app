import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:waiter_app/model/connector_model.dart';
import 'package:waiter_app/model/waiter_model.dart';

import '../model/item_model.dart';
import '../model/main_menu_model.dart';
import '../model/sub_menu_model.dart';

part 'apiservice.g.dart';

@RestApi()
abstract class ApiService{
  factory ApiService({required Dio dio}) => _ApiService(dio);

  @GET("waiter")
  Future<List<WaiterModel>> getWaiter(@Body() ConnectorModel connectorModel);

  @GET("mainmenu")
  Future<List<MainMenuModel>> getMainMenu(@Body() ConnectorModel connectorModel);

  @GET("submenu")
  Future<List<SubMenuModel>> getSubMenu(@Body() ConnectorModel connectorModel);

  @GET("item")
  Future<List<ItemModel>> getItem(@Body() ConnectorModel connectorModel);

  @GET("systemitem")
  Future<List<ItemModel>> getSystemItem(@Body() ConnectorModel connectorModel);

}