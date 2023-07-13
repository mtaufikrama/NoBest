import 'package:flutter/material.dart';
import 'package:nobes/app/data/services/colors.dart';
import 'package:nobes/app/data/services/font.dart';
import 'package:nobes/app/data/services/translate.dart';

class FormProfile extends StatelessWidget {
  const FormProfile(
      {required this.label,
      required this.controller,
      required this.keyboardType,
      this.autofocus,
      super.key});
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String label;
  final bool? autofocus;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 10,
      ),
      child: TextFormField(
        controller: controller,
        autofocus: autofocus ?? false,
        keyboardType: keyboardType,
        style: Font.regular(),
        decoration: InputDecoration(
          label: teksLanguage(
            label,
            style: Font.regular(
              color: Colors.grey,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              color: Warna.primary,
            ),
          ),
        ),
      ),
    );
  }
}
