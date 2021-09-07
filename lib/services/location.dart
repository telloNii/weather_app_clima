import 'package:geolocator/geolocator.dart';

class Location {
  double? latitude;
  double? longitude;

  Future<void> getCurrentLocation() async {
    try {
      await Geolocator.requestPermission();

      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      latitude = position.latitude;
      longitude = position.longitude;
      print(position);
      print(latitude);
      print(longitude);
    } catch (e) {
      print(e);
    }
  }
}
//
// LocationPermission permission = await Geolocator.checkPermission();
// LocationPermission permission = await Geolocator.requestPermission();
