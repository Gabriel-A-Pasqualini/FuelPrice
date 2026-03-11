import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fuelprice/helper/colors_helper.dart';
import 'package:fuelprice/helper/currency_input_formatter.dart';
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
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  int _currentIndex = 0;
  late final IndexController controller;

  final GlobalKey<CalculadoraCombustivelWidgetState> calculadoraKey =
      GlobalKey();

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    controller = IndexController();
    carregaDados();

    _pages = [
      _homePage(),
      CalculadoraCombustivelWidget(key: calculadoraKey),
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
          return const Center(child: CircularProgressIndicator());
        }

        return SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.04,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: HeaderWidget(
                          titulo: 'Olá, ${controller.nomeUsuario}!',
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.settings, color: Colors.grey),
                        onPressed: () {
                          _abrirAjustes(context, controller);
                        },
                      ),
                    ],
                  ),
                ),

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
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: (index) async {
          if (index == 3) {
            _abrirMenuVeiculos();
            return;
          }

          setState(() => _currentIndex = index);

          if (index == 1) {
            await calculadoraKey.currentState?.atualizarTela();
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Início"),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_gas_station),
            label: "Abastecer",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: "Mapas"),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_car_rounded),
            label: "Veículos",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: "Mais"),
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
        return SafeArea(
          child: Padding(
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
                      MaterialPageRoute(builder: (_) => const VeiculoWidget()),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _abrirAjustes(BuildContext context, IndexController controller) async {
    await controller.carregarConfiguracoes();
    await controller.carregarPrecos();

    final kmController = TextEditingController(
      text: controller.kmRodadoDia.toString().replaceAll('.', ','),
    );

    final litrosController = TextEditingController(
      text: controller.litrosAtuais.toString().replaceAll('.', ','),
    );

    final etanolController = TextEditingController(
      text: controller.precoEtanol.toString().replaceAll('.', ','),
    );

    final gasolinaController = TextEditingController(
      text: controller.precoGasolina.toString().replaceAll('.', ','),
    );

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Configurações', textAlign: TextAlign.center),
        content: SingleChildScrollView(
          child: Column(
            children: [
              _input('Km rodado por dia', kmController),
              _input(
                'Litros atuais no tanque',
                litrosController,
                inteiro: true,
              ),
              _input('Preço do Etanol', etanolController, moeda: true),
              _input('Preço da Gasolina', gasolinaController, moeda: true),
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
              try {
                await controller.salvarConfiguracoes(
                  kmRodadoDia: double.parse(
                    kmController.text.replaceAll(',', '.'),
                  ),
                  litrosAtuais: double.parse(
                    litrosController.text.replaceAll(',', '.'),
                  ),
                  precoEtanol: _parseCurrency(etanolController.text),
                  precoGasolina: _parseCurrency(gasolinaController.text),
                );

                Navigator.pop(context);
                await _recarregarApp();
              } catch (e) {
                // Se o usuário digitou algo inválido
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Erro ao salvar: valor inválido'),
                  ),
                );
              }
            },
            child: const Text('Salvar'),
          ),
        ],
      ),
    );
  }

  double _parseCurrency(String value) {
    final cleaned = value.replaceAll(',', '.'); // vírgula -> ponto
    return double.tryParse(cleaned) ?? 0;
  }

  Widget _input(
    String label,
    TextEditingController controller, {
    bool moeda = false,
    bool inteiro = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.numberWithOptions(decimal: !inteiro),
        inputFormatters: moeda
            ? [CurrencyInputFormatter()]
            : inteiro
            ? [FilteringTextInputFormatter.digitsOnly]
            : [FilteringTextInputFormatter.allow(RegExp(r'[0-9,]'))],
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  Future<void> _recarregarApp() async {
    await controller.carregarConfiguracoes();
    await controller.carregarDados();
    await controller.carregarPrecos();

    if (mounted) setState(() {});
  }

  void carregaDados() {
    controller.carregarConfiguracoes();
    controller.carregarDados();
    controller.carregarPrecos();
  }
}
