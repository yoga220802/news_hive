// widgets/custom_input_field.dart
import 'package:flutter/material.dart';
import 'package:news_hive/utils/helper.dart';

class AuthFormWidget extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String hintText;
  final TextInputType keyboardType;
  final bool obscureText;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;

  const AuthFormWidget({
    super.key,
    required this.label,
    required this.controller,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.suffixIcon,
    this.validator,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
                text: ' $label',
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
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          validator: validator,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hintText,
            enabledBorder: enabledBorder,
            focusedBorder: focusBorder,
            errorBorder: errorBorder,
            focusedErrorBorder: focusedErrorBorder,
            suffixIcon: suffixIcon,
          ),
        ),
      ],
    );
  }
}
