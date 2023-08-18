import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waiter_app/view/login.dart';

import '../api/apiservice.dart';
import '../model/connector_model.dart';
import '../value/app_color.dart';
import '../value/app_constant.dart';
import '../value/app_string.dart';

class DataDownloading extends StatefulWidget {
  const DataDownloading({super.key});

  @override
  State<DataDownloading> createState() => _DataDownloadingState();
}

class _DataDownloadingState extends State<DataDownloading> {
  /* var apiService =
      ApiService(dio: Dio(BaseOptions(baseUrl: AppConstant.baseUrl))); */
  final _waiterBox = Hive.box(AppConstant.waiterBox);
  final _baseUrlBox = Hive.box(AppConstant.baseUrlBox);
  final _connectorBox = Hive.box(AppConstant.connectorBox);
  bool _isDownloadComplete = false;
  String _currentDownloadData = "";
  dynamic apiService;
  List<Map<String, dynamic>> lstBaseUrl = [];
  List<Map<String, dynamic>> lstConnector = [];
  dynamic connectorModel;

  @override
  void initState() {
    lstBaseUrl = _getBaseUrl();
    apiService =
        ApiService(dio: Dio(BaseOptions(baseUrl: lstBaseUrl[0]["baseUrl"])));
    lstConnector = _getConnector();
    connectorModel = ConnectorModel(
        ipAddress: lstConnector[0]["ipAddress"],
        databaseName: lstConnector[0]["databaseName"],
        databaseLoginUser: lstConnector[0]["databaseLoginUser"],
        databaseLoginPassword: lstConnector[0]["databaseLoginPassword"]);
    setState(() {
      _currentDownloadData = AppString.waiter;
    });
    apiService.getWaiter(connectorModel).then((lstWaiter) {
      for (int i = 0; i < lstWaiter.length; i++) {
        _insertWaiter({
          "waiterId": lstWaiter[i].waiterId,
          "waiterName": lstWaiter[i].waiterName,
          "password": lstWaiter[i].password
        });
      }
      setState(() {
        _isDownloadComplete = true;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text(
          AppString.download,
          style: TextStyle(color: AppColor.primary),
        )),
        body: !_isDownloadComplete
            ? Center(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("${AppString.downloading} $_currentDownloadData"),
                  const SizedBox(
                    height: 30,
                  ),
                  const CircularProgressIndicator()
                ],
              ))
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(AppString.downloadCompleted),
                    const SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          SharedPreferences sharedPreferences =
                              await SharedPreferences.getInstance();
                          sharedPreferences.setBool("IsRegisterSuccess", true);
                          Navigator.pushAndRemoveUntil(context,
                              MaterialPageRoute(builder: (context) {
                            return const Login();
                          }), (route) => false);
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.primary500,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.all(20),
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.zero))),
                        child: const Text(AppString.sContinue)),
                  ],
                ),
              ));
  }

  Future<void> _insertWaiter(Map<String, dynamic> waiter) async {
    await _waiterBox.add(waiter);
  }

  List<Map<String, dynamic>> _getBaseUrl() {
    final data = _baseUrlBox.keys.map((key) {
      final item = _baseUrlBox.get(key);
      return {
        "key": key,
        "baseUrl": item["baseUrl"],
      };
    }).toList();
    return data;
  }

  List<Map<String, dynamic>> _getConnector() {
    final data = _connectorBox.keys.map((key) {
      final item = _connectorBox.get(key);
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
}
