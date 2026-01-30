import '../../domain/entities/vehicle_info.dart';
import '../../domain/repositories/vehicle_repository.dart';

class GetVehicleInfoService {
  final VehicleRepository repository;

  GetVehicleInfoService(this.repository);

  Future<VehicleInfo> call(String plate) {
    return repository.getVehicleInfo(plate);
  }
}
