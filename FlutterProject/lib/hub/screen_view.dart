import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/location/controller.dart';
import 'package:weather_app/weather/controller.dart';
import 'package:weather_app/weather/view.dart';

import '../location/view.dart';

class HubScreen extends StatelessWidget {
  HubScreen({super.key});

  final LocationController locController = Get.find();
  final WeatherController weatherController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(
          () => ListView(
            children: [
              const SizedBox(height: 20),
              const LocationView(),
              const SizedBox(height: 20),
              ...WeatherView.allCards(context, weatherController),
            ],
          ),
        ),
      ),
    );
  }
}
