import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class TrackingController {
  final FlutterBackgroundService _service = FlutterBackgroundService();
  final MapController mapController = MapController();

  final List<LatLng> trajeto = [];
  StreamSubscription? _subscription;

  bool trackingAtivo = false;

  /// GARANTIR PERMISSÃO DE LOCALIZAÇÃO
  Future<bool> garantirPermissao() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return false;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      await Geolocator.openAppSettings();
      return false;
    }

    return permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse;
  }

  /// INICIAR TRACKING
  Future<void> iniciarTracking(VoidCallback onUpdate) async {
    final permitido = await garantirPermissao();
    if (!permitido) return;

    await _service.startService();
    _escutarLocalizacao(onUpdate);

    trackingAtivo = true;
    onUpdate();
  }

  void _escutarLocalizacao(VoidCallback onUpdate) {
    _subscription?.cancel();
    _subscription = _service.on('location').listen((event) {
      if (event == null) return;

      final ponto = LatLng(
        event['lat'] as double,
        event['lng'] as double,
      );

      trajeto.add(ponto);

      mapController.move(ponto, 17);
      onUpdate();
    });
  }

  /// PARAR TRACKING
  void pararTracking(VoidCallback onUpdate) {
    _service.invoke('stopService');
    _subscription?.cancel();

    trackingAtivo = false;
    onUpdate();
  }

  void dispose() {
    _subscription?.cancel();
  }
}
