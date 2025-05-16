import 'package:flutter/material.dart';
import 'package:news_hive/view/utils/helper.dart';
import 'package:news_hive/view/widgets/auth_form_widget.dart';

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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: cSuccess,
          content: const Text("Registration successful!"),
          duration: const Duration(seconds: 3),
        ),
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
                                  Navigator.pushReplacementNamed(
                                    context,
                                    '/login',
                                  );
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
