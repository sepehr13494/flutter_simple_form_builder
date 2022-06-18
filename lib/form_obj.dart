import 'package:flutter/material.dart';

class MyFormObj {
  String? title;
  String serverName;
  MyFormType type;
  bool optional;
  bool readOnly;
  dynamic choiceValue;
  String? hint;
  String? afterCount;
  Widget? suffixIcon;
  Widget? prefixIcon;
  Widget? bottomWidget;
  TextEditingController controller;
  List<ChoiceObj>? choiceObjs;
  int flex;

  MyFormObj({
    this.title,
    required this.serverName,
    required this.type,
    required this.controller,
    this.hint,
    this.afterCount,
    this.suffixIcon,
    this.prefixIcon,
    this.bottomWidget,
    this.choiceObjs,
    this.choiceValue,
    this.optional = false,
    this.readOnly = false,
    this.flex = 1,
  });

  MyFormObj copyWith({
    String? title,
    String? serverName,
    MyFormType? type,
    bool? optional,
    bool? readOnly,
    dynamic choiceValue,
    String? hint,
    String? afterCount,
    Widget? suffixIcon,
    Widget? prefixIcon,
    Widget? bottomWidget,
    TextEditingController? controller,
    List<ChoiceObj>? choiceObjs,
    int? flex,
  }) {
    return MyFormObj(
      title: title ?? this.title,
      serverName: serverName ?? this.serverName,
      type: type ?? this.type,
      optional: optional ?? this.optional,
      readOnly: readOnly ?? this.readOnly,
      choiceValue: choiceValue ?? this.choiceValue,
      hint: hint ?? this.hint,
      afterCount: afterCount ?? this.afterCount,
      suffixIcon: suffixIcon ?? this.suffixIcon,
      prefixIcon: prefixIcon ?? this.prefixIcon,
      bottomWidget: bottomWidget ?? this.bottomWidget,
      controller: controller ?? this.controller,
      choiceObjs: choiceObjs ?? this.choiceObjs,
      flex: flex ?? this.flex,
    );
  }

  Map<String, dynamic> toJson() =>
      {
        "title": title,
        "serverName": serverName,
        "type": type,
        "optional": optional,
        "readOnly": readOnly,
        "hint": hint,
        "afterCount": afterCount,
        "choiceValue": choiceValue,
        "choiceObjs": choiceObjs == null
            ? null
            : List<dynamic>.from(choiceObjs!.map((x) => x.toJson())),
        "flex": flex,
      };

}

enum MyFormType {
  text,
  bigText,
  date,
  time,
  singleChoice,
  multipleChoice,
  password,
  number,
  email,
  count,
}

class ChoiceObj {
  ChoiceObj({
    required this.id,
    required this.title,
  });

  dynamic id;
  String title;

  factory ChoiceObj.fromJson(Map<String, dynamic> json) =>
      ChoiceObj(
        id: json["id"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() =>
      {
        "id": id,
        "title": title,
      };


}
