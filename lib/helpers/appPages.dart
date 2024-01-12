import 'package:get/get.dart';

import '../mainScreen.dart';
import 'appRoutes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.main,
      page: () => MainScreen(),
    ),
  ];
}
