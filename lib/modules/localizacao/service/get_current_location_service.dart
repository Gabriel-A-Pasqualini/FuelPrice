import 'package:fuelprice/modules/localizacao/entity/location_entity.dart';
import 'package:fuelprice/modules/localizacao/repository/location_repository.dart';

class GetCurrentLocationService {
  final LocationRepository repository;

  GetCurrentLocationService(this.repository);

  Future<LocationEntity> call() {
    return repository.getCurrentLocation();
  }
}