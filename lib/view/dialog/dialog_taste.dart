import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waiter_app/database/database_helper.dart';
import 'package:waiter_app/provider/taste_provider.dart';
import 'package:waiter_app/widget/app_text.dart';

import '../../provider/order_provider.dart';
import '../../value/app_color.dart';
import '../../value/app_string.dart';

class DialogTaste extends StatefulWidget {
  final int orderIndex;
  final bool isTasteMulti;
  final int incomeId;
  const DialogTaste(
      {super.key,
      required this.orderIndex,
      required this.isTasteMulti,
      required this.incomeId});

  @override
  State<DialogTaste> createState() =>
      _DialogTasteState(orderIndex, isTasteMulti, incomeId);
}

class _DialogTasteState extends State<DialogTaste> {
  int orderIndex;
  bool isTasteMulti;
  int incomeId;

  _DialogTasteState(this.orderIndex, this.isTasteMulti, this.incomeId);

  @override
  void initState() {
    if (!isTasteMulti) {
      context.read<TasteProvider>().loadSelectedTaste(
          context.read<OrderProvider>().getCommonTaste(orderIndex), 0);
      DatabaseHelper().getTaste().then((value) {
        context.read<TasteProvider>().setTaste(value);
      });
    } else {
      context.read<TasteProvider>().loadSelectedTaste(
          context.read<OrderProvider>().getTasteByItem(orderIndex),
          context.read<OrderProvider>().getTotalTastePrice(orderIndex));
      DatabaseHelper().getTasteMulti(incomeId).then((value) {
        context.read<TasteProvider>().setTaste(value);
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, setstate) {
      return AlertDialog(
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        title: !isTasteMulti
            ? const AppText(text: AppString.commonTaste)
            : const AppText(text: AppString.tasteByMenu),
        content: Column(
          children: [
            Consumer<TasteProvider>(builder: (context, provider, child) {
              return TextFormField(
                readOnly: true,
                controller: provider.tasteController,
                style: const TextStyle(
                    fontFamily: "BOS", color: AppColor.primary500),
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                        onPressed: () {
                          context.read<TasteProvider>().clearSelectedTaste();
                          context
                              .read<TasteProvider>()
                              .clearSelectedTastePrice();
                        },
                        icon: const Icon(Icons.cancel))),
                maxLines: null,
                keyboardType: TextInputType.multiline,
              );
            }),
            Consumer<TasteProvider>(builder: (context, provider, child) {
              return Expanded(child: _taste(isTasteMulti, provider.lstTaste));
            })
          ],
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                  onPressed: () {
                    context.read<TasteProvider>().clearSelectedTaste();
                    context.read<TasteProvider>().clearSelectedTastePrice();
                    Navigator.pop(context);
                  },
                  child: const Text(AppString.cancel)),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    String tastes = context.read<TasteProvider>().selectedTaste;
                    int totalTastePrice =
                        context.read<TasteProvider>().selectedTastePrice;
                    if (!isTasteMulti) {
                      context
                          .read<OrderProvider>()
                          .updateCommonTaste(orderIndex, tastes);
                    } else {
                      context.read<OrderProvider>().updateTasteByItem(
                          orderIndex, tastes, totalTastePrice);
                    }
                    context.read<TasteProvider>().clearSelectedTaste();
                    context.read<TasteProvider>().clearSelectedTastePrice();
                  },
                  child: const Text(AppString.add))
            ],
          )
        ],
      );
    });
  }

  Widget _taste(bool isTasteMulti, List<Map<String, dynamic>> lstTaste) {
    return SizedBox(
      width: double.maxFinite,
      child: ListView.builder(
          itemCount: lstTaste.length,
          itemBuilder: (context, index) {
            Map<String, dynamic> data = lstTaste[index];
            return ListTile(
              leading: AppText(
                text: data["TasteName"],
                fontFamily: "BOS",
              ),
              title: isTasteMulti
                  ? Align(
                      alignment: Alignment.centerRight,
                      child: AppText(
                        text: data["Price"].toString(),
                        size: 14,
                      ),
                    )
                  : Container(),
              onTap: () {
                context
                    .read<TasteProvider>()
                    .setSelectedTaste(data["TasteName"]);
                context
                    .read<TasteProvider>()
                    .setSelectedTastePrice(data["Price"] ?? 0);
              },
            );
          }),
    );
  }
}
