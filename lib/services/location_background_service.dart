import 'dart:async';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:geolocator/geolocator.dart';

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  // 🚨 1️⃣ SE FOR ANDROID → VIRA FOREGROUND IMEDIATAMENTE
  if (service is AndroidServiceInstance) {
    service.setForegroundNotificationInfo(
      title: "Rastreamento ativo",
      content: "Sua localização está sendo monitorada",
    );
  }
  
  service.on('stopService').listen((event) {
    service.stopSelf();
  });

  // 📍 Agora SIM pode usar Timer e GPS
  Timer.periodic(const Duration(seconds: 5), (timer) async {
    try {
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      service.invoke('location', {
        'lat': position.latitude,
        'lng': position.longitude,
      });
    } catch (e) {
      // Evita crash silencioso
      print('Erro no tracking em background: $e');
    }
  });
}
