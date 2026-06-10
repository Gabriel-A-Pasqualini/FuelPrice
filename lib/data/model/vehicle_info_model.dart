
import 'package:fuelprice/domain/entities/vehicle_entity.dart';

class VehicleInfoModel extends VehicleEntity {
  VehicleInfoModel(super.data);

  factory VehicleInfoModel.fromMap(Map<String, String?> map) {
    return VehicleInfoModel(map);
  }
}