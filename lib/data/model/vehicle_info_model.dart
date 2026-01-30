import 'package:fuelprice/domain/repositories/vehicle_repository.dart';

class VehicleInfoModel extends VehicleInfo {
  VehicleInfoModel(Map<String, String?> data) : super(data);

  factory VehicleInfoModel.fromMap(Map<String, String?> map) {
    return VehicleInfoModel(map);
  }
}
