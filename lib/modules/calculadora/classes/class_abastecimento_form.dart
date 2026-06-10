import 'package:flutter/material.dart';
import 'package:fuelprice/helper/currency_input_formatter.dart';
import 'package:fuelprice/modules/calculadora/widget/smooth_input.dart';

class AbastecimentoForm extends StatelessWidget {
  final TextEditingController etanolController;
  final TextEditingController gasolinaController;
  final TextEditingController valorController;
  final FocusNode focusEtanol;

  const AbastecimentoForm({
    super.key,
    required this.etanolController,
    required this.gasolinaController,
    required this.valorController,
    required this.focusEtanol,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        smoothInput(
          controller: etanolController,
          focusNode: focusEtanol,
          label: "Preço do Etanol (R\$)",
          inputFormatters: [CurrencyInputFormatter()],
        ),

        const SizedBox(height: 12),

        smoothInput(
          controller: gasolinaController,
          label: "Preço da Gasolina (R\$)",
          inputFormatters: [CurrencyInputFormatter()],
        ),

        const SizedBox(height: 12),

        smoothInput(
          controller: valorController,
          label: "Valor a abastecer (R\$)",
          inputFormatters: [CurrencyInputFormatter()],
        ),
      ],
    );
  }
}