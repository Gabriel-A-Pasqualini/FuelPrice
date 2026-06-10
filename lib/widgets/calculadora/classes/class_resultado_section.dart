import 'package:flutter/material.dart';
import 'package:fuelprice/widgets/calculadora/classes/class_autonomia_card.dart';
import 'package:fuelprice/widgets/calculadora/classes/class_custo_km_card.dart';
import 'package:fuelprice/widgets/calculadora/classes/class_economia_card.dart';
import 'package:fuelprice/widgets/calculadora/classes/class_resultado_calculo.dart';
import 'package:fuelprice/widgets/calculadora/classes/class_resumo_geral_card.dart';
import 'package:fuelprice/widgets/calculadora/classes/class_rodape_calculadora.dart';

class ResultadoSection extends StatelessWidget {
  final bool calculado;
  final ResultadoCalculo? resultado;

  const ResultadoSection({
    super.key,
    required this.calculado,
    required this.resultado,
  });

  @override
  Widget build(BuildContext context) {

    if (!calculado || resultado == null) {
      return const SizedBox.shrink();
    }

    return Column(
      children: [
        ResumoGeralCard(resultado: resultado!),
        AutonomiaCard(resultado: resultado!),
        CustoKmCard(resultado: resultado!),
        EconomiaCard(resultado: resultado!),
        const RodapeCalculadora(),
      ],
    );
  }
}