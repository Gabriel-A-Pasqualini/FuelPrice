import 'package:flutter/material.dart';
import 'package:fuelprice/widgets/calculadora/classes/ClassResultadoCalculo.dart';
import 'package:fuelprice/widgets/calculadora/widget/bloco_widget.dart';

class CustoKmCard extends StatelessWidget {
  final ResultadoCalculo resultado;

  const CustoKmCard({
    super.key,
    required this.resultado,
  });

  @override
  Widget build(BuildContext context) {
    return BlocoCard(
      titulo: "Custo por KM",
      icone: Icons.speed,
      cor: Colors.blue[800],
      conteudo: [
        Text(
          "Etanol - Cidade: R\$ ${resultado.custoKm.etanolCidade.toStringAsFixed(2)}",
        ),
        Text(
          "Etanol - Estrada: R\$ ${resultado.custoKm.etanolEstrada.toStringAsFixed(2)}",
        ),
        Text(
          "Gasolina - Cidade: R\$ ${resultado.custoKm.gasolinaCidade.toStringAsFixed(2)}",
        ),
        Text(
          "Gasolina - Estrada: R\$ ${resultado.custoKm.gasolinaEstrada.toStringAsFixed(2)}",
        ),
      ],
    );
  }
}