import 'package:access/app/auth/views/views.dart';
import 'package:access/app/const/common_constant.dart';
import 'package:access/app/supabase/controller/supabase_controller.dart';
import 'package:access/theme/controller/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class ForgotView extends StatefulWidget {
  const ForgotView({super.key});
  static const String routeName = '/auth/forgot';

  @override
  State<ForgotView> createState() => _ForgotViewState();
}

class _ForgotViewState extends State<ForgotView> {
  late TextEditingController emailController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
  }

  final _formKey = GlobalKey<FormState>();
  final supaController = Get.find<SupabaseController>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Form(
      key: _formKey,
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: false,
          title: const Text('Forgot Password?'),
          actions: [
            GetBuilder<ThemeController>(
              builder: (themeController) => IconButton(
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

        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          onPressed: () async {
            if (!(_formKey.currentState?.validate() ?? false)) {
              return;
            }

            bool isSendMail =
                await supaController.forgetpassword(emailController.text);
            if (isSendMail) {
              Get.offNamedUntil(LoginView.routeName, (route) => false);
            }
          },
          child: const Text('Send'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: TextFormField(
                controller: emailController,
                autovalidateMode: AutovalidateMode.onUserInteraction,
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
          ],
        ),
      ),
    );
  }
}
