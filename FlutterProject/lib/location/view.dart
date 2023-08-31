import 'package:flutter/material.dart';
import 'package:weather_app/location/controller.dart';
import 'package:weather_app/theme_custom.dart';

class LocationView extends StatefulWidget {
  const LocationView({super.key});

  @override
  State<LocationView> createState() => _LocationViewState();
}

class _LocationViewState extends State<LocationView> {
  List<String> searchHistory = <String>[];

  @override
  Widget build(BuildContext context) {
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
    return LocationController.availableLocationNames().where((String name) => name.contains(input)).map(
          (String filteredName) => ListTile(
            leading: const Icon(Icons.add_location_rounded),
            title: Text(filteredName),
            trailing: IconButton(
              icon: const Icon(Icons.call_missed),
              onPressed: () {
                controller.text = filteredName;
                controller.selection = TextSelection.collapsed(offset: controller.text.length);
              },
            ),
            onTap: () {
              controller.closeView(filteredName);
              handleSelection(filteredName);
            },
          ),
        );
  }

  void handleSelection(String selectedLocation) {
    setState(() {
      LocationController.updateSelectedLocationFromName(selectedLocation);
      if (searchHistory.length >= 5) {
        searchHistory.removeLast();
      }
      searchHistory.insert(0, selectedLocation);
    });
  }
}
