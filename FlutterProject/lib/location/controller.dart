// A controller named LocationController to handle the search of a location by the user.
// Uses get provider to manage the state of the location search.

import 'package:get/get.dart';
import 'package:weather_app/location/data.dart';
import 'package:weather_app/location/model.dart';
import 'package:weather_app/weather/controller.dart';

class LocationController extends GetxController {
  final _selectedLocation = Rx<Location?>(null);

  // Sets the selected location by the user
  updateSelectedLocation(Location? location) {
    if (_selectedLocation.value?.name == location?.name) return;
    _selectedLocation.value = location;

    if (location == null) return;
    final WeatherController weatherController = Get.find();
    weatherController.getWeatherForLocation(location);
  }

  Location? get selectedLocation => _selectedLocation.value;

  // Returns a list of all available locations
  List<Location> availableLocations() {
    // where name is not repeated
    List<Location> filteredData = [];
    for (Location location in locationData) {
      if (filteredData.where((element) => element.name == location.name).isEmpty) {
        filteredData.add(location);
      }
    }

    return filteredData;
  }

  // Returns a list of all available location names
  List<String> availableLocationNames() {
    return availableLocations().map((e) => e.name).toList();
  }

  // Returns a location from a given name
  Location locationFromName(String name) {
    return availableLocations().firstWhere((element) => element.name.toLowerCase() == name.toLowerCase());
  }

  // Updates the selected location from a given name
  void updateSelectedLocationFromName(String selectedLocation) {
    updateSelectedLocation(locationFromName(selectedLocation));
  }
}
