import 'package:flutter/material.dart';
import 'package:fuelprice/widgets/calculadora/classes/ClassAutonomiaCard.dart';
import 'package:fuelprice/widgets/calculadora/classes/ClassCustoKmCard.dart';
import 'package:fuelprice/widgets/calculadora/classes/ClassEconomiaCard.dart';
import 'package:fuelprice/widgets/calculadora/classes/ClassResultadoCalculo.dart';
import 'package:fuelprice/widgets/calculadora/classes/ClassResumoGeralCard.dart';
import 'package:fuelprice/widgets/calculadora/classes/ClassRodapeCalculadora.dart';

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