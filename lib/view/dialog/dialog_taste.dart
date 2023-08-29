import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waiter_app/database/database_helper.dart';
import 'package:waiter_app/provider/taste_provider.dart';
import 'package:waiter_app/widget/app_text.dart';

import '../../provider/order_provider.dart';
import '../../value/app_color.dart';
import '../../value/app_string.dart';
import '../navigation/nav_order.dart';

class DialogTaste extends StatefulWidget {
  final int orderIndex;
  final bool isTasteMulti;
  const DialogTaste(
      {super.key, required this.orderIndex, required this.isTasteMulti});

  @override
  State<DialogTaste> createState() =>
      _DialogTasteState(orderIndex, isTasteMulti);
}

class _DialogTasteState extends State<DialogTaste> {
  final tasteProvider = TasteProvider();
  int orderIndex;
  bool isTasteMulti;

  _DialogTasteState(this.orderIndex, this.isTasteMulti);

  @override
  void initState() {
    if (!isTasteMulti) {
      DatabaseHelper().getTaste().then((value) {
        tasteProvider.lstTaste = value;
      });
    } else {
      DatabaseHelper().getTasteMulti().then((value) {
        tasteProvider.lstTaste = value;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, setstate) {
      return AlertDialog(
        title: !isTasteMulti
            ? const AppText(text: AppString.commonTaste)
            : const AppText(text: AppString.tasteByItem),
        content: Column(
          children: [
            Consumer<TasteProvider>(builder: (context, provider, child) {
              return TextFormField(
                controller: provider.tasteController,
                style: const TextStyle(fontFamily: "BOS"),
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                        onPressed: () {
                          context.read<TasteProvider>().clearSelectedTaste();
                        },
                        icon: const Icon(Icons.cancel))),
                maxLines: null,
                keyboardType: TextInputType.multiline,
              );
            }),
            Expanded(child: _taste(isTasteMulti)),
          ],
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                  onPressed: () {
                    context.read<TasteProvider>().clearSelectedTaste();
                    Navigator.pop(context);
                  },
                  child: const Text(AppString.cancel)),
              ElevatedButton(
                  onPressed: () {
                    String tastes = context.read<TasteProvider>().selectedTaste;
                    if (!isTasteMulti) {
                      context
                          .read<OrderProvider>()
                          .updateCommonTaste(orderIndex, tastes);
                    } else {
                      context
                          .read<OrderProvider>()
                          .updateTasteByItem(orderIndex, tastes);
                    }
                    context.read<TasteProvider>().clearSelectedTaste();
                    Navigator.pop(context);
                  },
                  child: const Text(AppString.add))
            ],
          )
        ],
      );
    });
  }

  Widget _taste(bool isTasteMulti) {
    return SizedBox(
      width: double.maxFinite,
      child: ListView.builder(
          itemCount: tasteProvider.lstTaste.length,
          itemBuilder: (context, index) {
            Map<String, dynamic> data = tasteProvider.lstTaste[index];
            return ListTile(
              leading: AppText(
                text: data["tasteName"],
                fontFamily: "BOS",
              ),
              trailing: isTasteMulti
                  ? AppText(
                      text: data["price"],
                      size: 14,
                    )
                  : Container(),
              onTap: () {
                context
                    .read<TasteProvider>()
                    .setSelectedTaste(data["tasteName"]);
              },
            );
          }),
    );
  }
}
