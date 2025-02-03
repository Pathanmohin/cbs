import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UsernameField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNodeUser;
  final FocusNode nextFocusNode;

  const UsernameField(
      {required this.controller,
      super.key,
      required this.focusNodeUser,
      required this.nextFocusNode});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'User ID',
          style: TextStyle(fontSize: 14),
        ),
        const SizedBox(height: 8),
        Builder(builder: (context) {
          return MediaQuery(
            data: MediaQuery.of(context)
                .copyWith(textScaler: const TextScaler.linear(1.1)),
            child: TextFormField(
              controller: controller,
              focusNode: focusNodeUser, // Add FocusNode here
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              decoration: InputDecoration(
                hintText: 'Enter User ID',
                prefixIcon: const Icon(Icons.person),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your user id';
                }
                return null;
              },

              onFieldSubmitted: (value) {
                FocusScope.of(context).requestFocus(nextFocusNode);
              },
            ),
          );
        })
      ],
    );
  }
}
