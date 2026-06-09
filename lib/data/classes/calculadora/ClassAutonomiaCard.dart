import 'package:flutter/material.dart';
import 'package:fuelprice/data/classes/calculadora/ClassResultadoCalculo.dart';
import 'package:fuelprice/widgets/calculadora/widget/bloco_widget.dart';

class AutonomiaCard extends StatelessWidget {
  final ResultadoCalculo resultado;

  const AutonomiaCard({
    super.key,
    required this.resultado,
  });

  @override
  Widget build(BuildContext context) {
    return BlocoCard(
      titulo:
          "Com o valor abastecido (R\$ ${resultado.valorAbastecido.toStringAsFixed(1)})",
      icone: Icons.directions_car,
      cor: Colors.orange[800],
      conteudo: [
        Text(
          "Etanol - Cidade: ${resultado.km.etanolCidade.toStringAsFixed(1)} km",
        ),
        Text(
          "Etanol - Estrada: ${resultado.km.etanolEstrada.toStringAsFixed(1)} km",
        ),
        Text(
          "Gasolina - Cidade: ${resultado.km.gasolinaCidade.toStringAsFixed(1)} km",
        ),
        Text(
          "Gasolina - Estrada: ${resultado.km.gasolinaEstrada.toStringAsFixed(1)} km",
        ),
      ],
    );
  }
}