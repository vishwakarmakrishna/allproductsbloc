import 'package:access/app/supabase/controller/supabase_controller.dart';

import 'package:access/theme/controller/theme_controller.dart';
import 'package:access/view/products_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashBoardView extends StatefulWidget {
  const DashBoardView({Key? key}) : super(key: key);
  static const String routeName = '/dashboard';

  @override
  State<DashBoardView> createState() => _DashBoardViewState();
}

class _DashBoardViewState extends State<DashBoardView> {
  final themeController = Get.find<ThemeController>();
  final supabaseController = Get.find<SupabaseController>();
  @override
  void initState() {
    super.initState();
    supabaseController.getUsers();
    supabaseController.getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: GetBuilder<SupabaseController>(
          builder: (_) => _.user.value == null
              ? const Text('No user')
              : Text(
                  'Welcome\n${_.user.value?.email}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
        ),
        actions: [
          Obx(
            () => IconButton(
              onPressed: themeController.changeTheme,
              icon: Icon(themeController.isLightTheme.value
                  ? Icons.lightbulb
                  : Icons.lightbulb_outline),
            ),
          ),
          IconButton(
            onPressed: supabaseController.logout,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: const ProductsScreen(),
    );
  }
}
