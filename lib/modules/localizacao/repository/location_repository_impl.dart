import 'package:fuelprice/modules/localizacao/datasource/geolocator_datasource.dart';
import 'package:fuelprice/modules/localizacao/entity/location_entity.dart';
import 'package:fuelprice/modules/localizacao/model/location_model.dart';
import 'package:fuelprice/modules/localizacao/repository/location_repository.dart';

class LocationRepositoryImpl
    implements LocationRepository {

  final GeolocatorDatasource datasource;

  LocationRepositoryImpl(this.datasource);

  @override
  Future<LocationEntity> getCurrentLocation() async {
    final position =
        await datasource.getCurrentLocation();

    return LocationModel(
      latitude: position.latitude,
      longitude: position.longitude,
      accuracy: position.accuracy,
    );
  }
}