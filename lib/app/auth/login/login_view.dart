import 'package:access/app/const/common_constant.dart';
import 'package:access/app/router/allroutes.dart';
import 'package:access/app/supabase/controller/supabase_controller.dart';
import 'package:access/extenstions/context.dart';
import 'package:access/theme/controller/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});
  static const String routeName = '/auth/login';

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  bool _isObscure = false;
  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  final supaController = Get.find<SupabaseController>();
  final themeController = Get.find<ThemeController>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text(
          'Welcome Guest!',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
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
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(size.height * 0.2),
          child: Lottie.network(
            NetworkImageAssets.login,
            height: size.height * 0.2,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: TextFormField(
                  controller: _emailController,
                  autofocus: false,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    prefixIcon: Icon(Icons.email),
                    hintText: 'Email',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter valid email';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: TextFormField(
                  autofocus: false,
                  obscureText: _isObscure,
                  controller: _passwordController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    prefixIcon: const Icon(Icons.lock),
                    hintText: 'Password',
                    suffixIcon: IconButton(
                      onPressed: () {
                        _isObscure = !_isObscure;
                        setState(() {});
                      },
                      icon: Icon(
                        _isObscure
                            ? Icons.remove_red_eye_outlined
                            : Icons.remove_red_eye,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter valid password';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 20),
              AnimatedContainer(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                duration: const Duration(milliseconds: 300),
                alignment: context.isKeyboardOpen
                    ? Alignment.centerLeft
                    : Alignment.center,
                child: TextButton(
                  onPressed: () => Get.toNamed(SignupView.routeName),
                  child: const Text('Not a member? Signup'),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: context.isKeyboardOpen
          ? FloatingActionButtonLocation.endFloat
          : FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ElevatedButton.icon(
        onPressed: () async {
          if (!(_formKey.currentState?.validate() ?? false)) {
            return;
          }
          await supaController.signIn(
            _emailController.text,
            _passwordController.text,
          );
        },
        icon: const Icon(Icons.login),
        label: const Text('Login'),
      ),
    );
  }
}
