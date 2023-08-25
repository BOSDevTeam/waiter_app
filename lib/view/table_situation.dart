import 'package:flutter/material.dart';
import 'package:waiter_app/model/table_situation_model.dart';
import 'package:waiter_app/widget/app_text.dart';
import 'package:dio/dio.dart';

import '../api/apiservice.dart';
import '../controller/data_downloading_controller.dart';
import '../controller/table_situation_controller.dart';
import '../hive/hive_db.dart';
import '../model/connector_model.dart';
import '../value/app_color.dart';
import '../value/app_string.dart';

class TableSituation extends StatefulWidget {
  const TableSituation({super.key});

  @override
  State<TableSituation> createState() => _TableSituationState();
}

class _TableSituationState extends State<TableSituation> {
  dynamic apiService;
  final tableSituationController = TableSituationController();
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

    tableSituationController.lstTableType = HiveDB.getTableType();
    if (tableSituationController.lstTableType.isNotEmpty) {
      tableSituationController.selectedTableType =
          tableSituationController.lstTableType[0];

      apiService
          .getTableSituation(dataDownloadingController.connectorModel,
              tableSituationController.selectedTableType["tableTypeId"])
          .then((lstTableSituation) {
            tableSituationController.lstTableSituation=lstTableSituation;
          });

      /* tableSituationController.lstTable = HiveDB.getTable();
      tableSituationController.lstTableByTableType = tableSituationController
          .lstTable
          .where((element) =>
              element["tableTypeId"] ==
              tableSituationController.selectedTableType["tableTypeId"])
          .toList(); */
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        AppString.tableSituation,
        style: TextStyle(color: AppColor.primary),
      )),
      body: Container(
        color: AppColor.grey,
        child: Column(
          children: [_tableType(), Expanded(child: _table())],
        ),
      ),
    );
  }

  Widget _table() {
    return GridView.count(
        shrinkWrap: true,
        crossAxisCount: 3,
        children: List.generate(
            tableSituationController.lstTableSituation.length, (index) {
          TableSituationModel table =
              tableSituationController.lstTableSituation[index];
          return Container(
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.all(5),
            height: 120,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: AppColor.primary300),
                borderRadius: BorderRadius.circular(5)),
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.person,
                        color: AppColor.primary500,
                      ),
                      AppText(
                        text: table.tableName,
                        fontWeight: FontWeight.bold,
                      )
                    ],
                  ),
                ),
                AppText(
                  text: "Empty".toUpperCase(),
                  color: AppColor.primary500,
                  size: 14,
                )
              ],
            ),
          );
        }));
  }

  Widget _tableType() {
    return SizedBox(
        height: 60,
        child: ListView.builder(
            //shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            //physics: const AlwaysScrollableScrollPhysics(),
            itemCount: tableSituationController.lstTableType.length,
            itemBuilder: (context, index) {
              Map<String, dynamic> tableType =
                  tableSituationController.lstTableType[index];
              return InkWell(
                splashColor: AppColor.primary300,
                onTap: () {},
                child: Container(
                    decoration: tableSituationController
                                .selectedTableType["tableTypeId"] !=
                            tableType["tableTypeId"]
                        ? BoxDecoration(
                            border: Border.all(color: AppColor.grey),
                            color: Colors.white)
                        : BoxDecoration(
                            border: Border.all(color: AppColor.grey),
                            color: AppColor.primaryDark),
                    width: 130,
                    alignment: Alignment.center,
                    child: tableSituationController
                                .selectedTableType["tableTypeId"] !=
                            tableType["tableTypeId"]
                        ? AppText(text: tableType["tableTypeName"])
                        : AppText(
                            text: tableType["tableTypeName"],
                            color: Colors.white,
                          )),
              );
            }));
  }
}
