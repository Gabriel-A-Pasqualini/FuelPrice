
import 'package:fuelprice/helper/colors_helper.dart';
import 'package:fuelprice/widgets/calculadora/view/calculadora_view.dart';
import 'package:fuelprice/widgets/localizacao/view/maps_view.dart';
import 'package:fuelprice/widgets/veiculo/view/veiculo_view.dart';
import 'package:flutter/material.dart';

import '../tracking/view/tracking_view.dart';


class IndexPage extends StatelessWidget {
  const IndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    final appColor = AppColors.appMainColor;
    final carro = "HB20 SENSE 2021";

    return Scaffold(
      appBar: AppBar(
        title: LayoutBuilder(
          builder: (context, constraints) {
            double fontSize = constraints.maxWidth * 0.06; // 8% da largura disponível
            return Text(
              "Calculadora de Abastecimento\n$carro",
              style: TextStyle(
                fontWeight: FontWeight.bold, 
                fontSize: fontSize,
                color: Colors.white
              ),
            );
          },
        ),
        backgroundColor: appColor,
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: const Text("Gabriel Pasqualini"),
              accountEmail: const Text("gabriel@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person, size: 40, color: appColor),
              ),
              decoration: BoxDecoration(color: appColor),
            ),
            ListTile(
              leading: const Icon(Icons.local_gas_station_rounded),
              title: const Text("Calculadora"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const CalculadoraCombustivelWidget()));
              },
            ),            
            ListTile(
              leading: const Icon(Icons.garage),
              title: const Text("Veículos"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const VeiculoWidget()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.location_on),
              title: const Text("Maps"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const MapsWidget()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.track_changes),
              title: const Text("Tracking"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const TrackingMapaPage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text("Sair"),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}
