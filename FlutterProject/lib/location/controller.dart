// A controller named LocationController to handle the search of a location by the user.
// Uses get provider to manage the state of the location search.

import 'package:get/get.dart';
import 'package:weather_app/location/data.dart';
import 'package:weather_app/location/model.dart';
import 'package:weather_app/weather/controller.dart';

class LocationController extends GetxController {
  final _selectedLocation = Rx<Location?>(null);

  updateSelectedLocation(Location? location) {
    _selectedLocation.value = location;

    if (location == null) return;
    final WeatherController weatherController = Get.find();
    weatherController.getWeatherForLocation(location);
  }

  Location? get selectedLocation => _selectedLocation.value;

  List<Location> availableLocations() {
    return locationData;
  }

  List<String> availableLocationNames() {
    return availableLocations().map((e) => e.name).toList();
  }

  Location locationFromName(String name) {
    return availableLocations().firstWhere((element) => element.name == name);
  }

  void updateSelectedLocationFromName(String selectedLocation) {
    updateSelectedLocation(locationFromName(selectedLocation));
  }
}
