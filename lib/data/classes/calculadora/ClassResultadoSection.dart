import 'package:flutter/material.dart';
import 'package:fuelprice/data/classes/calculadora/ClassAutonomiaCard.dart';
import 'package:fuelprice/data/classes/calculadora/ClassCustoKmCard.dart';
import 'package:fuelprice/data/classes/calculadora/ClassEconomiaCard.dart';
import 'package:fuelprice/data/classes/calculadora/ClassResultadoCalculo.dart';
import 'package:fuelprice/data/classes/calculadora/ClassResumoGeralCard.dart';
import 'package:fuelprice/data/classes/calculadora/ClassRodapeCalculadora.dart';

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