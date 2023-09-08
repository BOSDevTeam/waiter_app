import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:waiter_app/model/table_situation_model.dart';
import 'package:waiter_app/widget/app_text.dart';
import 'package:dio/dio.dart';

import '../api/apiservice.dart';
import '../controller/data_downloading_controller.dart';
import '../database/database_helper.dart';
import '../nav_drawer.dart';
import '../provider/order_provider.dart';
import '../provider/table_situation_provider.dart';
import '../model/connector_model.dart';
import '../value/app_color.dart';
import '../value/app_string.dart';

class TableSituation extends StatefulWidget {
  final bool isFromNav;
  const TableSituation({super.key, required this.isFromNav});

  @override
  State<TableSituation> createState() => _TableSituationState(isFromNav);
}

class _TableSituationState extends State<TableSituation> {
  dynamic apiService;
  final dataDownloadingController = DataDownloadingController();
  Offset _tapPosition = Offset.zero;
  bool isFromNav;

  _TableSituationState(this.isFromNav);

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

        DatabaseHelper().getTableType().then((value) {
          if (value.isNotEmpty) {
            context.read<TableSituationProvider>().setTableType(value);
            context
                .read<TableSituationProvider>()
                .setSelectedTableType(value[0]);

            EasyLoading.show();
            apiService
                .getTableSituation(dataDownloadingController.connectorModel,
                    value[0]["TableTypeID"])
                .then((lstTableSituation) {
              EasyLoading.dismiss();
              context
                  .read<TableSituationProvider>()
                  .setTableSituation(lstTableSituation);
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
      drawer: isFromNav ? const NavDrawer() : null,
      appBar: isFromNav
          ? AppBar(
              title: const Text(AppString.table,
                  style: TextStyle(color: AppColor.primary)),
              iconTheme: const IconThemeData(color: AppColor.primary),
            )
          : AppBar(
              title: const Text(
              AppString.tableSituation,
              style: TextStyle(color: AppColor.primary),
            )),
      body: Container(
        color: AppColor.grey,
        child: Column(
          children: [
            Consumer<TableSituationProvider>(
                builder: (context, provider, child) {
              return _tableType(provider.lstTableType);
            }),
            Consumer<TableSituationProvider>(
                builder: (context, provider, child) {
              return Expanded(child: _table(provider.lstTableSituation));
            }),
          ],
        ),
      ),
    );
  }

  Widget _table(List<TableSituationModel> lstTableSituation) {
    return GridView.count(
        shrinkWrap: true,
        crossAxisCount: 3,
        children: List.generate(lstTableSituation.length, (index) {
          TableSituationModel table = lstTableSituation[index];
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
                  if (!isFromNav) {
                    //if (!table.isOccupied) {
                    context.read<OrderProvider>().setSelectedTable({
                      "tableId": table.tableId,
                      "tableName": table.tableName,
                      "isOccupied": table.isOccupied ? true : false
                    });
                    Navigator.pop(context);
                    //}
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

  Widget _tableType(List<Map<String, dynamic>> lstTableType) {
    return SizedBox(
        height: 60,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: lstTableType.length,
            itemBuilder: (context, index) {
              Map<String, dynamic> tableType = lstTableType[index];
              return Container(
                decoration: context
                            .read<TableSituationProvider>()
                            .selectedTableType["TableTypeID"] !=
                        tableType["TableTypeID"]
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
                      context
                          .read<TableSituationProvider>()
                          .setSelectedTableType(tableType);

                      EasyLoading.show();
                      apiService
                          .getTableSituation(
                              dataDownloadingController.connectorModel,
                              tableType["TableTypeID"])
                          .then((lstTableSituation) {
                        EasyLoading.dismiss();
                        context
                            .read<TableSituationProvider>()
                            .setTableSituation(lstTableSituation);
                      });
                    },
                    child: Container(
                        width: 130,
                        height: 60,
                        alignment: Alignment.center,
                        child: context
                                    .read<TableSituationProvider>()
                                    .selectedTableType["TableTypeID"] !=
                                tableType["TableTypeID"]
                            ? AppText(
                                text: tableType["TableTypeName"],
                                fontFamily: "BOS",
                              )
                            : AppText(
                                text: tableType["TableTypeName"],
                                color: Colors.white,
                                fontFamily: "BOS")),
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
