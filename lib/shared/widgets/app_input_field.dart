import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final bool obscureText;
  final VoidCallback? toggleObscure;

  const InputField({
    super.key,
    required this.controller,
    required this.hint,
    this.obscureText = false,
    this.toggleObscure,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hint,
        suffixIcon: toggleObscure != null
            ? IconButton(
                icon: Icon(
                  obscureText ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: toggleObscure,
              )
            : null,
      ),
    );
  }
}
