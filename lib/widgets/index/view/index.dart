import 'package:flutter/material.dart';
import 'package:fuelprice/helper/colors_helper.dart';
import 'package:fuelprice/widgets/calculadora/view/calculadora_view.dart';
import 'package:fuelprice/widgets/index/controller/index_controller.dart';
import 'package:fuelprice/widgets/index/view/widgets/fuel_compare_card.dart';
import 'package:fuelprice/widgets/index/view/widgets/fuel_gauge_widget.dart';
import 'package:fuelprice/widgets/index/view/widgets/fuel_summary_card.dart';
import 'package:fuelprice/widgets/index/view/widgets/header_widget.dart';
import 'package:fuelprice/widgets/tracking/view/tracking_view.dart';
import 'package:fuelprice/widgets/veiculo/cadastro/view/veiculo_view.dart';
import 'package:fuelprice/widgets/veiculo/listagem/veiculos_list_view.dart.dart';

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
    carregaDados();
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
                    controller.carregarPrecos();
                    _abrirAjustes(context, controller);
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
          if (index == 3) {
            _abrirMenuVeiculos();
            return;
          }

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
            label: "Veiculos",
          ),          
          BottomNavigationBarItem(
            icon: Icon(Icons.more_horiz),
            label: "Mais",
          ),
        ],
      ),
    );
  }

  void _abrirMenuVeiculos() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.list),
                title: const Text("Listar veículos"),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const VeiculosListView(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.add),
                title: const Text("Cadastrar veículo"),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const VeiculoWidget(),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _abrirAjustes(
    BuildContext context,
    IndexController controller,
  ) {    
    final kmController =
        TextEditingController(text: controller.kmRodadoDia.toString());
    final litrosController =
        TextEditingController(text: controller.litrosAtuais.toString());
    final etanolController =
        TextEditingController(text: controller.precoEtanol.toString());
    final gasolinaController =
        TextEditingController(text: controller.precoGasolina.toString());

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Text(
          'Configurações',
          textAlign: TextAlign.center,
        ),
        content: SingleChildScrollView(
          child: Column(
            children: [
              _input('Km rodado por dia', kmController),
              _input('Litros atuais no tanque', litrosController),
              _input('Preço do Etanol', etanolController),
              _input('Preço da Gasolina', gasolinaController),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () async {
              await controller.salvarConfiguracoes(
                kmRodadoDia: double.parse(kmController.text.replaceAll(',', '.')),
                litrosAtuais: double.parse(litrosController.text.replaceAll(',', '.')),
                precoEtanol: double.parse(etanolController.text.replaceAll(',', '.')),
                precoGasolina: double.parse(gasolinaController.text.replaceAll(',', '.')),
              );

              controller.carregarDados();

              Navigator.pop(context);
            },
            child: const Text('Salvar'),
          ),
        ],
      ),
    );
  }

  Widget _input(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  void carregaDados(){
    controller.carregarConfiguracoes();
    controller.carregarDados();
    controller.carregarPrecos();    
  }
}
