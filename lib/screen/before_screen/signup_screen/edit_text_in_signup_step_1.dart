import 'package:flutter/material.dart';

class edit_text_in_signup_step_1 extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final VoidCallback event;
  const edit_text_in_signup_step_1({super.key, required this.controller, required this.hint, required this.event});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.grey, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey[600]), // Hint text color
      ),
      onChanged: (value) {
        event();
      },
      cursorColor: Colors.blue, // Cursor color
    );
  }
}
