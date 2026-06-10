

import 'package:fuelprice/modules/localizacao/entity/location_entity.dart';

abstract class LocationRepository {
  Future<LocationEntity> getCurrentLocation();
}