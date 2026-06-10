import 'package:flutter/material.dart';
import 'package:fuelprice/helper/colors_helper.dart';

class FuelCompareCard extends StatelessWidget {
  final double alcoolPreco;
  final double gasolinaPreco;
  final double litrosTanque;

  const FuelCompareCard({
    super.key,
    required this.alcoolPreco,
    required this.gasolinaPreco,
    required this.litrosTanque,
  });

  @override
  Widget build(BuildContext context) {
    final relacao = alcoolPreco / gasolinaPreco;
    final etanolVencedor = relacao < 0.7;
    final gasolinaVencedor = !etanolVencedor;

    String formatMoney(double valor) {
      return valor.toStringAsFixed(2).replaceAll('.', ',');
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            final fontSize = constraints.maxWidth * 0.08;
            return Text(
              "Melhor Combustível",
              style: TextStyle(
                fontSize: fontSize.clamp(16.0, 22.0),
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            _card(
              titulo: "Etanol",
              preco: alcoolPreco,
              destaque: etanolVencedor,
              icone: Icons.local_gas_station,
              cor: etanolVencedor ? AppColors.primary : AppColors.appMainColor,
              proximo: "R\$ ${formatMoney(litrosTanque * alcoolPreco)}",
            ),
            const SizedBox(width: 12),
            _card(
              titulo: "Gasolina",
              preco: gasolinaPreco,
              destaque: gasolinaVencedor,
              icone: Icons.local_gas_station,
              cor: gasolinaVencedor
                  ? AppColors.primary
                  : AppColors.appMainColor,
              proximo: "R\$ ${formatMoney(litrosTanque * gasolinaPreco)}",
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
    required IconData icone,
    required Color cor,
    required String proximo,
  }) {
    String formatMoney(double valor) =>
        valor.toStringAsFixed(2).replaceAll('.', ',');

    return Expanded(
      child: LayoutBuilder(
        builder: (context, constraints) {
          // ⚡ Dinâmico: escala baseada na largura do card
          final cardWidth = constraints.maxWidth;
          final iconSize = cardWidth * 0.18; // ícone proporcional
          final titleFont = cardWidth * 0.12;
          final priceFont = cardWidth * 0.11;
          final labelFont = cardWidth * 0.09;
          final nextFont = cardWidth * 0.10;

          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [cor.withOpacity(0.25), cor.withOpacity(0.20)],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: iconSize / 2, // metade do tamanho do ícone
                        backgroundColor: AppColors.background,
                        child: Icon(icone, color: cor, size: iconSize),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          titulo,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: titleFont.clamp(12.0, 18.0),
                          ),
                        ),
                      ),
                      if (destaque)
                        Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: iconSize * 0.6,
                        ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: cor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      "R\$ ${formatMoney(preco)}/L",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: destaque ? Colors.white : Colors.black87,
                        fontSize: priceFont.clamp(14.0, 18.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "Próximo abastecimento completo:",
                    style: TextStyle(
                      fontSize: labelFont.clamp(12.0, 16.0),
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    proximo,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: nextFont.clamp(14.0, 18.0),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
