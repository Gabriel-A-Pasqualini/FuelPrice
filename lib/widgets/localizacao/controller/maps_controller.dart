import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class MapsController {
  Position? position;
  String? erro;
  bool loading = false;

  /// Obter localização atual
  Future<void> obterLocalizacao(VoidCallback onUpdate) async {
    loading = true;
    erro = null;
    onUpdate();

    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw 'Serviço de localização desativado.';
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw 'Permissão de localização negada.';
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw 'Permissão de localização negada permanentemente.';
      }

      position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
    } catch (e) {
      erro = e.toString();
    } finally {
      loading = false;
      onUpdate();
    }
  }
}
