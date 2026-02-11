import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/utils.dart';
import 'package:health_camps/data/services/api_client.dart';
//import 'package:health_camps/data/services/test_health_apis.dart';
import 'package:health_camps/modules/auth/auth_controller.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});
  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final AuthController authController = Get.put(AuthController());

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool rememberMe = false;
  bool obscurePassword = true;

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _testHealthApi();
  }

  void _testHealthApi() async {
    try {
      final response = await ApiClient.instance.get('/');
      debugPrint('Health API Success: ${response.data}');
    } catch (e) {
      debugPrint('Health API Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final enabledBorder = const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.deepPurple),
    );

    final focusedBorder = const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.deepPurple, width: 2),
    );

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Health Camps Login',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),

                // widgets go here
                TextField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    labelStyle: const TextStyle(),
                    enabledBorder: enabledBorder,
                    focusedBorder: focusedBorder,
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: passwordController,
                  obscureText: obscurePassword,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    enabledBorder: enabledBorder,
                    focusedBorder: focusedBorder,
                    suffixIcon: IconButton(
                      icon: Icon(
                        obscurePassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          obscurePassword = !obscurePassword;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                CheckboxListTile(
                  value: rememberMe,
                  onChanged: (value) {
                    setState(() {
                      rememberMe = value ?? false;
                    });
                  },
                  title: const Text('Remember me'),
                  controlAffinity: ListTileControlAffinity.leading,
                ),

                const SizedBox(height: 16),
                SizedBox(
                  width: Get.width * 0.5,
                  child: Obx(() {
                    final isLoading = authController.isLoading.value;

                    return ElevatedButton(
                      onPressed: isLoading
                          ? null
                          : () {
                              final username = usernameController.text.trim();
                              final password = passwordController.text.trim();

                              if (username.isEmpty || password.isEmpty) {
                                Get.snackbar(
                                  'Error',
                                  'Username and Password cannot be empty',
                                  snackPosition: SnackPosition.BOTTOM,
                                );
                                return;
                              }
                              authController.login(
                                username: username,
                                password: password,
                              );
                            },
                      child: isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Text('Login'),
                    );
                  }),
                ),

                //     width: 100,
                //     child: Obx(() {
                //       return authController.isLoading.value
                //           ? const CircularProgressIndicator(
                //               constraints: BoxConstraints.tightFor(
                //                 width: 50,
                //                 height: 50,
                //               ),
                //             )
                //           : ElevatedButton(
                //               onPressed: () {
                //                 // TestHealthApi.showHealthDialog(context);
                //                 authController.login(
                //                   username: usernameController.text.trim(),
                //                   password: passwordController.text.trim(),
                //                 );
                //               },
                //               child: const Text('Login'),
                //             );
                //     }),
                //   ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
