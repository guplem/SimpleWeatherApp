import 'package:flutter/material.dart';
import 'package:weather_app/theme_custom.dart';
import 'package:weather_app/weather/controller.dart';

class WeatherView {
  // Builds all weather related widgets
  static List<Widget> allCards(BuildContext context, WeatherController weatherController) {
    List<Widget> cards = [];
    if (weatherController.loading) cards.add(const LinearProgressIndicator());

    if (weatherController.weather == null) return cards;

    for (int i = 0; i < weatherController.weather!.times.length; i++) {
      cards.add(
        Card(
          child: Padding(
            padding: ThemeCustom.paddingInnerCard,
            child: Row(
              children: [
                const SizedBox(width: 10),
                Text("${weatherController.weather!.times[i].hour.toString().padLeft(2, '0')}:${weatherController.weather!.times[i].minute.toString().padLeft(2, '0')}", style: ThemeCustom.textTheme(context).titleMedium),
                const Spacer(),
                Column(
                  children: [
                    const Icon(Icons.water_drop),
                    Text("${weatherController.weather!.precipitations[i]}mm"),
                  ],
                ),
                const SizedBox(width: 20),
                Column(
                  children: [
                    const Icon(Icons.cloudy_snowing),
                    Text("${weatherController.weather!.precipitationProbabilities[i]}%"),
                  ],
                ),
                const SizedBox(width: 20),
                Column(
                  children: [
                    const Icon(Icons.sunny),
                    Text("${weatherController.weather!.temperatures[i]}ºC"),
                  ],
                ),
                const SizedBox(width: 5),
              ],
            ),
          ),
        ),
      );
    }

    return cards;
  }
}
