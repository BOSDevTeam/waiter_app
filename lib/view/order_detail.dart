import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:waiter_app/provider/order_detail_provider.dart';
import 'package:waiter_app/provider/setting_provider.dart';
import 'package:waiter_app/view/customer_entry.dart';

import '../api/apiservice.dart';
import '../database/database_helper.dart';
import '../model/connector_model.dart';
import '../model/order_model.dart';
import '../provider/login_provider.dart';
import '../value/app_color.dart';
import '../value/app_string.dart';
import '../widget/app_text.dart';
import 'package:dio/dio.dart';
import '../value/app_constant.dart';

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
  dynamic connectorModel;
  final int tableId;
  final String tableName;

  _OrderDetailState(this.tableId, this.tableName);

  @override
  void initState() {
    DatabaseHelper().getBaseUrl().then((value) {
      apiService =
          ApiService(dio: Dio(BaseOptions(baseUrl: value[0]["BaseUrl"])));

      DatabaseHelper().getConnector().then((value) {
        connectorModel = ConnectorModel(
            ipAddress: value[0]["IPAddress"],
            databaseName: value[0]["DatabaseName"],
            databaseLoginUser: value[0]["DatabaseLoginUser"],
            databaseLoginPassword: value[0]["DatabaseLoginPassword"]);

        EasyLoading.show();
        apiService.getOrder(connectorModel, tableId).then((orderMasterModel) {
          EasyLoading.dismiss();
          context
              .read<OrderDetailProvider>()
              .setStartTime(orderMasterModel.startTime);
          context
              .read<OrderDetailProvider>()
              .setTotalCustomer(orderMasterModel.totalCustomer);
          context
              .read<SettingProvider>()
              .getCalculateAdvancedTax()
              .then((isCalculateAdvancedTax) {
            context
                .read<SettingProvider>()
                .getHideCommercialTax()
                .then((isHideCommercialTax) {
              context.read<OrderDetailProvider>().setOrderList(
                  orderMasterModel.lstOrder,
                  isCalculateAdvancedTax ?? false,
                  isHideCommercialTax ?? false);
            });
          });
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
        actions: [
          IconButton(
              onPressed: () {
                context
                    .read<LoginProvider>()
                    .getLoginWaiter()
                    .then((waiterModel) {
                  EasyLoading.show();
                  apiService
                      .getBill(connectorModel, tableId, tableName,
                          waiterModel.waiterId, waiterModel.waiterName)
                      .then((value) {
                    EasyLoading.dismiss();
                    if (value) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: AppText(
                              text: "$tableName ${AppString.billRequested}",
                              color: Colors.white,
                              fontFamily: "BOS")));
                    } else {
                      Fluttertoast.showToast(
                        msg: AppString.somethingWentWrong,
                      );
                    }
                  });
                });
              },
              icon: const Icon(
                Icons.paid,
                color: AppColor.primary,
              ))
        ],
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
                  Expanded(
                    child: Row(
                      children: [
                        const ClipOval(
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
                        const SizedBox(
                          width: 20,
                        ),
                        Flexible(
                          child: Column(
                            children: [
                              const AppText(
                                text: AppString.table,
                                size: 16,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              AppText(
                                text: tableName,
                                color: AppColor.primary,
                                size: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: "BOS",
                              )
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
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return CustomerEntry(
                                    isFromOrderDetail: true,
                                    tableId: tableId,
                                    tableName: tableName,
                                  );
                                }));
                              },
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
                        Flexible(
                          child: Column(
                            children: [
                              const AppText(
                                text: AppString.customers,
                                size: 16,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Consumer<OrderDetailProvider>(
                                  builder: (context, provider, child) {
                                return AppText(
                                  text: provider.totalCustomer == 0
                                      ? "-"
                                      : provider.totalCustomer.toString(),
                                  color: AppColor.primary,
                                  size: 20,
                                  fontWeight: FontWeight.bold,
                                );
                              }),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, top: 10, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const AppText(
                    text: AppString.orders,
                    color: AppColor.primary500,
                  ),
                  Consumer<OrderDetailProvider>(
                      builder: (context, provider, child) {
                    return provider.startTime.isNotEmpty
                        ? Row(
                            children: [
                              const AppText(
                                text: AppString.startTime,
                                color: AppColor.primary500,
                                size: 14,
                              ),
                              AppText(
                                text: provider.startTime,
                                color: AppColor.primary,
                                size: 14,
                              )
                            ],
                          )
                        : const SizedBox();
                  }),
                ],
              ),
            ),
            const Divider(),
            Consumer<OrderDetailProvider>(builder: (context, provider, child) {
              return Expanded(child: _orderDetail(provider));
            }),
            const Divider(),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const AppText(text: AppString.subtotal),
                      Consumer<OrderDetailProvider>(
                          builder: (context, provider, child) {
                        return AppText(
                            text: AppConstant.formatter
                                .format(provider.subtotal));
                      }),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const AppText(text: AppString.charges),
                      Consumer<OrderDetailProvider>(
                          builder: (context, provider, child) {
                        return AppText(
                            text: AppConstant.formatter
                                .format(provider.chargesAmount));
                      }),
                    ],
                  ),
                  Consumer<OrderDetailProvider>(
                      builder: (context, provider, child) {
                    return !provider.isHideCommercialTax
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const AppText(text: AppString.tax),
                              Consumer<OrderDetailProvider>(
                                  builder: (context, provider, child) {
                                return AppText(
                                    text: AppConstant.formatter
                                        .format(provider.taxAmount));
                              }),
                            ],
                          )
                        : const SizedBox();
                  }),
                  const Divider(
                    color: AppColor.primary400,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const AppText(
                        text: AppString.total,
                        fontWeight: FontWeight.bold,
                      ),
                      Consumer<OrderDetailProvider>(
                          builder: (context, provider, child) {
                        return AppText(
                          text: AppConstant.formatter.format(provider.total),
                          fontWeight: FontWeight.bold,
                        );
                      }),
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
                  style: const TextStyle(
                      fontFamily: "BOS", color: AppColor.primaryDark),
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
                        const AppText(
                          text: "x",
                          size: 10,
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        AppText(
                            text: AppConstant.formatter.format(data.salePrice)),
                        const SizedBox(
                          width: 15,
                        ),
                        data.itemDiscount != 0
                            ? Container(
                                padding:
                                    const EdgeInsets.only(left: 5, right: 5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: AppColor.grey),
                                child: AppText(
                                  text: "${data.itemDiscount}%",
                                  color: AppColor.primary500,
                                  size: 14,
                                ),
                              )
                            : const SizedBox()
                      ],
                    ),
                    AppText(text: AppConstant.formatter.format(data.amount)),
                  ],
                )
              ],
            ),
          );
        });
  }
}
