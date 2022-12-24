import 'package:access/app/const/constant.dart';
import 'package:access/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/initial.dart';
import 'app/router/router.dart';
import 'app/supabase/controller/supabase_controller.dart';
import 'theme/controller/theme_controller.dart';

void main() async {
  await initServices();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ThemeController themeController = Get.put(
    ThemeController(),
    permanent: true,
  );

  @override
  void initState() {
    themeController.getThemeStatus();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SupabaseController>(
      init: SupabaseController(),
      builder: (controller) => GetMaterialApp(
        title: AppConstant.appName,
        getPages: MyRouter.getPages,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        unknownRoute: MyRouter.unknownRoute,
        initialRoute: MyRouter.initialRoute(controller.user.value != null),
        themeMode: themeController.isLightTheme.value
            ? ThemeMode.light
            : ThemeMode.dark,
        initialBinding: BindingsBuilder(
          () {
            BindingsBuilder.put(
              () => ThemeController(),
              permanent: true,
            );
            BindingsBuilder.put(
              () => SupabaseController(),
              permanent: true,
            );
          },
        ),
      ),
    );
  }
}
