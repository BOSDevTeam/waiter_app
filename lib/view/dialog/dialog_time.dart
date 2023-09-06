import 'package:flutter/material.dart';

import '../../value/app_string.dart';
import '../../widget/app_text.dart';

class DialogTime extends StatefulWidget {
  const DialogTime({super.key});

  @override
  State<DialogTime> createState() => _DialogTimeState();
}

class _DialogTimeState extends State<DialogTime> {
  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, setstate) {
      return AlertDialog(
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        title: const AppText(text: AppString.enterTime),
        content: Container(),
        actions: [
          
        ],
      );
    });
  }
}
