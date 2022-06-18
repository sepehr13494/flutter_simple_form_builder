<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

You can create forms very easy in minimum lines of code

## Features

it can create form

## Getting started

just create list of MyFormObj

## Usage

```dart
class MyApp extends StatefulWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<TextEditingController> controllers = [];
  List<List<MyFormObj>> fullFormObjList = [
    [
      MyFormObj(
          controller: TextEditingController(),
          serverName: "firstname",
          title: Texts.firstName.tr,
          flex: flex,
          type: MyFormType.text),
    ],
    [
      MyFormObj(
          controller: TextEditingController(),
          serverName: "lastname",
          title: Texts.lastName.tr,
          flex: flex,
          type: MyFormType.text),
    ],
    [
      MyFormObj(
        controller: TextEditingController(),
        serverName: "birth_day",
        title: Texts.birthday.tr,
        type: MyFormType.date,
        readOnly: true,
      ),
    ],
    [
      MyFormObj(
          controller: TextEditingController(),
          serverName: "province",
          title: Texts.province.tr,
          type: MyFormType.singleChoice,
          readOnly: true,
          choiceObjs: [
            ChoiceObj(id: 0, title: "Germany"),
            ChoiceObj(id: 1, title: "France"),
          ]),
    ],
    [
      MyFormObj(
          controller: TextEditingController(),
          serverName: "gender",
          title: Texts.gender.tr,
          type: MyFormType.singleChoice,
          readOnly: true,
          flex: flex,
          choiceObjs: [
            ChoiceObj(id: 0, title: Texts.male.tr),
            ChoiceObj(id: 1, title: Texts.female.tr),
          ])
    ],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text("Example"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Complete Form Please",style: AppTextStyles.white_18,),
            MyFormBuilder(fullFormObjList: fullFormObjList,onSubmit: (map){
              print(map);
            },),
          ],
        ),
      ),
    );
  }
}

```

## Additional information

nothing