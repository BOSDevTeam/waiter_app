import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waiter_app/value/number_type.dart';
import 'package:waiter_app/widget/app_text.dart';

import '../../provider/number_provider.dart';
import '../../provider/order_provider.dart';
import '../../value/app_color.dart';
import '../../value/app_string.dart';

class DialogNumber extends StatefulWidget {
  final int orderIndex;
  final NumberType numberType;
  const DialogNumber(
      {super.key, required this.orderIndex, required this.numberType});

  @override
  State<DialogNumber> createState() =>
      _DialogNumberState(orderIndex, numberType);
}

class _DialogNumberState extends State<DialogNumber> {
  int orderIndex;
  NumberType numberType;

  _DialogNumberState(this.orderIndex, this.numberType);

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, setstate) {
      return AlertDialog(
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        titlePadding:
            const EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
        contentPadding: const EdgeInsets.all(0),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            numberType == NumberType.quantityNumber
                ? const AppText(
                    text: AppString.quantity,
                    size: 18,
                  )
                : const AppText(
                    text: AppString.numberOrder,
                    size: 18,
                  ),
            IconButton(
                onPressed: () {
                  context.read<NumberProvider>().clearNumber();
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.close))
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Consumer<NumberProvider>(builder: (context, provider, child) {
              return TextFormField(
                readOnly: true,
                controller: provider.numberController,
                style:
                    const TextStyle(color: AppColor.primaryDark, fontSize: 20),
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.white70,
                    suffixIcon: IconButton(
                        onPressed: () {
                          context.read<NumberProvider>().deleteNumber();
                        },
                        icon: const Icon(Icons.backspace))),
              );
            }),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            context.read<NumberProvider>().setNumber("1");
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 60,
                            child: const AppText(
                              text: "1",
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            context.read<NumberProvider>().setNumber("2");
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 60,
                            child: const AppText(
                              text: "2",
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            context.read<NumberProvider>().setNumber("3");
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 60,
                            child: const AppText(
                              text: "3",
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            context.read<NumberProvider>().setNumber("4");
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 60,
                            child: const AppText(
                              text: "4",
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            context.read<NumberProvider>().setNumber("5");
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 60,
                            child: const AppText(
                              text: "5",
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            context.read<NumberProvider>().setNumber("6");
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 60,
                            child: const AppText(
                              text: "6",
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            context.read<NumberProvider>().setNumber("7");
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 60,
                            child: const AppText(
                              text: "7",
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            context.read<NumberProvider>().setNumber("8");
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 60,
                            child: const AppText(
                              text: "8",
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            context.read<NumberProvider>().setNumber("9");
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 60,
                            child: const AppText(
                              text: "9",
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            context.read<NumberProvider>().setNumber("0");
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 60,
                            child: const AppText(
                              text: "0",
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Material(
                        color: Colors.white54,
                        child: InkWell(
                          onTap: () {
                            context.read<NumberProvider>().clearNumber();
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 60,
                            child: const AppText(
                              text: "C",
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Material(
                        color: AppColor.primary500,
                        child: InkWell(
                          onTap: () {
                            String number = context.read<NumberProvider>().num;
                            if (number.isNotEmpty) {
                              int num = int.parse(number);
                              if (numberType == NumberType.quantityNumber) {
                                context
                                    .read<OrderProvider>()
                                    .changeQuantity(orderIndex, num);
                              } else if (numberType ==
                                  NumberType.orderItemNumber) {
                                context
                                    .read<OrderProvider>()
                                    .numberOrderItem(orderIndex, num);
                              }

                              context.read<NumberProvider>().clearNumber();
                              Navigator.pop(context);
                            }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 60,
                            child: const AppText(
                              text: "OK",
                              size: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      );
    });
  }
}
