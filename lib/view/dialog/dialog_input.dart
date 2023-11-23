import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/order_provider.dart';
import '../../value/app_color.dart';
import '../../value/app_string.dart';
import '../../value/input_type.dart';
import '../../widget/app_text.dart';

class DialogInput extends StatefulWidget {
  final InputType inputType;
  final int orderIndex;
  const DialogInput(
      {super.key, required this.inputType, required this.orderIndex});

  @override
  State<DialogInput> createState() => _DialogInputState();
}

class _DialogInputState extends State<DialogInput> {
  final inputController = TextEditingController();

  @override
  void initState() {
    if (widget.inputType == InputType.tasteInput) {
      inputController.text =
          context.read<OrderProvider>().getInputTaste(widget.orderIndex);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, setstate) {
      return AlertDialog(
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        title: AppText(text: _dialogTitle()),
        content: TextFormField(
          controller: inputController,
          style: const TextStyle(color: AppColor.primaryDark),
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
              labelText: _inputLabel(),
              labelStyle: const TextStyle(color: AppColor.primary500),
              border: const OutlineInputBorder()),
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
                    Navigator.pop(context);
                    if (widget.inputType == InputType.tasteInput) {
                      context.read<OrderProvider>().updateInputTaste(
                          widget.orderIndex, inputController.text);
                    }
                  },
                  child: Text(_buttonText()))
            ],
          )
        ],
      );
    });
  }

  String _dialogTitle() {
    String title = "";
    if (widget.inputType == InputType.tasteInput) {
      title = AppString.enterTaste;
    }
    return title;
  }

  String _inputLabel() {
    String label = "";
    if (widget.inputType == InputType.tasteInput) {
      label = AppString.taste;
    }
    return label;
  }

  String _buttonText() {
    String text = "";
    if (widget.inputType == InputType.tasteInput) {
      text = AppString.add;
    } else {
      text = AppString.ok.toUpperCase();
    }
    return text;
  }
}
