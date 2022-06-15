import 'package:flutter/material.dart';

import '../../constants/constants.dart';

class WidgetInput extends StatelessWidget {
  const WidgetInput({
    Key? key,
    required this.controller,
    this.hintText,
    required this.labelText,
    this.validator,
    this.obscureText = false,
  }) : super(key: key);

  final TextEditingController controller;
  final String? hintText;
  final String labelText;
  final FormFieldValidator<String>? validator;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: obscureText,
      textAlign: TextAlign.left,
      style: AppTextStyles.normal,
      decoration: InputDecoration(
        hintStyle:
            AppTextStyles.normal.copyWith(color: Colors.grey.withOpacity(0.4)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        hintText: hintText ?? labelText,
        labelText: labelText,
      ),
    );
  }
}
