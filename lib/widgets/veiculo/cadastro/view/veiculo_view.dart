import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fuelprice/data/classes/ClassUpperCaseTextFormatter.dart';
import 'package:fuelprice/helper/colors_helper.dart';
import 'package:fuelprice/services/vehicle_webview_scraper.dart';
import 'package:fuelprice/widgets/index/view/widgets/header_widget.dart';
import 'package:fuelprice/widgets/veiculo/cadastro/controller/veiculo_controller.dart';
import 'package:fuelprice/widgets/calculadora/input/smooth_input.dart';

class VeiculoWidget extends StatefulWidget {
  const VeiculoWidget({super.key});

  @override
  State<VeiculoWidget> createState() => _VeiculoWidgetState();
}

class _VeiculoWidgetState extends State<VeiculoWidget> {
  final VeiculoController controller = VeiculoController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appColor = AppColors.appMainColor;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: HeaderWidget(
                titulo: "Cadastro de Veículo",
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                    TextFormField(
                      controller: controller.placaController,
                      textCapitalization: TextCapitalization.characters,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z0-9]')),
                        UpperCaseTextFormatter(),
                      ],
                      decoration: const InputDecoration(
                        labelText: "Placa do veículo",
                        hintText: "ABC1D23",
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) =>
                          value == null || value.isEmpty ? "Informe a placa" : null,
                    ),


                      const SizedBox(height: 12),

                      /// BUSCAR PLACA
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          icon: const Icon(Icons.search),
                          label: const Text("Buscar pela placa"),
                          onPressed: () async {
                            if (controller.placaController.text.isEmpty) return;

                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => VehicleWebViewScraper(
                                  plate: controller.placaController.text.trim(),
                                  onResult: (data) {
                                    controller.preencherDadosPorPlaca(data);
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                            );

                            setState(() {});
                          },
                        ),
                      ),

                      smoothInput(
                        controller: controller.modeloController,
                        label: "Modelo",
                      ),
                      
                      if (controller.veiculoPlaca != null) ...[
                        const SizedBox(height: 16),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _infoRow(
                                'Veículo',
                                controller.veiculoPlaca!.marcaModelo,
                              ),
                              _infoRow(
                                'Ano',
                                controller.veiculoPlaca!.ano,
                              ),
                              _infoRow(
                                'Cor',
                                controller.veiculoPlaca!.cor,
                              ),
                            ],
                          ),
                        ),
                      ],

                      const SizedBox(height: 24),

                      /// LITROS NO TANQUE
                      smoothInput(
                        controller: controller.litrosController,
                        label: "Litros no tanque (L)",
                      ),

                      const SizedBox(height: 24),

                      /// GASOLINA
                      Text(
                        "Consumo com Gasolina (km/L)",
                        style: theme.textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 8),

                      Row(
                        children: [
                          Expanded(
                            child: smoothInput(
                              controller:
                                  controller.gasolinaCidadeController,
                              label: "Cidade",
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: smoothInput(
                              controller:
                                  controller.gasolinaEstradaController,
                              label: "Estrada",
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      /// ETANOL
                      Text(
                        "Consumo com Etanol (km/L)",
                        style: theme.textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 8),

                      Row(
                        children: [
                          Expanded(
                            child: smoothInput(
                              controller: controller.etanolCidadeController,
                              label: "Cidade",
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: smoothInput(
                              controller:
                                  controller.etanolEstradaController,
                              label: "Estrada",
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 32),

                      /// SALVAR
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.save, color: Colors.white),
                          label: const Text(
                            "Salvar Veículo",
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: appColor,
                            padding:
                                const EdgeInsets.symmetric(vertical: 14),
                            textStyle: const TextStyle(fontSize: 18),
                          ),
                          onPressed: () => controller.salvar(context),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Helper visual
  Widget _infoRow(String label, String? value) {
    if (value == null || value.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}
