import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:waiter_app/provider/order_provider.dart';
import 'package:waiter_app/provider/setting_provider.dart';
import 'package:waiter_app/widget/app_text.dart';

import '../provider/customer_provider.dart';
import '../value/app_color.dart';
import '../value/app_string.dart';
import '../value/time_type.dart';
import 'dialog/dialog_time.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class CustomerEntry extends StatefulWidget {
  const CustomerEntry({super.key});

  @override
  State<CustomerEntry> createState() => _CustomerEntryState();
}

class _CustomerEntryState extends State<CustomerEntry> {
  @override
  void initState() {
    context
        .read<CustomerProvider>()
        .setDate(DateFormat('dd/MM/yyyy').format(DateTime.now()), false);
    context
        .read<CustomerProvider>()
        .setTime(DateFormat.jm().format(DateTime.now()), false);
    context.read<SettingProvider>().getAddCustomerByTotalPerson().then((value) {
      context
          .read<CustomerProvider>()
          .setIsAddCustomerByTotalPerson(value ?? false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.grey,
      appBar: AppBar(
        title: const Text(AppString.addCustomerNumber,
            style: TextStyle(color: AppColor.primary)),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColor.primary300),
                child: Row(
                  children: [
                    const Icon(
                      Icons.table_bar,
                      color: AppColor.primary,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    const AppText(
                      text: "${AppString.table} - ",
                      fontFamily: "BOS",
                      fontWeight: FontWeight.bold,
                    ),
                    AppText(
                      text: context
                          .read<OrderProvider>()
                          .selectedTable["tableName"],
                      fontFamily: "BOS",
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: Material(
                      color: Colors.white,
                      child: InkWell(
                        splashColor: AppColor.grey,
                        onTap: () {
                          showDialog<void>(
                              barrierDismissible: false,
                              context: context,
                              builder: (BuildContext context) {
                                return SfDateRangePicker(
                                  backgroundColor: AppColor.primary300,
                                  onSelectionChanged:
                                      (dateRangePickerSelectionChangedArgs) {
                                    if (dateRangePickerSelectionChangedArgs
                                        .value is DateTime) {
                                      String date = DateFormat('dd/MM/yyyy')
                                          .format(
                                              dateRangePickerSelectionChangedArgs
                                                  .value);
                                      context
                                          .read<CustomerProvider>()
                                          .setDate(date, true);
                                      Navigator.pop(context);
                                    }
                                  },
                                );
                              });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              border: Border.all(color: AppColor.primary300),
                              borderRadius: BorderRadius.circular(5)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const AppText(
                                    text: AppString.date,
                                    size: 14,
                                    color: AppColor.primary500,
                                  ),
                                  Consumer<CustomerProvider>(
                                      builder: (context, provider, child) {
                                    return AppText(
                                      text: provider.date,
                                    );
                                  }),
                                ],
                              ),
                              const Icon(
                                Icons.date_range,
                                color: AppColor.primary,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Material(
                      color: Colors.white,
                      child: InkWell(
                        splashColor: AppColor.grey,
                        onTap: () {
                          showDialog<void>(
                              barrierDismissible: false,
                              context: context,
                              builder: (BuildContext context) {
                                return const DialogTime(
                                  timeType: TimeType.customerTime,
                                );
                              });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              border: Border.all(color: AppColor.primary300),
                              borderRadius: BorderRadius.circular(5)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const AppText(
                                    text: AppString.time,
                                    size: 14,
                                    color: AppColor.primary500,
                                  ),
                                  Consumer<CustomerProvider>(
                                      builder: (context, provider, child) {
                                    return AppText(
                                      text: provider.time,
                                    );
                                  }),
                                ],
                              ),
                              const Icon(
                                Icons.punch_clock,
                                color: AppColor.primary,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Consumer<CustomerProvider>(builder: (context, provider, child) {
                return !provider.isAddCustomerByTotalPerson
                    ? Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller:
                                context.read<CustomerProvider>().manController,
                            style: const TextStyle(color: AppColor.primaryDark),
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                                labelText: AppString.man,
                                labelStyle:
                                    TextStyle(color: AppColor.primary500),
                                border: OutlineInputBorder()),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: context
                                .read<CustomerProvider>()
                                .womenController,
                            style: const TextStyle(color: AppColor.primaryDark),
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                                labelText: AppString.women,
                                labelStyle:
                                    TextStyle(color: AppColor.primary500),
                                border: OutlineInputBorder()),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: context
                                .read<CustomerProvider>()
                                .childController,
                            style: const TextStyle(color: AppColor.primaryDark),
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.done,
                            decoration: const InputDecoration(
                                labelText: AppString.child,
                                labelStyle:
                                    TextStyle(color: AppColor.primary500),
                                border: OutlineInputBorder()),
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: context
                                .read<CustomerProvider>()
                                .totalCustomerController,
                            style: const TextStyle(color: AppColor.primaryDark),
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.done,
                            decoration: const InputDecoration(
                                labelText: AppString.totalCustomer,
                                labelStyle:
                                    TextStyle(color: AppColor.primary500),
                                border: OutlineInputBorder()),
                          ),
                        ],
                      );
              }),
              const SizedBox(
                height: 30,
              ),
              Align(
                alignment: Alignment.topRight,
                child: ElevatedButton(
                    onPressed: () {
                      int man = 0, women = 0, child = 0, totalCustomer = 0;
                      if (context
                          .read<CustomerProvider>()
                          .isAddCustomerByTotalPerson) {
                        if (context
                            .read<CustomerProvider>()
                            .totalCustomerController
                            .text
                            .isNotEmpty) {
                          totalCustomer = int.parse(context
                              .read<CustomerProvider>()
                              .totalCustomerController
                              .text);
                        }
                      } else {
                        if (context
                            .read<CustomerProvider>()
                            .manController
                            .text
                            .isNotEmpty) {
                          man = int.parse(context
                              .read<CustomerProvider>()
                              .manController
                              .text);
                        }
                        if (context
                            .read<CustomerProvider>()
                            .womenController
                            .text
                            .isNotEmpty) {
                          women = int.parse(context
                              .read<CustomerProvider>()
                              .womenController
                              .text);
                        }
                        if (context
                            .read<CustomerProvider>()
                            .childController
                            .text
                            .isNotEmpty) {
                          child = int.parse(context
                              .read<CustomerProvider>()
                              .childController
                              .text);
                        }
                        totalCustomer = man + women + child;
                      }
                      /* context
                          .read<OrderProvider>()
                          .setTotalCustomer(totalCustomer); */
                      context.read<OrderProvider>().setCustomerNumber({
                        "date": context.read<CustomerProvider>().date,
                        "time": context.read<CustomerProvider>().time,
                        "man": man,
                        "women": women,
                        "child": child,
                        "totalCustomer": totalCustomer
                      });
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.primary500,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.only(
                            top: 20, bottom: 20, right: 30, left: 30),
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.zero))),
                    child: const Text(AppString.save)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
