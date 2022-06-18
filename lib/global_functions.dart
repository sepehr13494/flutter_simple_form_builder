import 'package:flutter/material.dart';
import 'package:flutter_simple_form_builder/form_obj.dart';


class GlobalFunctions{
  static Future<ChoiceObj?> showChoicePicker(BuildContext context, List<ChoiceObj> list) async {
    return await showDialog(context: context, builder: (context){
      return Dialog(
        child: SingleChildScrollView(
          child: ListView.separated(itemBuilder: (context, index){
            return InkWell(
              onTap: (){
                Navigator.pop(context,list[index]);
              },
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(list[index].title),
                ),
              ),
            );
          }, separatorBuilder: (context,_)=> const Divider(), itemCount: list.length,shrinkWrap: true,padding: const EdgeInsets.all(24),),
        ),
      );
    });
  }

  static showMySnackBar(BuildContext context,String text, {Color? color}){
    ScaffoldMessenger.of(context)
      .showSnackBar(
        SnackBar(
          content: Text(text, textAlign: TextAlign.center),
          backgroundColor: color ?? Theme.of(context).errorColor,
          behavior: SnackBarBehavior.floating,
        ),
      );
  }
}