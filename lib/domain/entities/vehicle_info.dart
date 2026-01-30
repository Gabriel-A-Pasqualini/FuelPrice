import 'package:fuelprice/domain/repositories/vehicle_repository.dart';

abstract class VehicleRepository {
  Future<VehicleInfo> getVehicleInfo(String plate);
}
