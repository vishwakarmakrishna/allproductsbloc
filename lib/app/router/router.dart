import 'package:access/app/auth/views/views.dart';
import 'package:access/app/dashboard/views/dashboard_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyRouter {
  static String initialRoute(bool value) =>
      value ? DashBoardView.routeName : LoginView.routeName;
  static GetPage unknownRoute = GetPage(
      name: '/notfound',
      page: () {
        return Scaffold(
          body: Center(
            child: Text('No route defined for ${Get.currentRoute}'),
          ),
        );
      });

  static List<GetPage<dynamic>>? getPages = [
    GetPage(
      name: DashBoardView.routeName,
      page: () => const DashBoardView(),
    ),
    GetPage(
      name: LoginView.routeName,
      page: () => const LoginView(),
    ),
    GetPage(
      name: SignupView.routeName,
      page: () => const SignupView(),
    ),
    GetPage(
      name: ForgotView.routeName,
      page: () => const ForgotView(),
    ),
  ];
}
