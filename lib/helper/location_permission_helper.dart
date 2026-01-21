import 'package:geolocator/geolocator.dart';

class LocationPermissionHelper {
  static Future<void> checkAndRequestPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('GPS desativado');
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception(
        'Permissão de localização negada permanentemente. Vá em Configurações.'
      );
    }

    if (permission == LocationPermission.denied) {
      throw Exception('Permissão de localização negada');
    }
  }
}
