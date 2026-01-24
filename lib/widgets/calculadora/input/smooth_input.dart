import 'package:flutter/material.dart';
import 'package:fuelprice/helper/colors_helper.dart';

Widget smoothInput({
  required TextEditingController controller,
  FocusNode? focusNode,
  required String label,
}) {
  return TextField(
    controller: controller,
    focusNode: focusNode,
    keyboardType: TextInputType.number,
    style: const TextStyle(fontSize: 16),
    decoration: InputDecoration(
      labelText: label,
      filled: true,
      fillColor: Colors.white,

      /// Borda normal
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),

      /// Quando focado
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(
          color: AppColors.primary,
          width: 2,
        ),
      ),

      /// Label flutuante mais suave
      floatingLabelStyle: TextStyle(
        color: AppColors.primary,
        fontWeight: FontWeight.w600,
      ),

      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 18,
      ),
    ),
  );
}
