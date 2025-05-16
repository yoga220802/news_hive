import 'package:flutter/material.dart';
import 'package:news_hive/view/utils/helper.dart';

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
          _formKey.currentState!.validate(); // Trigger ulang validator
        } else {
          errorMessage = null;
          isEmailInvalid = false;
          isPasswordInvalid = false;

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: cSuccess,
              content: const Text("Login successful!"),
              duration: const Duration(seconds: 3),
            ),
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
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: '*',
                                  style: poppinsStyle(
                                    fontSize: tsSubtitle2,
                                    fontWeight: fRegular,
                                    color: cRequired,
                                  ),
                                ),
                                TextSpan(
                                  text: ' Email',
                                  style: poppinsStyle(
                                    fontSize: tsSubtitle2,
                                    fontWeight: fRegular,
                                    color: cBlack,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          vsSuperTiny,
                          TextFormField(
                            controller: emailController,
                            onChanged: (_) {
                              if (isEmailInvalid) {
                                setState(() {
                                  isEmailInvalid = false;
                                });
                              }
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Email is required';
                              }
                              if (isEmailInvalid) {
                                return errorMessage;
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: 'Email',
                              enabledBorder: enabledBorder,
                              focusedBorder: focusBorder,
                              errorBorder: errorBorder,
                              focusedErrorBorder: focusedErrorBorder,
                            ),
                          ),
                          vsSmall,
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: ' *',
                                  style: poppinsStyle(
                                    fontSize: tsSubtitle2,
                                    fontWeight: fRegular,
                                    color: cRequired,
                                  ),
                                ),
                                TextSpan(
                                  text: ' Password',
                                  style: poppinsStyle(
                                    fontSize: tsSubtitle2,
                                    fontWeight: fRegular,
                                    color: cBlack,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          vsSuperTiny,
                          TextFormField(
                            controller: passwordController,
                            obscureText: obscureText,
                            onChanged: (_) {
                              if (isPasswordInvalid) {
                                setState(() {
                                  isPasswordInvalid = false;
                                });
                              }
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Password is required';
                              }
                              if (isPasswordInvalid) {
                                return errorMessage;
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: 'Password',
                              enabledBorder: enabledBorder,
                              focusedBorder: focusBorder,
                              errorBorder: errorBorder,
                              focusedErrorBorder: focusedErrorBorder,
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
                                  // Navigasi ke halaman SignUpScreen
                                  Navigator.pushReplacementNamed(
                                    context,
                                    '/signup',
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
