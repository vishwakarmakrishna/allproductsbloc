import 'package:access/app/const/constant.dart';
import 'package:access/app/router/allroutes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseManager {
  static SupabaseClient get client => SupabaseClient(
        AppConstant.supabaseUrl,
        AppConstant.supabaseKey,
      );

  static Future<AuthResponse?> signUpUser(
      {required String name,
      required String email,
      required String password}) async {
    try {
      final result = await client.auth.signUp(email: email, password: password);

      if (result.user != null) {
        await createUser(
          name: name,
          email: email,
          password: password,
          uuid: result.user!.id,
        );
        return result;
      } else {
        Get.snackbar(
          "Error",
          'User creation failed',
          snackPosition: SnackPosition.BOTTOM,
        );
        return result;
      }
    } on AuthException catch (e) {
      Get.snackbar(
        'Error: ${e.statusCode}',
        e.message.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
      return null;
    } catch (e) {
      Get.snackbar(
        'Error: ${e.toString()}',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
      return null;
    } finally {
      //ToDo Code to run regardless of success or failure...
    }
  }

  static Future<AuthResponse?> signInUser(
      {required String email, required String password}) async {
    try {
      final result = await client.auth
          .signInWithPassword(email: email, password: password);

      if (result.user != null) {
        Get.snackbar(
          "Success",
          "User logged in successfully\n${result.user!.toJson()}",
          snackPosition: SnackPosition.BOTTOM,
        );

        return result;
      } else {
        Get.snackbar(
          "Error",
          'User login failed',
          snackPosition: SnackPosition.BOTTOM,
        );
        return result;
      }
    } on AuthException catch (e) {
      Get.snackbar(
        'Error: ${e.statusCode}',
        e.message.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
      return null;
    } catch (e) {
      Get.snackbar(
        'Error: ${e.toString()}',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
      return null;
    }
  }

  static Future<void> logout() async {
    try {
      await client.auth.signOut();
      Get.offAllNamed(LoginView.routeName);
    } on AuthException catch (e) {
      Get.snackbar(
        'Error: ${e.statusCode}',
        e.message.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        'Error: ${e.toString()}',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  static Future<bool> resetPassword({required String email}) async {
    try {
      await client.auth.resetPasswordForEmail(email);
      // debugPrint(result.toJson().toString());
      Get.snackbar(
        "Success",
        "Password reset link sent to your email",
        snackPosition: SnackPosition.BOTTOM,
      );
      return true;
    } on AuthException catch (e) {
      Get.snackbar(
        'Error: ${e.statusCode}',
        e.message.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    } catch (e) {
      Get.snackbar(
        'Error: ${e.toString()}',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
  }

  // Create a new user in the users table

  static Future<void> createUser(
      {required String uuid,
      required String name,
      required String email,
      required String password}) async {
    try {
      final result = await client.from(AppConstant.usersTableName).insert({
        'name': name,
        'email': email,
        'password': password,
      });
      debugPrint(result?.data.toString());
      Get.snackbar(
        "Success",
        "User created successfully",
        snackPosition: SnackPosition.BOTTOM,
      );
    } on PostgrestException catch (e) {
      Get.snackbar(
        'Error: ${e.code}',
        e.message.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        'Error: ${e.toString()}',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // Get all users from the users table

  static Future<dynamic> getUsers() async {
    try {
      final result = await client.from(AppConstant.usersTableName).select();
      debugPrint(result.toString());
      // Get.snackbar(
      //   "Success",
      //   "Users fetched successfully",
      //   snackPosition: SnackPosition.BOTTOM,
      // );
      return result;
    } on PostgrestException catch (e) {
      Get.snackbar(
        'Error: ${e.code}',
        e.message.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
      return null;
    }
  }

  // Get a user from the users table

  static Future<dynamic> getUser({required String email}) async {
    try {
      final result = await client
          .from(AppConstant.usersTableName)
          .select()
          .eq('email', email)
          .single();
      debugPrint(result.toString());
      // Get.snackbar(
      //   "Success",
      //   "User fetched successfully",
      //   snackPosition: SnackPosition.BOTTOM,
      // );
      return result;
    } on PostgrestException catch (e) {
      Get.snackbar(
        'Error: ${e.code}',
        e.message.toString(),
        snackPosition: SnackPosition.BOTTOM,
      );
      return null;
    }
  }
}
