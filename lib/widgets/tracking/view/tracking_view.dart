import 'package:fuelprice/widgets/tracking/controller/tracking_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:fuelprice/helper/colors_helper.dart';

class TrackingMapaPage extends StatefulWidget {
  const TrackingMapaPage({super.key});

  @override
  State<TrackingMapaPage> createState() => _TrackingMapaPageState();
}

class _TrackingMapaPageState extends State<TrackingMapaPage> {
  final TrackingController controller = TrackingController();
  final appColor = AppColors.appMainColor;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _atualizarUI() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColor,
        centerTitle: true,
        title: const Text(
          "Rastreamento de percurso",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          if (controller.trackingAtivo)
            IconButton(
              icon: const Icon(Icons.stop_circle, color: Colors.white),
              tooltip: 'Parar rastreamento',
              onPressed: () => controller.pararTracking(_atualizarUI),
            )
        ],
      ),
      body: FlutterMap(
        mapController: controller.mapController,
        options: const MapOptions(
          initialCenter: LatLng(-22.755703, -47.318630),
          initialZoom: 16,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.seu.app',
          ),
          PolylineLayer(
            polylines: [
              Polyline(
                points: controller.trajeto,
                strokeWidth: 4,
                color: Colors.blue,
              ),
            ],
          ),
          MarkerLayer(
            markers: controller.trajeto.isEmpty
                ? []
                : [
                    Marker(
                      point: controller.trajeto.last,
                      width: 40,
                      height: 40,
                      child: const Icon(
                        Icons.my_location,
                        color: Colors.red,
                        size: 30,
                      ),
                    ),
                  ],
          ),
        ],
      ),
      floatingActionButton: !controller.trackingAtivo
          ? FloatingActionButton.extended(
              backgroundColor: appColor,
              icon: const Icon(Icons.play_arrow, color: Colors.white),
              label: const Text(
                "Iniciar rastreamento",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () => controller.iniciarTracking(_atualizarUI),
            )
          : null,
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(12),
        color: Colors.grey[100],
        child: Text(
          controller.trajeto.isEmpty
              ? "Aguardando localização..."
              : "Pontos registrados: ${controller.trajeto.length}",
          textAlign: TextAlign.center,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
