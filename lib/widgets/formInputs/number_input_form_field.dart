import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NumberInputFormField extends StatelessWidget {

  final TextEditingController controller;
  final String label;
  final String? hint;

  NumberInputFormField({required this.controller, required this.label, this.hint});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        hintText: hint,
        labelText: label,
      ),
      controller: controller,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly
      ],
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '$label er påkrævet';
        }
        return null;
      },
    );
  }
}
