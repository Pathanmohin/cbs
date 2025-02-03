import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PasswordField extends StatelessWidget {
  final TextEditingController controller;
  final bool passwordVisible;
  final VoidCallback togglePasswordVisibility;
  final FocusNode passFocusNode;

  const PasswordField({
    required this.controller,
    required this.passwordVisible,
    required this.togglePasswordVisibility,
    super.key,
    required this.passFocusNode,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Password',
          style: TextStyle(fontSize: 14),
        ),
        SizedBox(height: 8.sp),
        Builder(builder: (context) {
          return MediaQuery(
            data: MediaQuery.of(context)
                .copyWith(textScaler: const TextScaler.linear(1.1)),
            child: TextFormField(
              controller: controller,
              obscureText: passwordVisible,
              focusNode: passFocusNode,
              decoration: InputDecoration(
                hintText: 'Enter Password',
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: IconButton(
                  icon: Icon(
                    passwordVisible ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: togglePasswordVisibility,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.sp),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
            ),
          );
        }),
      ],
    );
  }
}
