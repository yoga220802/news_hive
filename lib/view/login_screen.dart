// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:news_hive/view/home_screen.dart';
import 'package:news_hive/view/register_screen.dart';
import 'package:news_hive/utils/helper.dart';
import 'package:news_hive/widgets/auth_form_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool obscureText = true;
  String? errorMessage;

  final String dummyEmail = "udin@example.com";
  final String dummyPassword = "1234";

  bool isEmailInvalid = false;
  bool isPasswordInvalid = false;

  void handleLogin() {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final email = emailController.text.trim();
      final password = passwordController.text.trim();

      setState(() {
        if (email != dummyEmail || password != dummyPassword) {
          errorMessage = "Invalid email or password.";
          isEmailInvalid = true;
          isPasswordInvalid = true;
          _formKey.currentState!.validate();
        } else {
          errorMessage = null;
          isEmailInvalid = false;
          isPasswordInvalid = false;

          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              double opacity = 0.0;
              final controller = ValueNotifier<double>(0.0);

              // Mulai fade in
              Future.delayed(Duration.zero, () {
                controller.value = 1.0;
              });

              // Setelah 2 detik, fade out dan tutup
              Future.delayed(const Duration(seconds: 2), () async {
                controller.value = 0.0;
                await Future.delayed(const Duration(milliseconds: 500));
                Navigator.of(context).pop();

                // Pindah ke halaman HomeScreen
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              });

              return Dialog(
                backgroundColor: Colors.transparent,
                elevation: 0,
                child: ValueListenableBuilder<double>(
                  valueListenable: controller,
                  builder: (context, val, child) {
                    return AnimatedOpacity(
                      opacity: val,
                      duration: const Duration(milliseconds: 500),
                      child: Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: cPrimary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.check_circle_outline,
                              size: 80,
                              color: cWhite,
                            ),
                            vsMedium,
                            Text(
                              "Login Successful !",
                              style: poppinsStyle(
                                fontSize: tsSubtitle1,
                                fontWeight: fBold,
                                color: cTextWhite,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        }
      });
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          vsLarge,
                          SizedBox(
                            width: 150,
                            height: 120,
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Hello',
                                    style: poppinsStyle(
                                      fontSize: tsHeadLine1,
                                      fontWeight: fSemiBold,
                                      color: cBlack,
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' Again!',
                                    style: poppinsStyle(
                                      fontSize: tsHeadLine1,
                                      fontWeight: fSemiBold,
                                      color: cPrimary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          vsSmall,
                          Text(
                            'Welcome back you\'ve been missed',
                            style: poppinsStyle(
                              fontSize: tsSubtitle2,
                              fontWeight: fRegular,
                              color: cTextBlue,
                            ),
                          ),
                          vsXLarge,
                          AuthFormWidget(
                            label: 'Email',
                            controller: emailController,
                            hintText: 'Email',
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Email is required';
                              }
                              if (isEmailInvalid) {
                                return errorMessage;
                              }
                              return null;
                            },
                            onChanged: (_) {
                              if (isEmailInvalid) {
                                setState(() {
                                  isEmailInvalid = false;
                                });
                              }
                            },
                          ),
                          vsSmall,
                          AuthFormWidget(
                            label: 'Password',
                            controller: passwordController,
                            hintText: 'Password',
                            obscureText: obscureText,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Password is required';
                              }
                              if (isPasswordInvalid) {
                                return errorMessage;
                              }
                              return null;
                            },
                            onChanged: (_) {
                              if (isPasswordInvalid) {
                                setState(() {
                                  isPasswordInvalid = false;
                                });
                              }
                            },
                            suffixIcon: IconButton(
                              icon: Icon(
                                obscureText
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: cTextBlue,
                              ),
                              onPressed: () {
                                setState(() {
                                  obscureText = !obscureText;
                                });
                              },
                            ),
                          ),
                          vsMedium,
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () => (),
                              child: Text(
                                'Forgot Password?',
                                style: poppinsStyle(
                                  fontSize: tsSubtitle2,
                                  fontWeight: fRegular,
                                  color: cError,
                                ),
                              ),
                            ),
                          ),
                          const Spacer(), // Mengisi ruang kosong antara form dan tombol
                          vsLarge,
                          ElevatedButton(
                            onPressed: handleLogin,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: cPrimary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              minimumSize: const Size.fromHeight(50),
                            ),
                            child: Text(
                              'Login',
                              style: poppinsStyle(
                                fontSize: tsSubtitle1,
                                fontWeight: fSemiBold,
                                color: cTextWhite,
                              ),
                            ),
                          ),
                          hsSmall,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Don\'t have an account? ',
                                style: poppinsStyle(
                                  fontSize: tsSubtitle2,
                                  fontWeight: fRegular,
                                  color: cBlack,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) => const RegisterScreen(),
                                    ),
                                  );
                                },
                                child: Text(
                                  'Sign Up',
                                  style: poppinsStyle(
                                    fontSize: tsSubtitle2,
                                    fontWeight: fSemiBold,
                                    color: cGrey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
