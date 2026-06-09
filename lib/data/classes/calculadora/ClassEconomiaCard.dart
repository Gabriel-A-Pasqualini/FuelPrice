import 'package:flutter/material.dart';
import 'package:fuelprice/data/classes/calculadora/ClassResultadoCalculo.dart';
import 'package:fuelprice/widgets/calculadora/widget/bloco_widget.dart';

class EconomiaCard extends StatelessWidget {
  final ResultadoCalculo resultado;

  const EconomiaCard({
    super.key,
    required this.resultado,
  });

  @override
  Widget build(BuildContext context) {
    return BlocoCard(
      titulo: "Economia no valor abastecido",
      icone: Icons.savings,
      cor: Colors.purple[800],
      conteudo: [
        Text(
          "Cidade: ${resultado.economia.cidadeKm.toStringAsFixed(1)} km → "
          "R\$ ${resultado.economia.cidadeReais.toStringAsFixed(2)}",
        ),
        Text(
          "Estrada: ${resultado.economia.estradaKm.toStringAsFixed(1)} km → "
          "R\$ ${resultado.economia.estradaReais.toStringAsFixed(2)}",
        ),
      ],
    );
  }
}