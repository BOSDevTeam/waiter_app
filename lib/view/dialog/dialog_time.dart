import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:waiter_app/provider/time_provider.dart';
import 'package:waiter_app/value/app_color.dart';

import '../../provider/order_provider.dart';
import '../../value/app_string.dart';
import '../../widget/app_text.dart';

class DialogTime extends StatefulWidget {
  const DialogTime({super.key});

  @override
  State<DialogTime> createState() => _DialogTimeState();
}

class _DialogTimeState extends State<DialogTime> {
  var timeProvider = TimeProvider();

  @override
  void initState() {
    String time = DateFormat.jm().format(DateTime.now());
    if (time.isNotEmpty) {
      List<String> lst = time.split(":");
      timeProvider.setHour(lst[0]);
      timeProvider.setMinute(lst[1].substring(0, 2));
      String period = lst[1].substring(lst[1].length - 2);
      context.read<TimeProvider>().setSelectedPeriod(period, false);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, setstate) {
      return AlertDialog(
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        title: const AppText(text: AppString.enterTime),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Row(
              children: [
                Expanded(
                    child: AppText(
                  text: AppString.hour,
                  color: AppColor.primary500,
                )),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                    child: AppText(
                  text: AppString.minute,
                  color: AppColor.primary500,
                )),
                Expanded(child: AppText(text: ""))
              ],
            ),
            Row(
              children: [
                Expanded(
                    child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                        padding: const EdgeInsets.only(top: 8, bottom: 8),
                        decoration: BoxDecoration(
                            border: Border.all(color: AppColor.primary300),
                            borderRadius: BorderRadius.circular(5)),
                        width: double.infinity,
                        child: TextFormField(
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(2)
                          ],
                          controller: timeProvider.hourController,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          decoration:
                              const InputDecoration(border: InputBorder.none),
                          style: const TextStyle(
                              color: AppColor.primaryDark,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                )),
                const SizedBox(
                  width: 5,
                ),
                const AppText(
                  text: ":",
                  size: 25,
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                    child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                        padding: const EdgeInsets.only(top: 8, bottom: 8),
                        decoration: BoxDecoration(
                            border: Border.all(color: AppColor.primary300),
                            borderRadius: BorderRadius.circular(5)),
                        width: double.infinity,
                        child: TextFormField(
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(2)
                          ],
                          controller: timeProvider.minuteController,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          decoration:
                              const InputDecoration(border: InputBorder.none),
                          style: const TextStyle(
                              color: AppColor.primaryDark,
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        )),
                  ),
                )),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                    child: Column(
                  children: [
                    Consumer<TimeProvider>(builder: (context, provider, child) {
                      return Material(
                        color: provider.isAMSelected
                            ? AppColor.primaryDark
                            : Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            context
                                .read<TimeProvider>()
                                .setSelectedPeriod("AM", true);
                          },
                          child: Container(
                            padding: const EdgeInsets.only(top: 7, bottom: 7),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black12),
                            ),
                            width: double.infinity,
                            child: const AppText(
                              text: "AM",
                              color: AppColor.primary400,
                            ),
                          ),
                        ),
                      );
                    }),
                    Consumer<TimeProvider>(builder: (context, provider, child) {
                      return Material(
                        color: provider.isPMSelected
                            ? AppColor.primaryDark
                            : Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            context
                                .read<TimeProvider>()
                                .setSelectedPeriod("PM", true);
                          },
                          child: Container(
                            padding: const EdgeInsets.only(top: 7, bottom: 7),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black12),
                            ),
                            width: double.infinity,
                            child: const AppText(
                              text: "PM",
                              color: AppColor.primary400,
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                )),
              ],
            )
          ],
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(AppString.cancel)),
              ElevatedButton(
                  onPressed: () {
                    if (timeProvider.validateControl()) {
                      String hour = timeProvider.hourController.text;
                      String minute = timeProvider.minuteController.text;
                      String period = context.read<TimeProvider>().period;
                      String time = "$hour:$minute $period";
                      context.read<OrderProvider>().setStartTime(time);
                      Navigator.pop(context);
                    }
                  },
                  child: Text(AppString.ok.toUpperCase()))
            ],
          )
        ],
      );
    });
  }
}
