import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:waiter_app/provider/order_detail_provider.dart';

import '../api/apiservice.dart';
import '../controller/data_downloading_controller.dart';
import '../database/database_helper.dart';
import '../model/connector_model.dart';
import '../model/order_model.dart';
import '../value/app_color.dart';
import '../value/app_string.dart';
import '../widget/app_text.dart';
import 'package:dio/dio.dart';

class OrderDetail extends StatefulWidget {
  final int tableId;
  final String tableName;
  const OrderDetail(
      {super.key, required this.tableId, required this.tableName});

  @override
  State<OrderDetail> createState() => _OrderDetailState(tableId, tableName);
}

class _OrderDetailState extends State<OrderDetail> {
  dynamic apiService;
  final dataDownloadingController = DataDownloadingController();
  final int tableId;
  final String tableName;

  _OrderDetailState(this.tableId, this.tableName);

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

        EasyLoading.show();
        apiService
            .getOrder(dataDownloadingController.connectorModel, tableId)
            .then((orderMasterModel) {
          EasyLoading.dismiss();
          context
              .read<OrderDetailProvider>()
              .setOrderList(orderMasterModel.lstOrder);
        });
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppString.orderDetail,
            style: TextStyle(color: AppColor.primary)),
      ),
      body: Container(
        color: AppColor.grey,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(
                  left: 20, right: 20, top: 10, bottom: 10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(0, 5))
                  ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                    child: Row(
                      children: [
                        ClipOval(
                          child: Material(
                            color: AppColor.grey,
                            shape: CircleBorder(
                                side: BorderSide(
                                    width: 2, color: AppColor.primary300)),
                            child: SizedBox(
                              width: 60,
                              height: 60,
                              child: Icon(
                                Icons.table_bar,
                                color: AppColor.primary500,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                    
                        Flexible(
                          child: Column(
                            children: [
                              AppText(
                                text: AppString.table,
                                size: 16,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              /* Consumer<OrderDetailProvider>(
                                  builder: (context, provider, child) {
                                return AppText(
                                  text: provider.tableName,
                                  color: AppColor.primary,
                                  size: 20,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "BOS",
                                );
                              }), */
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    color: AppColor.grey,
                    width: 1,
                    height: 60,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        ClipOval(
                          child: Material(
                            shape: const CircleBorder(
                                side: BorderSide(
                                    width: 2, color: AppColor.primary)),
                            child: InkWell(
                              splashColor: AppColor.primary300,
                              onTap: () {},
                              child: const SizedBox(
                                width: 60,
                                height: 60,
                                child: Icon(
                                  Icons.people,
                                  color: AppColor.primary500,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        const Column(
                          children: [
                            AppText(
                              text: AppString.customers,
                              size: 16,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            AppText(
                              text: "-",
                              color: AppColor.primary,
                              size: 20,
                              fontWeight: FontWeight.bold,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, top: 10, right: 20),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppText(
                    text: AppString.orders,
                    color: AppColor.primary500,
                  ),
                  Row(
                    children: [
                      AppText(
                        text: AppString.startTime,
                        color: AppColor.primary500,
                        size: 14,
                      ),
                      AppText(
                        text: "00:00 AM",
                        color: AppColor.primary,
                        size: 14,
                      )
                    ],
                  )
                ],
              ),
            ),
            const Divider(),
            Consumer<OrderDetailProvider>(builder: (context, provider, child) {
              return Expanded(child: _orderDetail(provider));
            }),
            const Divider(),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText(text: AppString.subtotal),
                      AppText(text: "0000"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText(text: AppString.charges),
                      AppText(text: "000"),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText(text: AppString.tax),
                      AppText(text: "000"),
                    ],
                  ),
                  const Divider(
                    color: AppColor.primary400,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppText(
                        text: AppString.total,
                        fontWeight: FontWeight.bold,
                      ),
                      AppText(
                        text: "0000",
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _orderDetail(OrderDetailProvider provider) {
    return ListView.builder(
        itemCount: provider.lstOrder.length,
        itemBuilder: (context, index) {
          OrderModel data = provider.lstOrder[index];
          return Container(
            margin: const EdgeInsets.all(5),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.itemName,
                  style: const TextStyle(fontFamily: "BOS",color: AppColor.primaryDark),
                  maxLines: null,
                ),
                data.allTaste.isNotEmpty
                    ? Text(
                        data.allTaste,
                        style: const TextStyle(
                          fontFamily: "BOS",
                          color: AppColor.primary500,
                        ),
                        maxLines: null,
                      )
                    : Container(),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        AppText(text: data.quantity.toString()),
                        const SizedBox(
                          width: 15,
                        ),
                        const AppText(text: "x",size: 10,),
                        const SizedBox(
                          width: 15,
                        ),
                        AppText(text: data.salePrice.toString()),
                      ],
                    ),
                    AppText(text: data.amount.toString()),
                  ],
                )
              ],
            ),
          );
        });
  }
}
