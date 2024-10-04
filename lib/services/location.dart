import 'package:geolocator/geolocator.dart';

class Location{
  double latitude=1;
  double longitude=1;

  Future<void> getLocation () async {
    try {
      LocationPermission permission = await Geolocator.requestPermission();
      final LocationSettings locationSettings = LocationSettings(
        accuracy: LocationAccuracy.medium,
        distanceFilter: 100,
      );
      Position position =
          await Geolocator.getCurrentPosition(locationSettings: locationSettings);
      print(position);

      latitude=position.latitude;
      longitude=position.longitude;
    }
    catch (e) {
      print(e);
    }
  }

}