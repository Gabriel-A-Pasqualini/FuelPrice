import 'package:flutter/material.dart';
import 'package:fuelprice/widgets/calculadora/classes/class_resultado_calculo.dart';
import 'package:fuelprice/helper/app_colors.dart';
import 'package:fuelprice/widgets/calculadora/widget/bloco_widget.dart';

class ResumoGeralCard extends StatelessWidget {
  final ResultadoCalculo resultado;

  const ResumoGeralCard({
    super.key,
    required this.resultado,
  });

  @override
  Widget build(BuildContext context) {
    return BlocoCard(
      titulo: "Resumo Geral",
      icone: Icons.local_gas_station,
      cor: AppColors.primary,
      conteudo: [
        Text(
          "Relação Etanol/Gasolina: ${resultado.relacao.toStringAsFixed(2)}",
        ),
        Text.rich(
          TextSpan(
            text: "Melhor pela regra do 0.7: ",
            style: const TextStyle(fontSize: 18),
            children: [
              TextSpan(
                text: resultado.melhorCombustivel,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}