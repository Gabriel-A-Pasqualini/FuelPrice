import 'package:calculo_combustivel/widgets/localizacao/controller/maps_controller.dart';
import 'package:flutter/material.dart';
import 'package:calculo_combustivel/helper/mapa_localizacao_helper.dart';
import 'package:calculo_combustivel/helper/colors_helper.dart';

class MapsWidget extends StatefulWidget {
  const MapsWidget({super.key});

  @override
  State<MapsWidget> createState() => _MapsWidgetState();
}

class _MapsWidgetState extends State<MapsWidget> {
  final MapsController controller = MapsController();
  final appColor = AppColors.appMainColor;

  void _atualizarUI() {
    if (mounted) setState(() {});
  }

  Widget _cardTitulo(String titulo, IconData icone) {
    return Row(
      children: [
        Icon(icone, color: Colors.green[900]),
        const SizedBox(width: 8),
        Text(
          titulo,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.green[900],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColor,
        title: const Text(
          "Localização Atual",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _cardTitulo("Dados de Localização", Icons.location_on),
                    const SizedBox(height: 12),

                    if (controller.loading)
                      const Center(child: CircularProgressIndicator()),

                    if (controller.erro != null)
                      Text(
                        controller.erro!,
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 15,
                        ),
                      ),

                    if (controller.position != null) ...[
                      Text(
                        "Latitude: ${controller.position!.latitude.toStringAsFixed(6)}",
                        style: const TextStyle(fontSize: 16),
                      ),
                      Text(
                        "Longitude: ${controller.position!.longitude.toStringAsFixed(6)}",
                        style: const TextStyle(fontSize: 16),
                      ),
                      Text(
                        "Precisão: ${controller.position!.accuracy.toStringAsFixed(1)} m",
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 12),
                      mapaLocalizacao(
                        controller.position!.latitude,
                        controller.position!.longitude,
                      ),
                    ],
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            ElevatedButton.icon(
              onPressed: controller.loading
                  ? null
                  : () => controller.obterLocalizacao(_atualizarUI),
              icon: const Icon(Icons.my_location, color: Colors.white),
              label: const Text(
                "Obter localização",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: appColor,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 20),
            Divider(color: Colors.grey[400]),
            Text(
              "📍 A localização é utilizada apenas para fins informativos.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey[700],
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
