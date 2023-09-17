import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waiter_app/database/database_helper.dart';
import 'package:waiter_app/view/login.dart';

import '../api/apiservice.dart';
import '../controller/data_downloading_controller.dart';
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
    DatabaseHelper().getBaseUrl().then((value) {
      dataDownloadingController.lstBaseUrl = value;

      apiService = ApiService(
          dio: Dio(BaseOptions(
              baseUrl: dataDownloadingController.lstBaseUrl[0]["BaseUrl"])));

      DatabaseHelper().getConnector().then((value) {
        dataDownloadingController.lstConnector = value;
        dataDownloadingController.connectorModel = ConnectorModel(
            ipAddress: dataDownloadingController.lstConnector[0]["IPAddress"],
            databaseName: dataDownloadingController.lstConnector[0]
                ["DatabaseName"],
            databaseLoginUser: dataDownloadingController.lstConnector[0]
                ["DatabaseLoginUser"],
            databaseLoginPassword: dataDownloadingController.lstConnector[0]
                ["DatabaseLoginPassword"]);

        apiService
            .getWaiter(dataDownloadingController.connectorModel)
            .then((lstWaiter) {
          DatabaseHelper().insertWaiter(lstWaiter).then((value) {
            if (lstWaiter.length == value) {
              setState(() {
                dataDownloadingController.isWaiterComplete = true;
              });
            }
          });
        });

        apiService
            .getMainMenu(dataDownloadingController.connectorModel)
            .then((lstMainMenu) {
          DatabaseHelper().insertMainMenu(lstMainMenu).then((value) {
            if (lstMainMenu.length == value) {
              setState(() {
                dataDownloadingController.isMainMenuComplete = true;
              });
            }
          });
        });

        apiService
            .getSubMenu(dataDownloadingController.connectorModel)
            .then((lstSubMenu) {
          DatabaseHelper().insertSubMenu(lstSubMenu).then((value) {
            if (lstSubMenu.length == value) {
              setState(() {
                dataDownloadingController.isSubMenuComplete = true;
              });
            }
          });
        });

        apiService
            .getItem(dataDownloadingController.connectorModel)
            .then((lstItem) {
          DatabaseHelper().insertItem(lstItem).then((value) {
            if (lstItem.length == value) {
              setState(() {
                dataDownloadingController.isItemComplete = true;
              });
            }
          });
        });

        apiService
            .getSystemItem(dataDownloadingController.connectorModel)
            .then((lstSystemItem) {
          DatabaseHelper().insertSystemItem(lstSystemItem).then((value) {
            if (lstSystemItem.length == value) {
              setState(() {
                dataDownloadingController.isSystemItemComplete = true;
              });
            }
          });
        });

        apiService
            .getTableType(dataDownloadingController.connectorModel)
            .then((lstTableType) {
          DatabaseHelper().insertTableType(lstTableType).then((value) {
            if (lstTableType.length == value) {
              setState(() {
                dataDownloadingController.isTableTypeComplete = true;
              });
            }
          });
        });

        apiService
            .getTable(dataDownloadingController.connectorModel)
            .then((lstTable) {
          DatabaseHelper().insertTable(lstTable).then((value) {
            if (lstTable.length == value) {
              setState(() {
                dataDownloadingController.isTableComplete = true;
              });
            }
          });
        });

        apiService
            .getTaste(dataDownloadingController.connectorModel)
            .then((lstTaste) {
          DatabaseHelper().insertTaste(lstTaste).then((value) {
            if (lstTaste.length == value) {
              setState(() {
                dataDownloadingController.isTasteComplete = true;
              });
            }
          });
        });

        apiService
            .getTasteMulti(dataDownloadingController.connectorModel)
            .then((lstTasteMulti) {
          DatabaseHelper().insertTasteMulti(lstTasteMulti).then((value) {
            if (lstTasteMulti.length == value) {
              setState(() {
                dataDownloadingController.isTasteMultiComplete = true;
              });
            }
          });
        });

        apiService
            .getSystemSetting(dataDownloadingController.connectorModel)
            .then((lstSystemSetting) {
          if (lstSystemSetting.length != 0) {
            DatabaseHelper().insertSystemSetting({
              "tax": lstSystemSetting[0].tax,
              "service": lstSystemSetting[0].service,
              "adminPassword": lstSystemSetting[0].adminPassword,
              "title": lstSystemSetting[0].title,
              "userPassword": lstSystemSetting[0].userPassword
            }).then((value) {
              if (value == 1) {
                setState(() {
                  dataDownloadingController.isSystemSettingComplete = true;
                });
              }
            });
          }
        });
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
        body: dataDownloadingController.isWaiterComplete &&
                dataDownloadingController.isMainMenuComplete &&
                dataDownloadingController.isSubMenuComplete &&
                dataDownloadingController.isItemComplete &&
                dataDownloadingController.isSystemItemComplete &&
                dataDownloadingController.isTableTypeComplete &&
                dataDownloadingController.isTableComplete &&
                dataDownloadingController.isTasteComplete &&
                dataDownloadingController.isTasteMultiComplete &&
                dataDownloadingController.isSystemSettingComplete
            ? Center(
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
                            padding: const EdgeInsets.only(
                          top: 20, bottom: 20, right: 30, left: 30),
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.zero))),
                        child: const Text(AppString.sContinue)),
                  ],
                ),
              )
            : const Center(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(AppString.downloading),
                  SizedBox(
                    height: 30,
                  ),
                  CircularProgressIndicator()
                ],
              )));
  }
}
