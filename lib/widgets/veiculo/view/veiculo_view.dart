import 'package:FuelPrice/helper/colors_helper.dart';
import 'package:FuelPrice/widgets/veiculo/controller/veiculo_controller.dart';
import 'package:flutter/material.dart';

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
      appBar: AppBar(
        title: FittedBox(
          fit: BoxFit.scaleDown,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Rastreamento de percurso",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Container(
                width: 4,
                height: 24,
                color: Colors.green,
                margin: const EdgeInsets.only(left: 28),
              ),
            ],
          ),
        ),
        backgroundColor: appColor,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Nome do veículo
              TextFormField(
                controller: controller.nomeController,
                decoration: const InputDecoration(
                  labelText: "Nome do veículo",
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? "Informe o nome do veículo" : null,
              ),
              const SizedBox(height: 16),

              // Litros no tanque
              TextFormField(
                controller: controller.litrosController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Litros no tanque",
                  border: OutlineInputBorder(),
                  suffixText: "L",
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? "Informe a capacidade do tanque" : null,
              ),
              const SizedBox(height: 24),

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
                    child: TextFormField(
                      controller: controller.gasolinaCidadeController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: "Cidade",
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) =>
                          value == null || value.isEmpty ? "Informe o consumo" : null,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      controller: controller.gasolinaEstradaController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: "Estrada",
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) =>
                          value == null || value.isEmpty ? "Informe o consumo" : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

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
                    child: TextFormField(
                      controller: controller.etanolCidadeController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: "Cidade",
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) =>
                          value == null || value.isEmpty ? "Informe o consumo" : null,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      controller: controller.etanolEstradaController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: "Estrada",
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) =>
                          value == null || value.isEmpty ? "Informe o consumo" : null,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 32),

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
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                  onPressed: () => controller.salvar(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
