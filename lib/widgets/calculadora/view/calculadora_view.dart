import 'package:fuelprice/widgets/calculadora/controller/calculadora_controller.dart';
import 'package:flutter/material.dart';
import 'package:fuelprice/helper/colors_helper.dart';

class CalculadoraCombustivelWidget extends StatefulWidget {
  const CalculadoraCombustivelWidget({super.key});

  @override
  State<CalculadoraCombustivelWidget> createState() =>
      _CalculadoraCombustivelWidgetState();
}

class _CalculadoraCombustivelWidgetState
    extends State<CalculadoraCombustivelWidget> {
  final controller = CalculadoraController();

  final _etanolController = TextEditingController();
  final _gasolinaController = TextEditingController();
  final _valorAbastecerController = TextEditingController();
  final _focusEtanol = FocusNode();

  final appColor = AppColors.appMainColor;

  void _atualizarUI() {
    if (mounted) setState(() {});
  }

  Widget cardTitulo(String titulo, IconData icone, {Color? cor}) {
    return Row(
      children: [
        Icon(icone, color: cor ?? appColor),
        const SizedBox(width: 8),
        Text(
          titulo,
          style: TextStyle(
            color: cor ?? appColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget bloco(String titulo, List<Widget> conteudo, IconData icone,
      {Color? cor}) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(13.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            cardTitulo(titulo, icone, cor: cor),
            const SizedBox(height: 5),
            ...conteudo
          ],
        ),
      ),
    );
  }

  Widget rodapeBonito() {
    return Column(
      children: [
        const SizedBox(height: 12),
        Divider(color: Colors.grey[400], thickness: 1.2),
        const SizedBox(height: 8),
        Text(
          "🚗 Cálculos baseados no consumo médio do HB20 1.0",
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey[700],
            fontStyle: FontStyle.italic,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Calculadora de Abastecimento",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: appColor,
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double fontSize = constraints.maxWidth * 0.04;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height,
              ),
              child: IntrinsicHeight(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Campos de entrada
                    TextField(
                      controller: _etanolController,
                      focusNode: _focusEtanol,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        labelText: "Preço do Etanol (R\$)",
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _gasolinaController,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        labelText: "Preço da Gasolina (R\$)",
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _valorAbastecerController,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        labelText: "Valor a abastecer (R\$)",
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 20),

                    // Botões
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () => controller.calcular(
                              etanolText: _etanolController.text,
                              gasolinaText: _gasolinaController.text,
                              valorText: _valorAbastecerController.text,
                              onUpdate: _atualizarUI,
                              context: context,
                            ),
                            icon: const Icon(
                              Icons.calculate,
                              color: Colors.white,
                            ),
                            label: Text(
                              "Calcular",
                              style: TextStyle(
                                fontWeight: FontWeight.bold, 
                                fontSize: fontSize,
                                color: Colors.white
                              ),                            
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: appColor,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () => controller.limpar(
                              etanolController: _etanolController,
                              gasolinaController: _gasolinaController,
                              valorController: _valorAbastecerController,
                              onUpdate: _atualizarUI,
                            ),
                            icon: const Icon(
                              Icons.clear,
                              color: Colors.white,
                            ),
                            label: Text(
                              "Limpar",
                              style: TextStyle(
                                fontWeight: FontWeight.bold, 
                                fontSize: fontSize,
                                color: Colors.white
                              ),                              
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red[700],
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Resultados
                    if (controller.calculado && controller.resultado != null) ...[
                      bloco(
                        "Resumo Geral",
                        [
                          Text(
                              "Relação Etanol/Gasolina: ${controller.resultado!['relacao'].toStringAsFixed(2)}"),
                          Text.rich(
                            TextSpan(
                              text: "Melhor pela regra do 0.7: ",
                              children: [
                                TextSpan(
                                  text: controller.resultado!['melhor'],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green),
                                ),
                              ],
                            ),
                          ),
                        ],
                        Icons.local_gas_station,
                        cor: appColor,
                      ),
                      bloco(
                        "Com o valor abastecido (R\$ ${controller.resultado!['valor'].toStringAsFixed(2)})",
                        [
                          Text(
                              "Etanol - Cidade: ${controller.resultado!['km']['etanolCidade'].toStringAsFixed(1)} km"),
                          Text(
                              "Etanol - Estrada: ${controller.resultado!['km']['etanolEstrada'].toStringAsFixed(1)} km"),
                          Text(
                              "Gasolina - Cidade: ${controller.resultado!['km']['gasolinaCidade'].toStringAsFixed(1)} km"),
                          Text(
                              "Gasolina - Estrada: ${controller.resultado!['km']['gasolinaEstrada'].toStringAsFixed(1)} km"),
                        ],
                        Icons.directions_car,
                        cor: Colors.orange[800],
                      ),
                      bloco(
                        "Custo por KM",
                        [
                          Text(
                              "Etanol - Cidade: R\$ ${controller.resultado!['custoKm']['etanolCidade'].toStringAsFixed(2)}"),
                          Text(
                              "Etanol - Estrada: R\$ ${controller.resultado!['custoKm']['etanolEstrada'].toStringAsFixed(2)}"),
                          Text(
                              "Gasolina - Cidade: R\$ ${controller.resultado!['custoKm']['gasolinaCidade'].toStringAsFixed(2)}"),
                          Text(
                              "Gasolina - Estrada: R\$ ${controller.resultado!['custoKm']['gasolinaEstrada'].toStringAsFixed(2)}"),
                        ],
                        Icons.speed,
                        cor: Colors.blue[800],
                      ),
                      bloco(
                        "Km com TANQUE CHEIO (50L)",
                        [
                          Text(
                              "Etanol - Cidade: ${controller.resultado!['tanque']['etanolCidade'].toStringAsFixed(1)} km"),
                          Text(
                              "Etanol - Estrada: ${controller.resultado!['tanque']['etanolEstrada'].toStringAsFixed(1)} km"),
                          Text(
                              "Gasolina - Cidade: ${controller.resultado!['tanque']['gasolinaCidade'].toStringAsFixed(1)} km"),
                          Text(
                              "Gasolina - Estrada: ${controller.resultado!['tanque']['gasolinaEstrada'].toStringAsFixed(1)} km"),
                        ],
                        Icons.local_taxi,
                        cor: Colors.teal[800],
                      ),
                      bloco(
                        "Economia no valor abastecido",
                        [
                          Text(
                              "Cidade: ${controller.resultado!['economia']['cidadeKm'].toStringAsFixed(1)} km → "
                              "R\$ ${controller.resultado!['economia']['cidadeR'].toStringAsFixed(2)}"),
                          Text(
                              "Estrada: ${controller.resultado!['economia']['estradaKm'].toStringAsFixed(1)} km → "
                              "R\$ ${controller.resultado!['economia']['estradaR'].toStringAsFixed(2)}"),
                        ],
                        Icons.savings,
                        cor: Colors.purple[800],
                      ),
                      rodapeBonito(),
                    ],
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
