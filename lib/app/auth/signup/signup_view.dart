import 'package:access/app/const/common_constant.dart';
import 'package:access/app/supabase/controller/supabase_controller.dart';
import 'package:access/extenstions/context.dart';
import 'package:access/theme/controller/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});
  static const String routeName = '/auth/signup';

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  bool _isObscure = false;
  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _nameController = TextEditingController();
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
          'Please Sign Up',
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
            NetworkImageAssets.signup,
            height: size.height * 0.2,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: TextFormField(
                  autofocus: false,
                  controller: _nameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    prefixIcon: Icon(Icons.person),
                    hintText: 'Name',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter valid name';
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
                  controller: _emailController,
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
                  child: const Text('Already have an account? Login'),
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
      floatingActionButton: ElevatedButton(
        onPressed: () async {
          if (!(_formKey.currentState?.validate() ?? false)) {
            return;
          }
          await supaController.signUp(
            email: _emailController.text,
            password: _passwordController.text,
            name: _nameController.text,
          );
        },
        child: const Text('Sign Up'),
      ),
    );
  }
}
