import 'package:flutter/material.dart';
import 'package:fuelprice/helper/colors_helper.dart';
import 'package:fuelprice/widgets/calculadora/controller/calculadora_controller.dart';

class CalculadoraActions extends StatelessWidget {
  final CalculadoraController controller;

  final TextEditingController etanolController;
  final TextEditingController gasolinaController;
  final TextEditingController valorController;

  final VoidCallback onUpdate;

  const CalculadoraActions({
    super.key,
    required this.controller,
    required this.etanolController,
    required this.gasolinaController,
    required this.valorController,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () => controller.calcular(
              etanolText: etanolController.text,
              gasolinaText: gasolinaController.text,
              valorText: valorController.text,
              onUpdate: onUpdate,
              context: context,
            ),
            icon: const Icon(
              Icons.calculate,
              color: Colors.white,
            ),
            label: const Text(
              "Calcular",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
            ),
          ),
        ),

        const SizedBox(width: 10),

        Expanded(
          child: ElevatedButton.icon(
            onPressed: () => controller.limpar(
              etanolController: etanolController,
              gasolinaController: gasolinaController,
              valorController: valorController,
              onUpdate: onUpdate,
            ),
            icon: const Icon(
              Icons.clear,
              color: Colors.white,
            ),
            label: const Text(
              "Limpar",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.appMainColor,
            ),
          ),
        ),
      ],
    );
  }
}