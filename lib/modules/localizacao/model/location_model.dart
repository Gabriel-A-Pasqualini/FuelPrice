
import 'package:fuelprice/modules/localizacao/entity/location_entity.dart';

class LocationModel extends LocationEntity {
  LocationModel({
    required super.latitude,
    required super.longitude,
    required super.accuracy,
  });

  factory LocationModel.fromGeolocator({
    required double latitude,
    required double longitude,
    required double accuracy,
  }) {
    return LocationModel(
      latitude: latitude,
      longitude: longitude,
      accuracy: accuracy,
    );
  }
}