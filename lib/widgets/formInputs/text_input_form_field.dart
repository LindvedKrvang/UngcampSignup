import 'package:flutter/material.dart';

class TextInputFormField extends StatelessWidget {

  final TextEditingController controller;
  final String label;
  final String? hint;

  TextInputFormField({required this.controller, required this.label, this.hint});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
          hintText: hint,
          labelText: label
      ),
      controller: controller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '$label er påkrævet';
        }
        return null;
      },
    );
  }
}
