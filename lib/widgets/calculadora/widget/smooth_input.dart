import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fuelprice/helper/colors_helper.dart';

Widget smoothInput({
  required TextEditingController controller,
  FocusNode? focusNode,
  required String label,
  required List<TextInputFormatter> inputFormatters,
}) {
  return TextField(
    controller: controller,
    focusNode: focusNode,
    keyboardType: TextInputType.number,
    inputFormatters: inputFormatters,

    style: const TextStyle(fontSize: 16),
    decoration: InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.white,

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(color: AppColors.primary, width: 2),
      ),

      floatingLabelStyle: TextStyle(
        color: AppColors.primary,
        fontWeight: FontWeight.w600,
      ),

      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
    ),
  );
}
