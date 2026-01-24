import 'package:fuelprice/widgets/index/view/widgets/header_widget.dart';
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
      backgroundColor: AppColors.background,
      body: Column(
        children: [SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: HeaderWidget(
              titulo: "Rastreamento de\npercurso",
            ),
          ),
        ),
          /// MAPA
          Expanded(
            child: FlutterMap(
              mapController: controller.mapController,
              options: const MapOptions(
                initialCenter: LatLng(-22.755703, -47.318630),
                initialZoom: 16,
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.seu.app',
                ),

                /// LINHA DO TRAJETO
                PolylineLayer(
                  polylines: [
                    Polyline(
                      points: controller.trajeto,
                      strokeWidth: 4,
                      color: AppColors.accentColor,
                    ),
                  ],
                ),

                /// MARCADOR ATUAL
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
          ),

          /// STATUS INFERIOR
          Container(
            padding: const EdgeInsets.all(12),
            width: double.infinity,
            color: Colors.grey.shade100,
            child: Text(
              controller.trajeto.isEmpty
                  ? "Aguardando localização..."
                  : "Pontos registrados: ${controller.trajeto.length}",
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),

      /// FAB
      floatingActionButton: !controller.trackingAtivo
          ? FloatingActionButton.extended(
              backgroundColor: AppColors.primary,
              icon: const Icon(Icons.play_arrow, color: Colors.white),
              label: const Text(
                "",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () => controller.iniciarTracking(_atualizarUI),
            )
          : FloatingActionButton(
              backgroundColor: Colors.red,
              child: const Icon(Icons.stop, color: Colors.white),
              onPressed: () => controller.pararTracking(_atualizarUI),
            ),
    );
  }
}
