import 'package:flutter/material.dart';
import 'package:fuelprice/helper/colors_helper.dart';

class FuelCompareCard extends StatelessWidget {
  const FuelCompareCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Melhor Combustível",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            _card(
              titulo: "Álcool",
              preco: 4.50,
              destaque: true,
            ),
            const SizedBox(width: 12),
            _card(
              titulo: "Gasolina",
              preco: 6.50,
              destaque: false,
            ),
          ],
        ),
      ],
    );
  }

  Widget _card({
    required String titulo,
    required double preco,
    required bool destaque,
  }) {
    return Expanded(
      child: Card(
        elevation: 0, // 🔥 remove sombra
        surfaceTintColor: Colors.transparent, // 🔥 remove película do Material 3
        color: destaque
            ? AppColors.primary
            : AppColors.appMainColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                titulo,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "R\$ ${preco.toStringAsFixed(2)}/L",
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 8),

              // ✅ ÍCONE SEMPRE EXISTE → altura igual
              Opacity(
                opacity: destaque ? 1 : 0,
                child: const Icon(
                  Icons.check_circle,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
