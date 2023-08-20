import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waiter_app/view/login.dart';

import '../api/apiservice.dart';
import '../controller/data_downloading_controller.dart';
import '../hive/hive_db.dart';
import '../model/connector_model.dart';
import '../value/app_color.dart';
import '../value/app_string.dart';

class DataDownloading extends StatefulWidget {
  const DataDownloading({super.key});

  @override
  State<DataDownloading> createState() => _DataDownloadingState();
}

class _DataDownloadingState extends State<DataDownloading> {
  dynamic apiService;
  final dataDownloadingController = DataDownloadingController();

  @override
  void initState() {
    dataDownloadingController.lstBaseUrl = HiveDB.getBaseUrl();
    apiService = ApiService(
        dio: Dio(BaseOptions(
            baseUrl: dataDownloadingController.lstBaseUrl[0]["baseUrl"])));
    dataDownloadingController.lstConnector = HiveDB.getConnector();
    dataDownloadingController.connectorModel = ConnectorModel(
        ipAddress: dataDownloadingController.lstConnector[0]["ipAddress"],
        databaseName: dataDownloadingController.lstConnector[0]["databaseName"],
        databaseLoginUser: dataDownloadingController.lstConnector[0]
            ["databaseLoginUser"],
        databaseLoginPassword: dataDownloadingController.lstConnector[0]
            ["databaseLoginPassword"]);
    setState(() {
      dataDownloadingController.currentDownloadData = AppString.waiter;
    });
    apiService
        .getWaiter(dataDownloadingController.connectorModel)
        .then((lstWaiter) {
      for (int i = 0; i < lstWaiter.length; i++) {
        HiveDB.insertWaiter({
          "waiterId": lstWaiter[i].waiterId,
          "waiterName": lstWaiter[i].waiterName,
          "password": lstWaiter[i].password
        });
      }

      /* setState(() {
        dataDownloadingController.currentDownloadData = AppString.mainMenu;
      });

      setState(() {
        dataDownloadingController.isDownloadComplete = true;
      }); */
    });

    apiService.getMainMenu(dataDownloadingController.connectorModel).then((lstMainMenu){

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
        body: !dataDownloadingController.isDownloadComplete
            ? Center(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                      "${AppString.downloading} $dataDownloadingController.currentDownloadData"),
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

                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) {
                            return const Login();
                          }));
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
}
