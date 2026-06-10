import 'package:fuelprice/domain/entities/vehicle_entity.dart';
import 'package:fuelprice/domain/repositories/vehicle_repository.dart';

class GetVehicleInfoService {
  final VehicleRepository repository;

  GetVehicleInfoService(this.repository);

  Future<VehicleEntity> call(String plate) {
    return repository.getVehicleInfo(plate);
  }
}