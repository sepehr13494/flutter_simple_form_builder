library flutter_simple_form_builder;

import 'package:flutter/material.dart';
import 'package:flutter_simple_form_builder/date_manager.dart';
import 'package:flutter_simple_form_builder/form_obj.dart';
import 'package:flutter_simple_form_builder/global_functions.dart';
import 'package:numberpicker/numberpicker.dart';

class MyFormBuilder<Type> extends StatefulWidget {

  final List<List<MyFormObj>> fullFormObjList;
  final Type? obj;
  final Function(Map) onSubmit;
  final Widget? middleWidget;
  final String? buttonText;
  final bool showButton;

  const MyFormBuilder(
      {Key? key,
        required this.fullFormObjList,
        this.obj,
        required this.onSubmit,
        this.middleWidget,
        this.buttonText, this.showButton = true})
      : super(key: key);

  @override
  State<MyFormBuilder> createState() {
    return MyFormBuilderState();
  }
}

class MyFormBuilderState extends State<MyFormBuilder> {
  List<TextEditingController> controllers = [];

  @override
  void initState() {
    if(widget.obj != null){
      initTextFields();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const SizedBox(height: 24),
          ...List.generate(widget.fullFormObjList.length, (fullIndex) {
            List<MyFormObj> formObjList = widget.fullFormObjList[fullIndex];
            return Row(
              children: List.generate(formObjList.length, (index) {
                return Expanded(
                  flex: formObjList[index].flex,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        formObjList[index].title == null
                            ? Container()
                            : Column(
                          children: [
                            Text(formObjList[index].title! +
                                (formObjList[index].optional
                                    ? ""
                                    : " *")),
                            const SizedBox(height: 12),
                          ],
                        ),
                        _buildTextField(formObjList[index]),
                        formObjList[index].bottomWidget == null
                            ? Container()
                            : formObjList[index].bottomWidget!,
                      ],
                    ),
                  ),
                );
              }),
            );
          }),
          widget.middleWidget == null ? Container() : widget.middleWidget!,
          widget.showButton ? Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 8.0),
            child: ElevatedButton(
              onPressed: () async {
                await submit();
              },
              child: Text(widget.buttonText == null
                  ? "Confirm"
                  : widget.buttonText!),
            ),
          ) : Container(),
        ],
      ),
    );
  }

  Widget _buildTextField(MyFormObj formObjList) {
    return TextField(
      onTap: _onTapBuilder(formObjList),
      textInputAction: TextInputAction.next,
      controller: formObjList.controller,
      readOnly: formObjList.readOnly,
      keyboardType: _buildKeyboardType(formObjList),
      maxLines: formObjList.type == MyFormType.bigText ? 7 : 1,
      obscureText: formObjList.type == MyFormType.password ? true : false,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 12),
          hintText: formObjList.hint,
          hintStyle: const TextStyle(fontSize: 12),
          suffixIcon: formObjList.suffixIcon,
          prefixIcon: formObjList.prefixIcon),
    );
  }

  _buildKeyboardType(MyFormObj formObjList) {
    switch (formObjList.type) {
      case MyFormType.text:
      case MyFormType.bigText:
      case MyFormType.date:
      case MyFormType.time:
      case MyFormType.singleChoice:
      case MyFormType.multipleChoice:
      case MyFormType.password:
      case MyFormType.count:
        return TextInputType.text;
      case MyFormType.number:
        return TextInputType.number;
      case MyFormType.email:
        return TextInputType.emailAddress;
    }
  }

  Future<void> submit() async {
    if (_validate()) {
      Map<String, dynamic> map = <String, dynamic>{};
      for (var fullElement in widget.fullFormObjList) {
        for (var element in fullElement) {
          map.addEntries(
              [MapEntry(element.serverName, outPutBuilder(element))]);
        }
      }
      widget.onSubmit(map);
    }
  }

  bool _validate() {
    bool validate = true;
    for (var fullElement in widget.fullFormObjList) {
      for (var element in fullElement) {
        if (!element.optional && element.controller.text.isEmpty) {
          validate = false;
          GlobalFunctions.showMySnackBar(context, "Please fill all non optional fields");
          break;
        }
      }
    }
    return validate;
  }

  Function()? _onTapBuilder(MyFormObj formObjList) {
    switch (formObjList.type) {
      case MyFormType.date:
        return () {
          showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(1900), lastDate: DateTime(2100)).then((value) {
            if(value != null){
              formObjList.controller.text = DateManager.getLocalDateFromDate(value, context);
            }
          });
        };
      case MyFormType.text:
      case MyFormType.bigText:
      case MyFormType.time:
      case MyFormType.password:
      case MyFormType.number:
      case MyFormType.email:
      case MyFormType.multipleChoice:
        return null;
      case MyFormType.singleChoice:
        return () async {
          ChoiceObj? choiceObj = await GlobalFunctions.showChoicePicker(
              context, formObjList.choiceObjs!);
          if (choiceObj != null) {
            setState(() {
              formObjList.choiceValue = choiceObj.id;
              formObjList.controller.text = choiceObj.title;
            });
          }
        };
      case MyFormType.count:
        return () async {
          int _currentValue = 0;
          showDialog(
              context: context,
              builder: (context) {
                return StatefulBuilder(builder: (context, ststate) {
                  return Dialog(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          const Text(
                            "Please pick a number",
                            style: TextStyle(fontSize: 18),
                          ),
                          const SizedBox(height: 24),
                          NumberPicker(
                            value: _currentValue,
                            minValue: 0,
                            maxValue: 100,
                            onChanged: (value) =>
                                ststate(() => _currentValue = value),
                          ),
                          const SizedBox(height: 24),
                          ElevatedButton(
                              child: const Text("Confirm"),
                              onPressed: () {
                                Navigator.pop(context, _currentValue);
                              })
                        ],
                      ),
                    ),
                  );
                });
              })
              .then((value) =>
          formObjList.controller.text = (value ?? "0").toString());
        };
    }
  }

  outPutBuilder(MyFormObj element) {
    switch (element.type) {
      case MyFormType.text:
      case MyFormType.bigText:
      case MyFormType.date:
      case MyFormType.time:
      case MyFormType.multipleChoice:
      case MyFormType.password:
      case MyFormType.number:
      case MyFormType.email:
        return element.controller.text;
      case MyFormType.singleChoice:
        return element.choiceValue;
      case MyFormType.count:
        break;
    }
  }

  void initTextFields() {
    var userObj = widget.obj;
    Map<String, dynamic> fullUserObjJson = userObj.toJson();
    for (var fullElement in widget.fullFormObjList) {
      for (var element in fullElement) {
        for (var user in fullUserObjJson.keys) {
          if (user == element.serverName) {
            if (fullUserObjJson[user] != null) {
              if (element.type != MyFormType.singleChoice) {
                element.controller.text = fullUserObjJson[user].toString();
              } else {
                var endObj = element.choiceObjs!
                    .where((element) => element.id == fullUserObjJson[user])
                    .first;
                element.controller.text = endObj.title;
                element.choiceValue = endObj.id;
              }
            }
          }
        }
      }
    }
  }
}
