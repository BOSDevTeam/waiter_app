import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:waiter_app/database/database_helper.dart';
import 'package:waiter_app/view/login.dart';

import '../api/apiservice.dart';
import '../model/connector_model.dart';
import '../provider/data_updating_provider.dart';
import '../value/app_color.dart';
import '../value/app_string.dart';

class DataDownloading extends StatefulWidget {
  const DataDownloading({super.key});

  @override
  State<DataDownloading> createState() => _DataDownloadingState();
}

class _DataDownloadingState extends State<DataDownloading> {
  @override
  void initState() {
    DatabaseHelper().getBaseUrl().then((value) {
      ApiService apiService =
          ApiService(dio: Dio(BaseOptions(baseUrl: value[0]["BaseUrl"])));

      DatabaseHelper().getConnector().then((value) {
        var connectorModel = ConnectorModel(
            ipAddress: value[0]["IPAddress"],
            databaseName: value[0]["DatabaseName"],
            databaseLoginUser: value[0]["DatabaseLoginUser"],
            databaseLoginPassword: value[0]["DatabaseLoginPassword"]);

        apiService.getWaiter(connectorModel).then((lstWaiter) {
          DatabaseHelper().insertWaiter(lstWaiter).then((value) {
            if (lstWaiter.length == value) {
              context.read<DataUpdatingProvider>().setIsWaiterComplete(true);
            }
          });
        });

        apiService.getMainMenu(connectorModel).then((lstMainMenu) {
          DatabaseHelper().insertMainMenu(lstMainMenu).then((value) {
            if (lstMainMenu.length == value) {
              context.read<DataUpdatingProvider>().setIsMainMenuComplete(true);
            }
          });
        });

        apiService.getSubMenu(connectorModel).then((lstSubMenu) {
          DatabaseHelper().insertSubMenu(lstSubMenu).then((value) {
            if (lstSubMenu.length == value) {
              context.read<DataUpdatingProvider>().setIsSubMenuComplete(true);
            }
          });
        });

        apiService.getItem(connectorModel).then((lstItem) {
          DatabaseHelper().insertItem(lstItem).then((value) {
            if (lstItem.length == value) {
              context.read<DataUpdatingProvider>().setIsItemComplete(true);
            }
          });
        });

        apiService.getSystemItem(connectorModel).then((lstSystemItem) {
          DatabaseHelper().insertSystemItem(lstSystemItem).then((value) {
            if (lstSystemItem.length == value) {
              context
                  .read<DataUpdatingProvider>()
                  .setIsSystemItemComplete(true);
            }
          });
        });

        apiService.getTableType(connectorModel).then((lstTableType) {
          DatabaseHelper().insertTableType(lstTableType).then((value) {
            if (lstTableType.length == value) {
              context.read<DataUpdatingProvider>().setIsTableTypeComplete(true);
            }
          });
        });

        apiService.getTable(connectorModel).then((lstTable) {
          DatabaseHelper().insertTable(lstTable).then((value) {
            if (lstTable.length == value) {
              context.read<DataUpdatingProvider>().setIsTableComplete(true);
            }
          });
        });

        apiService.getTaste(connectorModel).then((lstTaste) {
          DatabaseHelper().insertTaste(lstTaste).then((value) {
            if (lstTaste.length == value) {
              context.read<DataUpdatingProvider>().setIsTasteComplete(true);
            }
          });
        });

        apiService.getTasteMulti(connectorModel).then((lstTasteMulti) {
          DatabaseHelper().insertTasteMulti(lstTasteMulti).then((value) {
            if (lstTasteMulti.length == value) {
              context
                  .read<DataUpdatingProvider>()
                  .setIsTasteMultiComplete(true);
            }
          });
        });

        apiService.getSystemSetting(connectorModel).then((lstSystemSetting) {
          if (lstSystemSetting.isNotEmpty) {
            DatabaseHelper().insertSystemSetting({
              "tax": lstSystemSetting[0].tax,
              "service": lstSystemSetting[0].service,
              "adminPassword": lstSystemSetting[0].adminPassword,
              "title": lstSystemSetting[0].title,
              "userPassword": lstSystemSetting[0].userPassword
            }).then((value) {
              if (value == 1) {
                context
                    .read<DataUpdatingProvider>()
                    .setIsSystemSettingComplete(true);
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
      body: Consumer<DataUpdatingProvider>(builder: (context, provider, child) {
        return provider.isWaiterComplete &&
                provider.isMainMenuComplete &&
                provider.isSubMenuComplete &&
                provider.isItemComplete &&
                provider.isSystemItemComplete &&
                provider.isTableTypeComplete &&
                provider.isTableComplete &&
                provider.isTasteComplete &&
                provider.isTasteMultiComplete &&
                provider.isSystemSettingComplete
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
              ));
      }),
    );
  }
}
