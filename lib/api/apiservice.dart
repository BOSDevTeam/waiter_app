import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:waiter_app/model/connector_model.dart';
import 'package:waiter_app/model/table_situation_model.dart';
import 'package:waiter_app/model/table_type_model.dart';
import 'package:waiter_app/model/waiter_model.dart';

import '../model/item_model.dart';
import '../model/main_menu_model.dart';
import '../model/order_master_model.dart';
import '../model/order_model.dart';
import '../model/sub_menu_model.dart';
import '../model/system_item_model.dart';
import '../model/system_setting_model.dart';
import '../model/table_model.dart';
import '../model/taste_model.dart';
import '../model/taste_multi_model.dart';

part 'apiservice.g.dart';

@RestApi()
abstract class ApiService {
  factory ApiService({required Dio dio}) => _ApiService(dio);

  @GET("waiter")
  Future<List<WaiterModel>> getWaiter(@Body() ConnectorModel connectorModel);

  @GET("mainmenu")
  Future<List<MainMenuModel>> getMainMenu(
      @Body() ConnectorModel connectorModel);

  @GET("submenu")
  Future<List<SubMenuModel>> getSubMenu(@Body() ConnectorModel connectorModel);

  @GET("item")
  Future<List<ItemModel>> getItem(@Body() ConnectorModel connectorModel);

  @GET("systemitem")
  Future<List<SystemItemModel>> getSystemItem(
      @Body() ConnectorModel connectorModel);

  @GET("tabletype")
  Future<List<TableTypeModel>> getTableType(
      @Body() ConnectorModel connectorModel);

  @GET("table")
  Future<List<TableModel>> getTable(@Body() ConnectorModel connectorModel);

  @GET("taste")
  Future<List<TasteModel>> getTaste(@Body() ConnectorModel connectorModel);

  @GET("tastemulti")
  Future<List<TasteMultiModel>> getTasteMulti(
      @Body() ConnectorModel connectorModel);

  @GET("systemsetting")
  Future<List<SystemSettingModel>> getSystemSetting(
      @Body() ConnectorModel connectorModel);

  @GET("tablesituation")
  Future<List<TableSituationModel>> getTableSituation(
      @Body() ConnectorModel connectorModel,
      @Query("tableTypeId") int tableTypeId);

  @POST("order")
  Future<void> sendOrder(
      @Body() ConnectorModel connectorModel,
      @Body() OrderMasterModel orderMasterModel,
      @Body() List<OrderModel> lstOrder);
}
