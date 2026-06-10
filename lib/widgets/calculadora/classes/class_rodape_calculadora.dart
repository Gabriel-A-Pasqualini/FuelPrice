import 'package:flutter/material.dart';

class RodapeCalculadora extends StatelessWidget {
  const RodapeCalculadora({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 12),

        Divider(
          color: Colors.grey,
          thickness: 1.2,
        ),

        const SizedBox(height: 8),

        const Text(
          "🚗 Cálculos baseados no veículo favorito cadastrado",
          textAlign: TextAlign.center,
        ),

        const SizedBox(height: 20),
      ],
    );
  }
}