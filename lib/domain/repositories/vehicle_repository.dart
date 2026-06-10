import 'package:fuelprice/domain/entities/vehicle_entity.dart';

abstract class VehicleRepository {
  Future<VehicleEntity> getVehicleInfo(String plate);
}