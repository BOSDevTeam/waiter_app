import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waiter_app/controller/taste_provider.dart';
import 'package:waiter_app/widget/app_text.dart';

import '../../hive/hive_db.dart';
import '../../value/app_color.dart';
import '../../value/app_string.dart';

class DialogTaste extends StatefulWidget {
  const DialogTaste({super.key});

  @override
  State<DialogTaste> createState() => _DialogTasteState();
}

class _DialogTasteState extends State<DialogTaste> {
  final tasteProvider=TasteProvider();

  @override
  void initState() {
    tasteProvider.lstTaste=HiveDB.getTaste();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context,setstate){
      return AlertDialog(
        title: const AppText(text: AppString.commonTaste),
        content: Column(
          children: [
            Container(
              color: Colors.lightBlue,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Consumer<TasteProvider>(
                                  builder: (context, provider, child) {
                                return Flexible(
                                  child: AppText(
                                    text: provider.selectedTaste,
                                    color: AppColor.primary,
                                    fontFamily: "BOS",
                                  ),
                                );
                              }),
                  IconButton(onPressed: (){

                  }, icon: Icon(Icons.cancel))
                ],
              ),
            ),
            Expanded(child: _taste()),
          ],
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(onPressed: (){
                Navigator.pop(context);
              }, child: const Text(AppString.cancel)),
              ElevatedButton(
                  onPressed: () {},
                  child: const Text(AppString.add))
            ],
          )
        ],
      );
    });
  }

  Widget _taste(){
    return SizedBox(
      width: double.maxFinite,
      child: ListView.builder(
        itemCount: tasteProvider.lstTaste.length,
        itemBuilder:(context,index){
          Map<String,dynamic> data=tasteProvider.lstTaste[index];
          return ListTile(
            leading: AppText(text:data["tasteName"],fontFamily: "BOS",),
            onTap: () {
              context.read<TasteProvider>().setSelectedTaste(data["tasteName"]);
            },
          );
      }),
    );
  }

}