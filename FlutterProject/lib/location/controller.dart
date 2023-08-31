// A controller named LocationController to handle the search of a location by the user.
// Uses get provider to manage the state of the location search.

import 'package:get/get.dart';
import 'package:weather_app/location/data.dart';
import 'package:weather_app/location/model.dart';

class LocationController {
  LocationController() {
    instance = this; // Singleton pattern
  }

  static late final LocationController instance; // For the singleton pattern

  final _selectedLocation = Rx<Location?>(null);

  static updateSelectedLocation(Location? location) {
    instance._selectedLocation.value = location;
  }

  static Location? get selectedLocation => instance._selectedLocation.value;

  static List<Location> availableLocations() {
    return locationData;
  }

  static List<String> availableLocationNames() {
    return availableLocations().map((e) => e.name).toList();
  }

  static Location locationFromName(String name) {
    return availableLocations().firstWhere((element) => element.name == name);
  }

  static void updateSelectedLocationFromName(String selectedLocation) {
    updateSelectedLocation(locationFromName(selectedLocation));
  }
}
