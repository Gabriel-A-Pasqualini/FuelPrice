import 'package:flutter/material.dart';

class VeiculoController {
  // Controllers dos campos do formulário
  final nomeController = TextEditingController();
  final litrosController = TextEditingController();
  final gasolinaCidadeController = TextEditingController();
  final gasolinaEstradaController = TextEditingController();
  final etanolCidadeController = TextEditingController();
  final etanolEstradaController = TextEditingController();

  // FormKey para validação
  final formKey = GlobalKey<FormState>();

  void salvar(BuildContext context) {
    if (!formKey.currentState!.validate()) return;

    final nome = nomeController.text;
    final litros = double.parse(litrosController.text);
    final gasolinaCidade = double.parse(gasolinaCidadeController.text);
    final gasolinaEstrada = double.parse(gasolinaEstradaController.text);
    final etanolCidade = double.parse(etanolCidadeController.text);
    final etanolEstrada = double.parse(etanolEstradaController.text);

    // Aqui você pode salvar, enviar para API, ou fazer o cálculo
    debugPrint('🚗 Veículo salvo:');
    debugPrint('Nome: $nome');
    debugPrint('Tanque: $litros L');
    debugPrint(
        'Gasolina (Cidade/Estrada): $gasolinaCidade / $gasolinaEstrada');
    debugPrint('Etanol (Cidade/Estrada): $etanolCidade / $etanolEstrada');

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Veículo '$nome' salvo com sucesso!")),
    );
  }

  void dispose() {
    nomeController.dispose();
    litrosController.dispose();
    gasolinaCidadeController.dispose();
    gasolinaEstradaController.dispose();
    etanolCidadeController.dispose();
    etanolEstradaController.dispose();
  }
}
