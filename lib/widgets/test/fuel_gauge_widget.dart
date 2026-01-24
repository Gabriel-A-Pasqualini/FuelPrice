import 'package:flutter/material.dart';
import 'package:fuelprice/helper/colors_helper.dart';

class FuelGaugeWidget extends StatelessWidget {
  final double nivel;
  final String modeloCarro;
  final int porcentagemTanque;

  const FuelGaugeWidget({
    super.key,
    required this.nivel,
    required this.modeloCarro, 
    required this.porcentagemTanque,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)
      ),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            //Image.asset(
            //  'assets/images/carro.png',
            //  height: 120,
            //),
            const SizedBox(height: 10),
            Text(
              modeloCarro,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18
              ),
            ),
            const SizedBox(height: 16),
            LinearProgressIndicator(
              value: nivel,
              minHeight: 16,
              borderRadius: BorderRadius.circular(10),
              backgroundColor: Colors.grey.shade300,
              valueColor: AlwaysStoppedAnimation(AppColors.primary),
            ),
            const SizedBox(height: 8),
            Text("Tanque: ${(nivel * 100).toInt()}%",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: porcentagemTanque <= 10
                    ? Colors.red
                    : porcentagemTanque <= 30
                        ? Colors.orange
                        : Colors.green,                
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
