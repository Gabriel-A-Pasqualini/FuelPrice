import 'package:fuelprice/helper/currency_input_formatter.dart';
import 'package:fuelprice/widgets/calculadora/controller/calculadora_controller.dart';
import 'package:flutter/material.dart';
import 'package:fuelprice/helper/colors_helper.dart';
import 'package:fuelprice/widgets/calculadora/input/smooth_input.dart';
import 'package:fuelprice/widgets/calculadora/view/widget/bloco_widget.dart';
import 'package:fuelprice/widgets/index/view/widgets/header_widget.dart';

class CalculadoraCombustivelWidget extends StatefulWidget {
  const CalculadoraCombustivelWidget({super.key});

  @override
  State<CalculadoraCombustivelWidget> createState() =>
      CalculadoraCombustivelWidgetState();
}

class CalculadoraCombustivelWidgetState
    extends State<CalculadoraCombustivelWidget> {
  final controller = CalculadoraController();

  final _etanolController = TextEditingController();
  final _gasolinaController = TextEditingController();
  final _valorAbastecerController = TextEditingController();
  final _focusEtanol = FocusNode();

  final appColor = AppColors.appMainColor;

  @override
  void initState() {
    super.initState();
    _carregarPrecos(); // Carrega preços salvos do banco
  }

  Future<void> atualizarTela() async {
    await _carregarPrecos();
  }

  // Função para carregar preços do banco
  Future<void> _carregarPrecos() async {
    final config = await controller.db.getPrecosCombustivel();
    if (config != null) {
      _etanolController.text = config.precoEtanol
          .toStringAsFixed(2)
          .replaceAll('.', ',');
      _gasolinaController.text = config.precoGasolina
          .toStringAsFixed(2)
          .replaceAll('.', ',');
    }
    if (mounted) setState(() {});
  }

  void _atualizarUI() {
    if (mounted) setState(() {});
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
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: HeaderWidget(titulo: "Calculadora de\nAbastecimento"),
            ),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  double fontSize = constraints.maxWidth * 0.04;

                  return SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        smoothInput(
                          controller: _etanolController,
                          focusNode: _focusEtanol,
                          label: "Preço do Etanol (R\$)",
                          inputFormatters: [CurrencyInputFormatter()],
                        ),
                        const SizedBox(height: 12),
                        smoothInput(
                          controller: _gasolinaController,
                          label: "Preço da Gasolina (R\$)",
                          inputFormatters: [CurrencyInputFormatter()],
                        ),
                        const SizedBox(height: 12),
                        smoothInput(
                          controller: _valorAbastecerController,
                          label: "Valor a abastecer (R\$)",
                          inputFormatters: [CurrencyInputFormatter()],
                        ),
                        const SizedBox(height: 20),

                        /// BOTÕES
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
                                    color: Colors.white,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primary,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 14,
                                  ),
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
                                    color: Colors.white,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.appMainColor,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 14,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        /// RESUMO
                        if (controller.calculado &&
                            controller.resultado != null)
                          BlocoCard(
                            titulo: "Resumo Geral",
                            icone: Icons.local_gas_station,
                            cor: AppColors.primary,
                            conteudo: [
                              Text(
                                "Relação Etanol/Gasolina: ${controller.resultado!['relacao'].toStringAsFixed(2)}",
                              ),
                              Text.rich(
                                TextSpan(
                                  text: "Melhor pela regra do 0.7: ",
                                  style: const TextStyle(fontSize: 18),
                                  children: [
                                    TextSpan(
                                      text: controller.resultado!['melhor'],
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                        if (controller.calculado &&
                            controller.resultado != null) ...[
                          BlocoCard(
                            titulo:
                                "Com o valor abastecido (R\$ ${controller.resultado!['valor'].toStringAsFixed(1)})",
                            icone: Icons.directions_car,
                            cor: Colors.orange[800],
                            conteudo: [
                              Text(
                                "Etanol - Cidade: ${controller.resultado!['km']['etanolCidade'].toStringAsFixed(1)} km",
                              ),
                              Text(
                                "Etanol - Estrada: ${controller.resultado!['km']['etanolEstrada'].toStringAsFixed(1)} km",
                              ),
                              Text(
                                "Gasolina - Cidade: ${controller.resultado!['km']['gasolinaCidade'].toStringAsFixed(1)} km",
                              ),
                              Text(
                                "Gasolina - Estrada: ${controller.resultado!['km']['gasolinaEstrada'].toStringAsFixed(1)} km",
                              ),
                            ],
                          ),

                          /// CUSTO KM
                          BlocoCard(
                            titulo: "Custo por KM",
                            icone: Icons.speed,
                            cor: Colors.blue[800],
                            conteudo: [
                              Text(
                                "Etanol - Cidade: R\$ ${controller.resultado!['custoKm']['etanolCidade'].toStringAsFixed(2)}",
                              ),
                              Text(
                                "Etanol - Estrada: R\$ ${controller.resultado!['custoKm']['etanolEstrada'].toStringAsFixed(2)}",
                              ),
                              Text(
                                "Gasolina - Cidade: R\$ ${controller.resultado!['custoKm']['gasolinaCidade'].toStringAsFixed(2)}",
                              ),
                              Text(
                                "Gasolina - Estrada: R\$ ${controller.resultado!['custoKm']['gasolinaEstrada'].toStringAsFixed(2)}",
                              ),
                            ],
                          ),

                          BlocoCard(
                            titulo: "Economia no valor abastecido",
                            icone: Icons.savings,
                            cor: Colors.purple[800],
                            conteudo: [
                              Text(
                                "Cidade: ${controller.resultado!['economia']['cidadeKm'].toStringAsFixed(1)} km → "
                                "R\$ ${controller.resultado!['economia']['cidadeR'].toStringAsFixed(2)}",
                              ),
                              Text(
                                "Estrada: ${controller.resultado!['economia']['estradaKm'].toStringAsFixed(1)} km → "
                                "R\$ ${controller.resultado!['economia']['estradaR'].toStringAsFixed(2)}",
                              ),
                            ],
                          ),
                          rodapeBonito(),
                        ],
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
