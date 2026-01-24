import 'package:flutter/material.dart';
import 'package:fuelprice/helper/colors_helper.dart';
class FuelCompareCard extends StatelessWidget {
  const FuelCompareCard({super.key});

  @override
  Widget build(BuildContext context) {
    // 🔹 Dados (depois você joga isso pra controller)
    final alcoolPreco = 4.50;
    final gasolinaPreco = 6.50;

    final alcoolVencedor = alcoolPreco < gasolinaPreco;
    final gasolinaVencedor = gasolinaPreco < alcoolPreco;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Melhor Combustível",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            _card(
              titulo: "Etanol",
              preco: alcoolPreco,
              destaque: alcoolVencedor,
              icone: Icons.local_gas_station,
              cor: alcoolVencedor
                  ? AppColors.primary
                  : AppColors.appMainColor,
              proximo: "R\$ 280",
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
              proximo: "R\$ 410",
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
  return Expanded(
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            cor.withOpacity(0.25),
            cor.withOpacity(0.20),
          ],
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
                  backgroundColor: AppColors.background,
                  child: Icon(icone, color: cor),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    titulo,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                if (destaque)
                  const Icon(Icons.check_circle, color: Colors.green),
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
                "R\$ ${preco.toStringAsFixed(2)}/L",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: destaque ? Colors.white : Colors.black87,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Próximo abastecimento:",
              style: TextStyle(
                fontSize: 14, 
                color: Colors.black54,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              proximo,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

}
