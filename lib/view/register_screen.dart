// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:news_hive/utils/helper.dart';
import 'package:news_hive/view/home_screen.dart';
import 'package:news_hive/widgets/auth_form_widget.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool obscureText = true;

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void handleRegister() {
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          final controller = ValueNotifier<double>(0.0);

          // Fade in
          Future.delayed(Duration.zero, () {
            controller.value = 1.0;
          });

          // Fade out setelah 2 detik
          Future.delayed(const Duration(seconds: 2), () async {
            controller.value = 0.0;
            await Future.delayed(const Duration(milliseconds: 500));
            Navigator.of(context).pop(); // Close the dialog
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            ); // Navigate to HomeScreen
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
                          "Sign Up Successful !",
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
                            height: 60,
                            child: Text(
                              'Hello',
                              style: poppinsStyle(
                                fontSize: tsHeadLine1,
                                fontWeight: fBold,
                                color: cBlack,
                              ),
                            ),
                          ),
                          vsSmall,
                          Text(
                            'Signup to get started',
                            style: poppinsStyle(
                              fontSize: tsSubtitle2,
                              fontWeight: fRegular,
                              color: cTextBlue,
                            ),
                          ),
                          customvs(96),
                          AuthFormWidget(
                            label: 'Name',
                            controller: nameController,
                            hintText: 'Full Name',
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Name is required';
                              }
                              return null;
                            },
                          ),
                          vsSmall,
                          AuthFormWidget(
                            label: 'Phone Number',
                            controller: phoneController,
                            hintText: 'Phone Number',
                            keyboardType: TextInputType.phone,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Phone number is required';
                              }
                              return null;
                            },
                          ),
                          vsSmall,
                          AuthFormWidget(
                            label: 'Email',
                            controller: emailController,
                            hintText: 'Email',
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Email is required';
                              }
                              return null;
                            },
                          ),
                          vsSmall,
                          AuthFormWidget(
                            label: 'Password',
                            controller: passwordController,
                            hintText: 'Password',
                            obscureText: obscureText,
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
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Password is required';
                              }
                              return null;
                            },
                          ),
                          vsLarge,
                          ElevatedButton(
                            onPressed: handleRegister,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: cPrimary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              minimumSize: const Size.fromHeight(50),
                            ),
                            child: Text(
                              'Register',
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
                                'Already have an account? ',
                                style: poppinsStyle(
                                  fontSize: tsSubtitle2,
                                  fontWeight: fRegular,
                                  color: cBlack,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'Login',
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
