import 'package:flutter/material.dart';
import 'package:fuelprice/helper/colors_helper.dart';

class FuelSummaryCard extends StatelessWidget {
  final int diasRestantes;
  final double estimativa;

  const FuelSummaryCard({
    super.key,
    required this.diasRestantes,
    required this.estimativa,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        leading: const Icon(Icons.local_gas_station),
        title: Text(
          "Faltam $diasRestantes dias para abastecer",
          style: TextStyle(
            fontSize: 17, 
            fontWeight: FontWeight.bold,
            color: diasRestantes <= 1
                ? Colors.red
                : diasRestantes <= 3
                    ? Colors.orange
                    : Colors.green,
                        
          ),
        ),
        subtitle: Text(
          "Estimativa: R\$ ${estimativa.toStringAsFixed(2)}",
          style: TextStyle(
            color: AppColors.primary,
            fontSize: 15, 
            fontWeight: FontWeight.bold,            
          ),
        ),
      ),
    );
  }
}
