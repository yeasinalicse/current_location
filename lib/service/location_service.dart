import 'dart:async';

import 'package:current_location/model/UserLocation.dart';
import 'package:location/location.dart';


class LocationService {
  // Keep track of current Location
  UserLocation _currentLocation;
  Location location = Location();
  // Continuously emit location updates
  StreamController<UserLocation> _locationController =
      StreamController<UserLocation>.broadcast();

  LocationService() {
    location.requestPermission().then((granted) {
      if (granted == PermissionStatus.granted) {
        location.onLocationChanged.listen((locationData) {
          if (locationData != null) {
            try {
              _locationController.add(UserLocation(latitude: locationData.latitude, longitude: locationData.longitude,  )  );
            } on Exception catch (_) {
              print("throwing new error");
            }
          }
        });
      }
    });
  }
//  Stream<UserLocation> get locationStream => _locationController.stream;

  Future<UserLocation> getLocation() async {
    try {
      var userLocation = await location.getLocation();
      _currentLocation = UserLocation(
        latitude: userLocation.latitude,
        longitude: userLocation.longitude,
      );
    } catch (e) {
      _currentLocation = UserLocation(
        latitude: 0.0,
        longitude: 0.0,
      );
      print('Could not get the location: $e');
    }

    return _currentLocation;
  }
}
