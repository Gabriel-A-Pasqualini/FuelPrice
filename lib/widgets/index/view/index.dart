import 'package:flutter/material.dart';
import 'package:fuelprice/helper/colors_helper.dart';
import 'package:fuelprice/widgets/calculadora/view/calculadora_view.dart';
import 'package:fuelprice/widgets/index/controller/index_controller.dart';
import 'package:fuelprice/widgets/index/view/widgets/fuel_compare_card.dart';
import 'package:fuelprice/widgets/index/view/widgets/fuel_gauge_widget.dart';
import 'package:fuelprice/widgets/index/view/widgets/fuel_summary_card.dart';
import 'package:fuelprice/widgets/index/view/widgets/header_widget.dart';
import 'package:fuelprice/widgets/tracking/view/tracking_view.dart';
import 'package:fuelprice/widgets/veiculo/view/veiculo_view.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => _IndexPage();
}

class _IndexPage extends State<IndexPage> {
  int _currentIndex = 0;
  late final IndexController controller;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();

    controller = IndexController();
    controller.carregarDados();
    controller.carregarPrecos();

    _pages = [
      _homePage(),
      const CalculadoraCombustivelWidget(),
      const TrackingMapaPage(),
      const VeiculoWidget(),
      const Center(child: Text("Mais")),
    ];
  }

  Widget _homePage() {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, _) {
        if (controller.carregando) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [              
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: HeaderWidget(
                    titulo: 'Olá, ${controller.nomeUsuario}!'
                  ),
                ),

                IconButton(
                  icon: const Icon(Icons.settings, color: Colors.grey),
                  onPressed: () {
                    _abrirAjusteTanque(context, controller);
                  },
                ),                   
                const SizedBox(height: 10),               

                FuelGaugeWidget(
                  nivel: controller.nivelTanqueAtual,
                  modeloCarro: controller.modeloCarro,
                  porcentagemTanque: controller.porcentagemTanque,
                ),

                const SizedBox(height: 7),

                FuelSummaryCard(
                  diasRestantes: controller.diasRestantes,
                  estimativa: controller.estimativaAbastecimento,
                ),

                const SizedBox(height: 16),
                FuelCompareCard(
                  alcoolPreco: controller.precoEtanol,
                  gasolinaPreco: controller.precoGasolina, 
                  litrosTanque: controller.capacidadeTanque,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() => _currentIndex = index);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Início",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_gas_station),
            label: "Abastecer",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: "Mapas",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_car_rounded),
            label: "Mapas",
          ),          
          BottomNavigationBarItem(
            icon: Icon(Icons.more_horiz),
            label: "Mais",
          ),
        ],
      ),
    );
  }

  void _abrirAjusteTanque(
    BuildContext context,
    IndexController controller,
  ) {
    final TextEditingController litrosController =
        TextEditingController(text: controller.litrosAtuais.toString());

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            'Quantidade atual no tanque',
            textAlign: TextAlign.center,
          ),
          content: TextField(
            controller: litrosController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Litros atuais',
              hintText:
                  'Máx: ${controller.capacidadeTanque.toStringAsFixed(0)} L',
              border: const OutlineInputBorder(),
            ),
          ),
          actionsAlignment: MainAxisAlignment.spaceBetween,
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                final litros = double.tryParse(litrosController.text);

                controller.carregarPrecos();

                if (litros != null) {
                  controller.atualizarLitrosAtuais(litros);
                  Navigator.pop(context);
                }
              },
              child: const Text('Salvar'),
            ),
          ],
        );
      },
    );
  }


}
