import 'package:flutter/material.dart';
import 'package:waiter_app/api/apiservice.dart';
import 'package:dio/dio.dart';
import 'package:waiter_app/model/connector_model.dart';
import 'package:waiter_app/model/waiter_model.dart';

class Login extends StatefulWidget {
  final ConnectorModel connectorModel;
  const Login({super.key, required this.connectorModel});

  @override
  State<Login> createState() => _LoginState(connectorModel);
}

class _LoginState extends State<Login> {
  ConnectorModel connectorModel;
  late String baseUrl;
  List<WaiterModel> lstWaiter = [];
  late String ipAddress;
  //dynamic apiService;

  _LoginState(this.connectorModel);

  @override
  void initState() {
    ipAddress=connectorModel.ipAddress;
    baseUrl = "http://$ipAddress/WaiterWebService/api/";
    //apiService = ApiService(dio: Dio(BaseOptions(baseUrl: baseUrl)));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<List<WaiterModel>>(
      future: ApiService(dio: Dio(BaseOptions(baseUrl: baseUrl))).getWaiter(connectorModel),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          lstWaiter=snapshot.data!;
          return ListView.builder(
              itemCount: lstWaiter.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(lstWaiter[index].waiterName),
                );
              });
        } else if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        }
        return CircularProgressIndicator();
      },
    ));
  }

  Widget _waiter() {
    return ListView.builder(
        itemCount: lstWaiter.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(lstWaiter[index].waiterName),
          );
        });
  }
}
