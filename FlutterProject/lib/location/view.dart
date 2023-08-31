import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/location/controller.dart';
import 'package:weather_app/theme_custom.dart';

class LocationView extends StatefulWidget {
  const LocationView({super.key});

  @override
  State<LocationView> createState() => _LocationViewState();
}

class _LocationViewState extends State<LocationView> {
  List<String> searchHistory = <String>[];
  final LocationController locController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12),
      child: Builder(
        builder: (context) {
          return SearchAnchor.bar(
            barHintText: "Search a location",
            suggestionsBuilder: (BuildContext context, SearchController controller) {
              if (controller.text.isEmpty) {
                if (searchHistory.isNotEmpty) {
                  return getHistoryList(controller);
                }
                return <Widget>[Center(child: Text('No search history.', style: TextStyle(color: ThemeCustom.colorScheme(context).outline)))];
              }
              return getSuggestions(controller);
            },
          );
        }
      ),
    );
  }

  Iterable<Widget> getHistoryList(SearchController controller) {
    return searchHistory.map(
      (String search) => ListTile(
        leading: const Icon(Icons.history),
        title: Text(search),
        trailing: IconButton(
          icon: const Icon(Icons.call_missed),
          onPressed: () {
            controller.text = search;
            controller.selection = TextSelection.collapsed(offset: controller.text.length);
          },
        ),
      ),
    );
  }

  Iterable<Widget> getSuggestions(SearchController controller) {
    final String input = controller.value.text;
    return locController.availableLocationNames().where((String name) => name.toLowerCase().contains(input.toLowerCase())).map(
          (String filteredName) => ListTile(
            leading: const Icon(Icons.location_on_sharp),
            title: Text(filteredName),
            onTap: () {
              controller.closeView(filteredName);
              handleSelection(filteredName);
            },
          ),
        );
  }

  void handleSelection(String selectedLocation) {
    setState(() {
      locController.updateSelectedLocationFromName(selectedLocation);
      if (searchHistory.length >= 5) {
        searchHistory.removeLast();
      }
      searchHistory.insert(0, selectedLocation);
    });
  }
}
