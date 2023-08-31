import 'package:flutter/material.dart';

import '../location/view.dart';

class HubScreen extends StatelessWidget {
  const HubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: const LocationView(),
      ),
    );
  }
}
