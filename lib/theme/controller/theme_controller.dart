import 'package:access/app/const/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ThemeController extends GetxController {
  RxBool isLightTheme = true.obs;

  _saveThemeStatus() async {
    await Hive.box(AppConstant.settings)
        .put(AppConstant.darkMode, isLightTheme.value);
    update();
  }

  void getThemeStatus() {
    isLightTheme.value = Hive.box(AppConstant.settings).get(
          AppConstant.darkMode,
          defaultValue: true,
        ) ??
        true;
    update();
  }

  void changeTheme() {
    isLightTheme.value = !isLightTheme.value;
    Get.changeThemeMode(isLightTheme.value ? ThemeMode.light : ThemeMode.dark);
    _saveThemeStatus();
    update();
  }
}
