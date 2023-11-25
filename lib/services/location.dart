import 'package:geolocator/geolocator.dart';

class Location {
  double? latitude, longtitude;

  Future<void> getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);

    latitude = position.latitude;
    longtitude = position.longitude;
  }
}
