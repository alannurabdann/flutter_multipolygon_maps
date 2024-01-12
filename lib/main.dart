import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'helpers/appPages.dart';
import 'helpers/appRoutes.dart';

void main() async {
  GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
    ));
    return GetMaterialApp(
      title: 'Flutter Getx',
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 250),
      theme: ThemeData(
        brightness: Brightness.light,
      ),
      getPages: AppPages.pages,
      initialRoute: AppRoutes.main,
    );
  }
}
