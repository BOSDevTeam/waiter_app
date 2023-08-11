import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:waiter_app/model/connector_model.dart';
import 'package:waiter_app/model/waiter_model.dart';

part 'apiservice.g.dart';

@RestApi()
abstract class ApiService{
  factory ApiService({required Dio dio}) => _ApiService(dio);

  @GET("waiter")
  Future<List<WaiterModel>> getWaiter(ConnectorModel connectorModel);

}