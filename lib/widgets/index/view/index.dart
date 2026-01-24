import 'package:flutter/material.dart';
import 'package:fuelprice/helper/colors_helper.dart';
import 'package:fuelprice/widgets/calculadora/view/calculadora_view.dart';
import 'package:fuelprice/widgets/index/view/test/fuel_compare_card.dart';
import 'package:fuelprice/widgets/index/view/test/fuel_gauge_widget.dart';
import 'package:fuelprice/widgets/index/view/widgets/fuel_summary_card.dart';
import 'package:fuelprice/widgets/index/view/widgets/header_widget.dart';
import 'package:fuelprice/widgets/tracking/view/tracking_view.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => _IndexPage();
}

class _IndexPage extends State<IndexPage> {
  int _currentIndex = 0;
  String nome = "Gabriel";

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();

    _pages = [
      _homePage(),
      const CalculadoraCombustivelWidget(),
      const TrackingMapaPage(),
      const Center(child: Text("Mais")),
    ];
  }

  Widget _homePage() {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            HeaderWidget(
              titulo: 'Olá, $nome!',
            ),
            const SizedBox(height: 20),
            FuelGaugeWidget(
              nivel: 0.4,
              modeloCarro: "HB20 Sense 2021", 
              porcentagemTanque: 40,
            ),
            const SizedBox(height: 16),
            FuelSummaryCard(
              diasRestantes: 5,
              estimativa: 280,
            ),
            const SizedBox(height: 16),
            FuelCompareCard(),
          ],
        ),
      ),
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
            icon: Icon(Icons.more_horiz),
            label: "Mais",
          ),
        ],
      ),
    );
  }
}
