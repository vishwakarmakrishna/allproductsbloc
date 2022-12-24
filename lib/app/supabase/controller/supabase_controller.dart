import 'dart:convert';

import 'package:access/app/const/constant.dart';
import 'package:access/app/dashboard/views/dashboard_view.dart';
import 'package:access/app/supabase/manager/supabase_client.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseController extends GetxController {
  Rx<User?> user = Rx<User?>(null);

  _saveUserStatus(User? u) async {
    await Hive.box(AppConstant.local)
        .put(AppConstant.user, u == null ? null : jsonEncode(u.toJson()));
    user.value = u;
    update();
  }

  @override
  void onInit() async {
    super.onInit();
    getUserStatus();
  }

  void getUserStatus() {
    final results = Hive.box(AppConstant.local).get(AppConstant.user);
    if (results != null && results != '') {
      final res = jsonDecode(results.toString());
      user.value = User.fromJson(res);
    }

    update();
  }

  Future<void> signIn(String email, String password) async {
    final results =
        await SupabaseManager.signInUser(email: email, password: password);
    if (results != null && results.user != null) {
      try {
        _saveUserStatus(results.user);
        Get.offAllNamed(DashBoardView.routeName);
      } catch (e) {
        FlutterError.reportError(
          FlutterErrorDetails(
            exception: e,
            stack: StackTrace.current,
          ),
        );
      }
    }
  }

  Future<void> signUp(
      {required String name,
      required String email,
      required String password}) async {
    final results = await SupabaseManager.signUpUser(
        name: name, email: email, password: password);
    if (results != null && results.user != null) {
      try {
        _saveUserStatus(results.user);
        Get.offAllNamed(DashBoardView.routeName);
      } catch (e) {
        FlutterError.reportError(
          FlutterErrorDetails(
            exception: e,
            stack: StackTrace.current,
          ),
        );
      }
    }
  }

  Future<bool> forgetpassword(String email) async =>
      await SupabaseManager.resetPassword(email: email);

  Future<void> logout() async {
    _saveUserStatus(null);
    await SupabaseManager.logout();
  }

  Future<dynamic> getUsers() async {
    final results = await SupabaseManager.getUsers();
    return results;
  }

  Future<dynamic> getCurrentUser() async {
    final email = user.value?.email;
    if (email != null) {
      final results = await SupabaseManager.getUser(email: email);
      return results;
    }
  }
}
