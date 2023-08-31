import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/location/controller.dart';

import '../location/view.dart';

class HubScreen extends StatelessWidget {
  HubScreen({super.key});

  final LocationController locController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const LocationView(),
            const Text("Selected Location:"),
            Obx(() => Text(locController.selectedLocation?.name ?? "No location selected")),
          ],
        ),
      ),
    );
  }
}
