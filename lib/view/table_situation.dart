import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waiter_app/model/table_situation_model.dart';
import 'package:waiter_app/widget/app_text.dart';
import 'package:dio/dio.dart';

import '../api/apiservice.dart';
import '../controller/data_downloading_controller.dart';
import '../controller/order_provider.dart';
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
  Offset _tapPosition = Offset.zero;

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
          children: [
            _tableType(),
            FutureBuilder<List<TableSituationModel>>(
                future: apiService.getTableSituation(
                    dataDownloadingController.connectorModel,
                    tableSituationController.selectedTableType["tableTypeId"]),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    tableSituationController.lstTableSituation = snapshot.data!;
                    return Expanded(child: _table());
                  } else if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }
                  return const Center(child: CircularProgressIndicator());
                })
          ],
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
                color: table.isOccupied ? Colors.transparent : Colors.white,
                border: Border.all(color: AppColor.primary300),
                borderRadius: BorderRadius.circular(5)),
            child: Material(
              color: table.isOccupied ? AppColor.grey : Colors.white,
              child: InkWell(
                splashColor: AppColor.primary300,
                onTapDown: (details) => _getTapPosition(details),
                onTap: () {
                  if (!table.isOccupied) {
                    context.read<OrderProvider>().setSelectedTable({
                      "tableId": table.tableId,
                      "tableName": table.tableName
                    });
                    Navigator.pop(context);
                  }
                },
                onLongPress: () {
                  if (table.isOccupied) {
                    _showContextMenu(context);
                  }
                },
                child: Column(
                  children: [
                    SizedBox(
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          table.isOccupied
                              ? const Icon(
                                  Icons.person,
                                  color: AppColor.primary500,
                                )
                              : Container(),
                          Flexible(
                            child: AppText(
                              text: table.tableName,
                              fontWeight: FontWeight.bold,
                              fontFamily: "BOS",
                            ),
                          )
                        ],
                      ),
                    ),
                    table.isOccupied
                        ? AppText(
                            text: "People".toUpperCase(),
                            color: AppColor.primary500,
                            size: 14,
                          )
                        : AppText(
                            text: "Empty".toUpperCase(),
                            color: AppColor.primary500,
                            size: 14,
                          )
                  ],
                ),
              ),
            ),
          );
        }));
  }

  Widget _tableType() {
    return SizedBox(
        height: 60,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: tableSituationController.lstTableType.length,
            itemBuilder: (context, index) {
              Map<String, dynamic> tableType =
                  tableSituationController.lstTableType[index];
              return Container(
                decoration:
                    tableSituationController.selectedTableType["tableTypeId"] !=
                            tableType["tableTypeId"]
                        ? BoxDecoration(
                            border: Border.all(color: AppColor.grey),
                            color: Colors.white)
                        : BoxDecoration(
                            border: Border.all(color: AppColor.grey),
                            color: AppColor.primaryDark),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    splashColor: AppColor.primary300,
                    onTap: () {
                      tableSituationController.selectedTableType =
                          tableSituationController.lstTableType[index];
                      apiService
                          .getTableSituation(
                              dataDownloadingController.connectorModel,
                              tableSituationController
                                  .selectedTableType["tableTypeId"])
                          .then((lstTableSituation) {
                        tableSituationController.lstTableSituation =
                            lstTableSituation;
                        setState(() {
                          _table();
                        });
                      });
                    },
                    child: Container(
                        width: 130,
                        height: 60,
                        alignment: Alignment.center,
                        child: tableSituationController
                                    .selectedTableType["tableTypeId"] !=
                                tableType["tableTypeId"]
                            ? AppText(text: tableType["tableTypeName"],fontFamily: "BOS",)
                            : AppText(
                                text: tableType["tableTypeName"],
                                color: Colors.white,
                                fontFamily: "BOS"
                              )),
                  ),
                ),
              );
            }));
  }

  void _getTapPosition(TapDownDetails details) {
    final RenderBox referenceBox = context.findRenderObject() as RenderBox;
    setState(() {
      _tapPosition = referenceBox.globalToLocal(details.globalPosition);
    });
  }

  void _showContextMenu(BuildContext context) async {
    final RenderObject? overlay =
        Overlay.of(context).context.findRenderObject();

    final result = await showMenu(
        context: context,

        // Show the context menu at the tap location
        position: RelativeRect.fromRect(
            Rect.fromLTWH(_tapPosition.dx, _tapPosition.dy, 30, 30),
            Rect.fromLTWH(0, 0, overlay!.paintBounds.size.width,
                overlay.paintBounds.size.height)),

        // set a list of choices for the context menu
        items: [
          const PopupMenuItem(
            value: AppString.viewOrder,
            child: Text(AppString.viewOrder),
          ),
          const PopupMenuItem(
            value: AppString.getBill,
            child: Text(AppString.getBill),
          ),
        ]);

    // Implement the logic for each choice here
    switch (result) {
      case AppString.viewOrder:
        debugPrint('view order');
        break;
      case AppString.getBill:
        debugPrint('get bill');
        break;
    }
  }
}
