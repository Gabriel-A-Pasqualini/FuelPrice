import 'package:fuelprice/modules/localizacao/entity/location_entity.dart';
import 'package:fuelprice/modules/localizacao/service/get_current_location_service.dart';

class MapsController {
  final GetCurrentLocationService service;

  MapsController(this.service);

  LocationEntity? position;
  String? error;
  bool loading = false;

  Future<void> getLocation(
    Function() onUpdate,
  ) async {
    loading = true;
    error = null;

    onUpdate();

    try {
      position = await service();
    } catch (e) {
      error = e.toString();
    }

    loading = false;
    onUpdate();
  }
}